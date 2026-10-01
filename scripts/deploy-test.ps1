$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$trimetraRoot = Split-Path -Parent $repoRoot
$testRoot = Join-Path $trimetraRoot "trimetra-test-remote"

$themeFolders = @(
    "config",
    "layouts",
    "snipplets",
    "static",
    "templates"
)

Write-Host "Sincronizando theme con Trimetra Test..." -ForegroundColor Cyan

foreach ($folder in $themeFolders) {
    $source = Join-Path $repoRoot $folder
    $destination = Join-Path $testRoot $folder

    Write-Host "-> $folder"

    & robocopy $source $destination /MIR /NFL /NDL /NJH /NJS /NP

    if ($LASTEXITCODE -gt 7) {
        throw "Robocopy fallo en '$folder' con codigo $LASTEXITCODE"
    }
}

if (-not (Test-Path (Join-Path $testRoot ".nuvem"))) {
    throw "No se encontro .nuvem en trimetra-test-remote. No se puede confirmar el destino FTP."
}

Write-Host ""
Write-Host "Subiendo cambios a Trimetra Test..." -ForegroundColor Cyan

Push-Location $testRoot

try {
    & nuvemshop theme ftp push

    if ($LASTEXITCODE -ne 0) {
        throw "Tiendanube CLI termino con codigo $LASTEXITCODE"
    }
}
finally {
    Pop-Location
}

Write-Host ""
Write-Host "Deploy a Trimetra Test completado." -ForegroundColor Green