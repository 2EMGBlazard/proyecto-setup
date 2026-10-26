function Install-SoftwarePackage {
    param (
        [string]$PackageId,
        [string]$Name
    )
    Write-Host "Iniciando instalacion de $Name..." -ForegroundColor Yellow
    
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        winget install --id $PackageId --silent --accept-source-agreements --accept-package-agreements
        return $true
    } else {
        Write-Warning "Winget no esta disponible en este equipo."
        return $false
    }
}

function Open-OfficeDownloads {
    Write-Host "Abriendo sitio de descargas de Office..." -ForegroundColor Cyan
    Start-Process "https://massgrave.dev/office_c2r_links"
}