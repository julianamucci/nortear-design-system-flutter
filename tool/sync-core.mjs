/**
 * sync-core.mjs — traz o @nortear/ds-core para `.ds-core/`.
 *
 * O repo web (design-system) empacota `docs/shared` com `npm run core:pack`.
 * Este repo consome essa saída. Só o que interessa a um consumidor nativo é
 * copiado — tokens, conteúdo e guidelines. CSS e estilos `.nds-*` ficam de
 * fora: não há navegador aqui, e copiá-los convidaria alguém a traduzir CSS na
 * mão em vez de gerar a partir dos tokens.
 *
 * `.ds-core/` é gitignored. O que este repo commita é o Dart GERADO a partir
 * dele, não a cópia — assim o clone é reproduzível sem Node.
 *
 * Fonte, em ordem de precedência:
 *   1. --from <caminho>            tarball .tgz ou pasta
 *   2. $DS_CORE_PATH
 *   3. ../design-system/docs/shared   (monorepo web ao lado, para desenvolvimento)
 *
 * Uso:
 *   node tool/sync-core.mjs
 *   node tool/sync-core.mjs --from ../design-system/nortear-ds-core-1.0.0.tgz
 */

import fs from 'node:fs';
import path from 'node:path';
import { execFileSync } from 'node:child_process';
import { fileURLToPath } from 'node:url';

const ROOT = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const DEST = path.join(ROOT, '.ds-core');

/** Só isto porta para um consumidor não-navegador. */
const WANTED = ['tokens', 'content', 'guidelines', 'skill-refs', 'package.json', 'README.md'];

function resolveSource() {
  const i = process.argv.indexOf('--from');
  if (i >= 0 && process.argv[i + 1]) return path.resolve(process.argv[i + 1]);
  if (process.env.DS_CORE_PATH) return path.resolve(process.env.DS_CORE_PATH);
  return path.resolve(ROOT, '..', 'design-system', 'docs', 'shared');
}

function copyWanted(from, to) {
  fs.mkdirSync(to, { recursive: true });
  for (const entry of WANTED) {
    const src = path.join(from, entry);
    if (!fs.existsSync(src)) {
      console.warn(`  (ausente na fonte, ignorado: ${entry})`);
      continue;
    }
    fs.cpSync(src, path.join(to, entry), { recursive: true });
    console.log(`  ${entry}`);
  }
}

const source = resolveSource();
if (!fs.existsSync(source)) {
  console.error(`Fonte não encontrada: ${source}`);
  console.error('Passe --from <tarball|pasta> ou defina DS_CORE_PATH.');
  process.exit(1);
}

fs.rmSync(DEST, { recursive: true, force: true });

if (source.endsWith('.tgz')) {
  const staging = path.join(ROOT, '.ds-core-staging');
  fs.rmSync(staging, { recursive: true, force: true });
  fs.mkdirSync(staging, { recursive: true });
  // O tarball do npm embrulha tudo em `package/`.
  execFileSync('tar', ['-xzf', source, '-C', staging], { stdio: 'inherit' });
  copyWanted(path.join(staging, 'package'), DEST);
  fs.rmSync(staging, { recursive: true, force: true });
} else {
  copyWanted(source, DEST);
}

const pkgFile = path.join(DEST, 'package.json');
const version = fs.existsSync(pkgFile)
  ? JSON.parse(fs.readFileSync(pkgFile, 'utf8')).version
  : 'desconhecida';

fs.writeFileSync(
  path.join(DEST, 'SOURCE.txt'),
  `origem: ${source}\nversão do @nortear/ds-core: ${version}\n`,
  'utf8',
);

console.log(`\n@nortear/ds-core ${version} → .ds-core/`);
console.log('Agora: npm run tokens:gen');
