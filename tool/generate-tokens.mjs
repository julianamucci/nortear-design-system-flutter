/**
 * generate-tokens.mjs — @nortear/ds-core → Dart.
 *
 * Lê `.ds-core/tokens/figma-variables.json` (DTCG, com hex já resolvido e um
 * mode por tema/densidade/escala) e emite classes Dart imutáveis, uma constante
 * por mode.
 *
 * Por que esta fonte e não os `.css`: o CSS carrega `calc()`, `hsl(var(--x))` e
 * cascade — resolver isso fora do navegador é reimplementar um motor de estilo.
 * O figma-variables.json já é o resultado resolvido, e é gerado a partir do
 * mesmo CSS por `scripts/build-figma-variables.mjs` no repo web. Um consumidor
 * nativo entra depois desse passo, não antes.
 *
 * Nem todo token atravessa como está. Três famílias chegam em sintaxe CSS e são
 * traduzidas para o tipo Dart equivalente — sem isso viriam como String inerte:
 *
 *   duration-*   número em ms      → Duration
 *   ease-*       cubic-bezier(…)   → Curve (Cubic / Curves.linear)
 *   Elevacao     box-shadow CSS    → List<BoxShadow>
 *
 * E uma família não atravessa: `letter-spacing` está em `em`, enquanto
 * TextStyle.letterSpacing do Flutter é em pixels lógicos. A conversão depende do
 * fontSize do contexto, então não cabe numa constante — o valor sai com sufixo
 * `Em` e quem multiplica é a camada de tema.
 *
 * Duas coleções ficam de fora inteiras (ver docs/guidelines/15-paridade-web-flutter.md):
 *   Camada    z-index não existe no Flutter — ordem é a árvore de widgets/Overlay
 *
 * O Dart emitido é COMMITADO. Assim `flutter pub get` não depende de Node, e o
 * clone é reproduzível. `--check` falha se o commitado estiver defasado.
 *
 * Uso:
 *   node tool/generate-tokens.mjs
 *   node tool/generate-tokens.mjs --check
 */

import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const ROOT = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const SOURCE = path.join(ROOT, '.ds-core', 'tokens', 'figma-variables.json');
const OUT_DIR = path.join(ROOT, 'packages', 'nortear_ds', 'lib', 'src', 'tokens');
const CHECK = process.argv.includes('--check');

const COLLECTIONS = [
  { key: 'Cor', className: 'NdsColors', file: 'colors', defaultMode: 'default-light' },
  { key: 'Dimensao', className: 'NdsDimensions', file: 'dimensions', defaultMode: 'default' },
  { key: 'Raio', className: 'NdsRadii', file: 'radii', defaultMode: 'default' },
  { key: 'Tipografia', className: 'NdsTypography', file: 'typography', defaultMode: 'minor-third' },
  { key: 'Movimento', className: 'NdsMotion', file: 'motion', defaultMode: 'default' },
  { key: 'Elevacao', className: 'NdsElevation', file: 'elevation', defaultMode: 'light' },
  { key: 'Fonte', className: 'NdsFonts', file: 'fonts', defaultMode: 'default' },
];

// ─── Identificadores ──────────────────────────────────────────────────────────

// Palavras reservadas do Dart que podem sair de um nome de mode ou token.
// `default` é o caso real: Dimensao, Raio, Movimento e Fonte têm mode "default".
const RESERVED = new Set([
  'default', 'class', 'const', 'var', 'final', 'new', 'this', 'super', 'is', 'in',
  'for', 'if', 'else', 'switch', 'case', 'do', 'while', 'return', 'void', 'enum',
  'extends', 'with', 'try', 'catch', 'throw', 'assert', 'break', 'continue',
  'rethrow', 'true', 'false', 'null', 'operator', 'part', 'typedef',
]);

