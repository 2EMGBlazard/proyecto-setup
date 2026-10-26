<#
===============================================================================
   SUITE DE DEPLOYMENT, ACTIVACIÓN Y MANTENIMIENTO DE SOFTWARE
   Proyecto Universitario: Calidad y Pruebas de Software
===============================================================================
#>

# --- FUNCIONES DE INSTALACIÓN Y HERRAMIENTAS ---

function Install-SoftwarePackage {
    param (
        [string]$PackageId,
        [string]$Name
    )
    Write-Host "Iniciando instalación de $Name..." -ForegroundColor Yellow
    
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        winget install --id $PackageId --silent --accept-source-agreements --accept-package-agreements
    } else {
        Write-Warning "Winget no está disponible en este equipo. Abriendo Ninite..."
        Start-Process "https://ninite.com"
    }
}

function Open-OfficeDownloads {
    Write-Host "Abriendo sitio de descargas de Office/Windows..." -ForegroundColor Cyan
    Start-Process "https://massgrave.dev/office_c2r_links"
}

# --- FUNCIONES DE ACTIVACIÓN (INTEGRACIÓN MAS) ---

function Invoke-MASActivation {
    param ([string]$Option)
    Write-Host "Ejecutando módulo oficial de activación MAS..." -ForegroundColor Green
    # Llama al script oficial de Microsoft Activation Scripts
    irm https://get.activated.win | iex
}

# --- MENÚ PRINCIPAL ---

function Show-MainMenu {
    Clear-Host
    Write-Host "====================================================" -ForegroundColor Cyan
    Write-Host "   SUITE DE DEPLOYMENT Y MANTENIMIENTO DE SOFTWARE  " -ForegroundColor Green
    Write-Host "====================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host " --- ACTIVACIONES Y LICENCIAMIENTO ---" -ForegroundColor Yellow
    Write-Host " [1] HWID - Activación Permanente de Windows"
    Write-Host " [2] Ohook - Activación Permanente de Office"
    Write-Host " [3] TSforge / Online KMS - Activación Windows/Office/ESU"
    Write-Host " [4] Consultar Estado de Activación"
    Write-Host ""
    Write-Host " --- DEPLOYMENT DE HERRAMIENTAS (WINGET / NINITE) ---" -ForegroundColor Yellow
    Write-Host " [5] Instalar Navegadores (Chrome / Firefox)"
    Write-Host " [6] Instalar Reproductores (VLC Media Player)"
    Write-Host " [7] Instalar Utilidades (7-Zip / Notepad++)"
    Write-Host " [8] Abrir Descargas de ISOs (Office / Windows)"
    Write-Host " [9] Abrir Ninite.com (Selección Manual)"
    Write-Host ""
    Write-Host " [0] Salir"
    Write-Host ""
    
    $selection = Read-Host "Selecciona una opción [0-9]"
    
    switch ($selection) {
        "1" { Invoke-MASActivation; Show-MainMenu }
        "2" { Invoke-MASActivation; Show-MainMenu }
        "3" { Invoke-MASActivation; Show-MainMenu }
        "4" { Invoke-MASActivation; Show-MainMenu }
        "5" { 
            Install-SoftwarePackage -PackageId "Google.Chrome" -Name "Google Chrome"
            Install-SoftwarePackage -PackageId "Mozilla.Firefox" -Name "Mozilla Firefox"
            Read-Host "Presiona Enter para continuar..."
            Show-MainMenu
        }
        "6" { 
            Install-SoftwarePackage -PackageId "VideoLAN.VLC" -Name "VLC Media Player"
            Read-Host "Presiona Enter para continuar..."
            Show-MainMenu
        }
        "7" { 
            Install-SoftwarePackage -PackageId "7zip.7zip" -Name "7-Zip"
            Install-SoftwarePackage -PackageId "Notepad++.Notepad++" -Name "Notepad++"
            Read-Host "Presiona Enter para continuar..."
            Show-MainMenu
        }
        "8" { 
            Open-OfficeDownloads
            Read-Host "Presiona Enter para continuar..."
            Show-MainMenu
        }
        "9" { 
            Start-Process "https://ninite.com"
            Show-MainMenu
        }
        "0" { Exit }
        default { 
            Write-Host "Opción inválida." -ForegroundColor Red
            Start-Sleep -Seconds 1
            Show-MainMenu
        }
    }
}

# Ejecutar el menú al cargar
Show-MainMenu
