$ErrorActionPreference = 'Stop'
Set-Location -LiteralPath $PSScriptRoot
if (-not (Get-Command node -ErrorAction SilentlyContinue)) { throw 'Instalá Node.js 22.13 o superior.' }
if (-not (Get-Command pnpm -ErrorAction SilentlyContinue)) { throw 'Instalá pnpm: npm install -g pnpm@11.19.0' }
if (-not (Test-Path -LiteralPath 'node_modules')) {
    & pnpm install --frozen-lockfile
    if ($LASTEXITCODE -ne 0) { throw 'No se pudieron instalar las dependencias.' }
}
& node scripts/demo.mjs
if ($LASTEXITCODE -ne 0) { throw 'MGS OS no pudo iniciarse. Revisá el mensaje anterior.' }
