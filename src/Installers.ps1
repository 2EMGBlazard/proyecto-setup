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

function Install-Filee {
    Write-Host "`n[+] Iniciando instalación de Filee (Conversor de archivos)..." -ForegroundColor Cyan

    # 1. Intentar instalación mediante Winget (ID oficial)
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        Write-Host "[+] Instalando Filee vía Winget..." -ForegroundColor Yellow
        winget install --id Filee.Filee -e --accept-source-agreements --accept-package-agreements
    }
    else {
        # 2. Método alternativo: Descarga directa de la última versión desde GitHub
        Write-Host "[+] Descargando instalador ejecutable desde GitHub..." -ForegroundColor Yellow
        $fileeUrl = "https://github.com/filee-app/filee/releases/latest/download/Filee-Setup.exe"
        $outputFile = "$env:TEMP\Filee-Setup.exe"

        # Descarga el archivo ejecutable
        Invoke-WebRequest -Uri $fileeUrl -OutFile $outputFile

        # Ejecuta el instalador
        Write-Host "[+] Ejecutando el instalador..." -ForegroundColor Green
        Start-Process -FilePath $outputFile -Wait

        # Limpia el archivo temporal
        Remove-Item -Path $outputFile -ErrorAction SilentlyContinue
    }

    Write-Host "[✓] Proceso de instalación de Filee finalizado." -ForegroundColor Green
    Pause
}