# Cargar funciones auxiliares
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
if (Test-Path "$scriptPath\Installers.ps1") {
    . "$scriptPath\Installers.ps1"
}

function Show-MainMenu {
    Clear-Host
    Write-Host "====================================================" -ForegroundColor Cyan
    Write-Host "   SUITE DE DEPLOYMENT Y MANTENIMIENTO DE SOFTWARE  " -ForegroundColor Green
    Write-Host "====================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host " [1] Instalar Navegadores (Chrome / Firefox)"
    Write-Host " [2] Instalar Reproductores (VLC)"
    Write-Host " [3] Instalar Utilidades (7-Zip / Notepad++)"
    Write-Host " [4] Abrir Descargas de Office / Windows"
    Write-Host " [5] Abrir Ninite.com (Seleccion Manual)"
    Write-Host " [0] Salir"
    Write-Host ""
    
    $selection = Read-Host "Selecciona una opcion [0-5]"
    
    switch ($selection) {
        "1" { 
            Install-SoftwarePackage -PackageId "Google.Chrome" -Name "Google Chrome"
            Install-SoftwarePackage -PackageId "Mozilla.Firefox" -Name "Mozilla Firefox"
            Read-Host "Presiona Enter para continuar..."
            Show-MainMenu
        }
        "2" { 
            Install-SoftwarePackage -PackageId "VideoLAN.VLC" -Name "VLC Media Player"
            Read-Host "Presiona Enter para continuar..."
            Show-MainMenu
        }
        "3" { 
            Install-SoftwarePackage -PackageId "7zip.7zip" -Name "7-Zip"
            Install-SoftwarePackage -PackageId "Notepad++.Notepad++" -Name "Notepad++"
            Read-Host "Presiona Enter para continuar..."
            Show-MainMenu
        }
        "4" { 
            Open-OfficeDownloads
            Read-Host "Presiona Enter para continuar..."
            Show-MainMenu
        }
        "5" { 
            Start-Process "https://ninite.com"
            Show-MainMenu
        }
        "0" { Exit }
        default { 
            Write-Host "Opcion invalida." -ForegroundColor Red
            Start-Sleep -Seconds 1
            Show-MainMenu
        }
    }
}

Show-MainMenu