function toCamel(name) {
  const camel = name
    .split(/[^a-zA-Z0-9]+/)
    .filter(Boolean)
    .map((part, i) => (i === 0 ? part : part.charAt(0).toUpperCase() + part.slice(1)))
    .join('');
  return /^[0-9]/.test(camel) ? `t${camel}` : camel;
}

const toModeName = (name) => {
  const camel = toCamel(name);
  return RESERVED.has(camel) ? `${camel}Mode` : camel;
};

const toFieldName = (name) => {
  const camel = toCamel(name);
  return RESERVED.has(camel) ? `${camel}Value` : camel;
};

// ─── Parsers de sintaxe CSS ───────────────────────────────────────────────────

/** Separa por vírgula ignorando as que estão dentro de parênteses. */
function splitTopLevel(input, separator) {
  const out = [];
  let depth = 0;
  let current = '';
  for (const char of input) {
    if (char === '(') depth++;
    else if (char === ')') depth--;
    if (char === separator && depth === 0) {
      out.push(current.trim());
      current = '';
    } else {
      current += char;
    }
  }
  if (current.trim()) out.push(current.trim());
  return out;
}

/** Quebra em tokens por espaço, preservando `rgba(0, 0, 0, .1)` inteiro. */
function splitParts(input) {
  return splitTopLevel(input.replace(/\s+/g, ' '), ' ').filter(Boolean);
}

function formatDouble(n) {
  const num = Number(n);
  if (!Number.isFinite(num)) throw new Error(`número inválido: ${n}`);
  return Number.isInteger(num) ? `${num}.0` : String(num);
}

function cssColorToDart(input) {
  const rgba = input.match(/^rgba?\(([^)]+)\)$/);
  if (rgba) {
    const parts = rgba[1].split(',').map((p) => Number(p.trim()));
    const [r, g, b] = parts;
    const alpha = parts.length > 3 ? parts[3] : 1;
    const hex = [alpha * 255, r, g, b]
      .map((c) => Math.round(Math.max(0, Math.min(255, c))).toString(16).padStart(2, '0'))
      .join('');
    return `Color(0x${hex.toUpperCase()})`;
  }
  const hex = input.match(/^#([0-9a-fA-F]{6})$/);
  if (hex) return `Color(0xFF${hex[1].toUpperCase()})`;
  throw new Error(`cor CSS não reconhecida: ${input}`);
}

/** `0px 4px 6px -1px rgba(…), …` → literal List<BoxShadow>. */
function cssShadowToDart(input) {
  const shadows = splitTopLevel(input, ',').map((shadow) => {
    const parts = splitParts(shadow);
    if (parts.length < 4) throw new Error(`box-shadow inesperado: ${shadow}`);
    const px = (v) => formatDouble(parseFloat(v));
    const [x, y, blur] = parts;
    // O spread é opcional em CSS; quando ausente, a cor ocupa a 4ª posição.
    const hasSpread = parts.length >= 5;
    const spread = hasSpread ? parts[3] : '0';
    const color = parts[hasSpread ? 4 : 3];
    return (
      `BoxShadow(color: ${cssColorToDart(color)}, ` +
      `offset: Offset(${px(x)}, ${px(y)}), ` +
      `blurRadius: ${px(blur)}, spreadRadius: ${px(spread)})`
    );
  });
  return `<BoxShadow>[${shadows.join(', ')}]`;
}

/** `cubic-bezier(a, b, c, d)` → Cubic; `linear` → Curves.linear. */
function cssCurveToDart(input) {
  if (input.trim() === 'linear') return 'Curves.linear';
  const match = input.match(/^cubic-bezier\(([^)]+)\)$/);
  if (!match) throw new Error(`curva CSS não reconhecida: ${input}`);
  const parts = match[1].split(',').map((p) => formatDouble(parseFloat(p.trim())));
  if (parts.length !== 4) throw new Error(`cubic-bezier com ${parts.length} argumentos: ${input}`);
  return `Cubic(${parts.join(', ')})`;
}

// ─── Mapeamento de folha → campo Dart ─────────────────────────────────────────

function mapLeaf(collectionKey, rawName, leaf) {
  const value = leaf.$value;

  if (leaf.$type === 'color') {
    const hex = String(value.hex ?? '').replace('#', '');
    if (!/^[0-9a-fA-F]{6}$/.test(hex)) throw new Error(`cor sem hex: ${JSON.stringify(value)}`);
    const a = Math.round(Math.max(0, Math.min(1, value.alpha ?? 1)) * 255)
      .toString(16)
      .padStart(2, '0');
    return { name: toFieldName(rawName), type: 'Color', literal: `Color(0x${(a + hex).toUpperCase()})` };
  }

  if (collectionKey === 'Elevacao') {
    return { name: toFieldName(rawName), type: 'List<BoxShadow>', literal: cssShadowToDart(String(value)) };
  }

  if (rawName.startsWith('duration-')) {
    const ms = Math.round(Number(value));
    return { name: toFieldName(rawName), type: 'Duration', literal: `Duration(milliseconds: ${ms})` };
  }

  if (rawName.startsWith('ease-')) {
    return { name: toFieldName(rawName), type: 'Curve', literal: cssCurveToDart(String(value)) };
  }

  // `-0.02em` → double sem unidade, com o sufixo dizendo em que unidade está.
  const em = typeof value === 'string' && value.match(/^(-?[\d.]+)em$/);
  if (em) {
    return { name: `${toFieldName(rawName)}Em`, type: 'double', literal: formatDouble(em[1]) };
  }

  if (leaf.$type === 'number') {
    return { name: toFieldName(rawName), type: 'double', literal: formatDouble(value) };
  }

  if (leaf.$type === 'string') {
    return { name: toFieldName(rawName), type: 'String', literal: `'${String(value).replace(/'/g, "\\'")}'` };
  }

  throw new Error(`tipo de token não suportado: ${leaf.$type} (${rawName})`);
}

// ─── Travessia ────────────────────────────────────────────────────────────────

const isLeaf = (node) => node !== null && typeof node === 'object' && '$type' in node;

function flattenMode(node, out = []) {
  if (!node || typeof node !== 'object') return out;
  for (const [key, value] of Object.entries(node)) {
    if (key.startsWith('$')) continue;
    if (isLeaf(value)) out.push([key, value]);
    else flattenMode(value, out);
  }
  return out;
}

// ─── Emissão ──────────────────────────────────────────────────────────────────

const header = (collectionKey) => `// GERADO por tool/generate-tokens.mjs — não editar à mão.
//
// Fonte: @nortear/ds-core · tokens/figma-variables.json · coleção "${collectionKey}"
// Para atualizar: npm run core:sync && npm run tokens:gen

// widgets.dart reexporta foundation (immutable), painting (Color, BoxShadow,
// Offset) e animation (Curve, Cubic, Curves) — um import cobre todo tipo emitido.
import 'package:flutter/widgets.dart';
`;

function buildClass({ key, className, defaultMode }, collection) {
  const modes = collection.modes;
  if (!modes) throw new Error(`coleção ${key} sem "modes"`);

  const modeNames = Object.keys(modes);
  if (!modeNames.includes(defaultMode)) {
    throw new Error(`coleção ${key}: mode padrão "${defaultMode}" não existe (tem: ${modeNames})`);
  }

  // O mode padrão define o contrato de campos; os outros têm de bater. Se um
  // mode ganhar ou perder token, vira erro aqui — não uma classe com campo
  // faltando que só quebra na hora de compilar, longe da causa.
  const reference = flattenMode(modes[defaultMode]);
  const fields = [];
  const seen = new Map();

  for (const [rawName, leaf] of reference) {
    const mapped = mapLeaf(key, rawName, leaf);
    if (seen.has(mapped.name)) {
      throw new Error(
        `colisão em ${key}: "${rawName}" e "${seen.get(mapped.name)}" viram "${mapped.name}"`,
      );
    }
    seen.set(mapped.name, rawName);
    fields.push({ rawName, ...mapped });
  }

  const lines = [header(key)];
  lines.push(`/// Tokens da coleção "${key}".`);
  lines.push('///');
  lines.push(`/// Modes: ${modeNames.join(', ')}.`);
  lines.push('@immutable');
  lines.push(`class ${className} {`);
  lines.push(`  const ${className}({`);
  for (const f of fields) lines.push(`    required this.${f.name},`);
  lines.push('  });\n');
  for (const f of fields) {
    lines.push(`  /// \`${f.rawName}\``);
    lines.push(`  final ${f.type} ${f.name};`);
  }
  lines.push('');

  for (const mode of modeNames) {
    const entries = new Map(flattenMode(modes[mode]));
    const missing = fields.filter((f) => !entries.has(f.rawName)).map((f) => f.rawName);
    if (missing.length) {
      throw new Error(`coleção ${key}, mode "${mode}": faltam ${missing.join(', ')}`);
    }
    lines.push(`  /// Mode \`${mode}\`.`);
    lines.push(`  static const ${className} ${toModeName(mode)} = ${className}(`);
    for (const f of fields) {
      lines.push(`    ${f.name}: ${mapLeaf(key, f.rawName, entries.get(f.rawName)).literal},`);
    }
    lines.push('  );\n');
  }

  lines.push('  /// Mode servido quando nenhum é escolhido.');
  lines.push(`  static const ${className} fallback = ${toModeName(defaultMode)};\n`);
  lines.push('  /// Todos os modes por nome — consumido pelos addons do Widgetbook.');
  lines.push(`  static const Map<String, ${className}> byMode = <String, ${className}>{`);
  for (const mode of modeNames) lines.push(`    '${mode}': ${toModeName(mode)},`);
  lines.push('  };');
  lines.push('}');

  return { source: lines.join('\n') + '\n', fieldCount: fields.length, modeCount: modeNames.length };
}

// ─── Execução ─────────────────────────────────────────────────────────────────

if (!fs.existsSync(SOURCE)) {
  console.error(`Fonte ausente: ${path.relative(ROOT, SOURCE)}`);
  console.error('Rode `npm run core:sync` antes.');
  process.exit(1);
}

const tokens = JSON.parse(fs.readFileSync(SOURCE, 'utf8'));
fs.mkdirSync(OUT_DIR, { recursive: true });

const outputs = new Map();
const report = [];

for (const collection of COLLECTIONS) {
  const node = tokens[collection.key];
  if (!node) throw new Error(`coleção ausente na fonte: ${collection.key}`);
  const { source, fieldCount, modeCount } = buildClass(collection, node);
  outputs.set(path.join(OUT_DIR, `${collection.file}.g.dart`), source);
  report.push({ colecao: collection.key, arquivo: `${collection.file}.g.dart`, campos: fieldCount, modes: modeCount });
}

outputs.set(
  path.join(OUT_DIR, 'tokens.g.dart'),
  `// GERADO por tool/generate-tokens.mjs — não editar à mão.\n\n` +
    COLLECTIONS.map((c) => `export '${c.file}.g.dart';`).join('\n') +
    '\n',
);

let stale = 0;
for (const [file, source] of outputs) {
  if (CHECK) {
    const previous = fs.existsSync(file) ? fs.readFileSync(file, 'utf8') : null;
    if (previous !== source) {
      stale++;
      console.error(`DEFASADO: ${path.relative(ROOT, file)}`);
    }
  } else {
    fs.writeFileSync(file, source, 'utf8');
  }
}

console.table(report);

if (CHECK) {
  if (stale) {
    console.error(`\n${stale} arquivo(s) fora de sincronia. Rode \`npm run tokens:gen\`.`);
    process.exit(1);
  }
  console.log('\nTokens em dia.');
} else {
  console.log(`\nEscrito em ${path.relative(ROOT, OUT_DIR)}`);
}
