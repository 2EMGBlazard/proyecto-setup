<#
===============================================================================
   SUITE DE DEPLOYMENT, ACCESIBILIDAD Y MANTENIMIENTO DE SOFTWARE
   Proyecto Universitario: Calidad y Pruebas de Software
===============================================================================
#>

# --- NARRADOR DE VOZ PARA ACCESIBILIDAD ---

function Speak-Text {
    param ([string]$Text)
    try {
        Add-Type -AssemblyName System.Speech -ErrorAction SilentlyContinue
        $synth = New-Object System.Speech.Synthesis.SpeechSynthesizer
        $synth.Rate = 1
        $synth.SpeakAsync($Text) | Out-Null
    } catch {
        # Si la API de voz no está disponible en la máquina cliente, no interrumpe el script
    }
}

# --- FUNCIONES DE INSTALACIÓN Y HERRAMIENTAS ---

function Install-SoftwarePackage {
    param (
        [string]$PackageId,
        [string]$Name
    )
    Write-Host "Iniciando instalación de $Name..." -ForegroundColor Yellow
    Speak-Text -Text "Iniciando instalación de $Name"

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

function Open-CertificadosPortal {
    Write-Host "Abriendo Portal de Certificados Laborales y Trámites (Colombia)..." -ForegroundColor Green
    Speak-Text -Text "Abriendo Portal de Certificados Laborales"

    # Intenta abrir el archivo local si existe; de lo contrario abre la versión del repositorio remoto
    $localPath = "$PSScriptRoot\..\certificados.html"
    if (Test-Path $localPath) {
        Start-Process $localPath
    } else {
        Start-Process "https://raw.githack.com/2EMGBlazard/proyecto-setup/main/certificados.html"
    }
}

# --- FUNCIONES DE ACTIVACIÓN (INTEGRACIÓN MAS) ---

function Invoke-MASActivation {
    Write-Host "Ejecutando módulo oficial de activación MAS..." -ForegroundColor Green
    Speak-Text -Text "Iniciando módulo de activación"
    irm https://get.activated.win | iex
}

# --- MENÚ PRINCIPAL ---

function Show-MainMenu {
    Clear-Host
    Write-Host "====================================================" -ForegroundColor Cyan
    Write-Host "   SUITE DE DEPLOYMENT Y MANTENIMIENTO DE SOFTWARE  " -ForegroundColor Green
    Write-Host "====================================================" -ForegroundColor Cyan
    Write-Host ""

    # Locución del menú para accesibilidad
    Speak-Text -Text "Menú principal cargado. Opciones de activación, instalaciones de software y portal de certificados colombianos."

    Write-Host " --- ACTIVACIONES Y LICENCIAMIENTO ---" -ForegroundColor Yellow
    Write-Host " [1] Módulo de Activación de Windows y Office (MAS)"
    Write-Host ""
    Write-Host " --- DEPLOYMENT DE HERRAMIENTAS (WINGET / NINITE) ---" -ForegroundColor Yellow
    Write-Host " [2] Instalar Navegadores (Chrome / Firefox)"
    Write-Host " [3] Instalar Reproductores (VLC Media Player)"
    Write-Host " [4] Instalar Utilidades (7-Zip / Notepad++)"
    Write-Host " [5] Abrir Descargas de ISOs (Office / Windows)"
    Write-Host " [6] Abrir Ninite.com (Selección Manual)"
    Write-Host ""
    Write-Host " --- CERTIFICADOS LABORALES Y ANTECEDENTES (COLOMBIA) ---" -ForegroundColor Yellow
    Write-Host " [7] Abrir Portal de Certificados (Judiciales, Fiscales, RUT, EPS, Pensión)"
    Write-Host ""
    Write-Host " --- CONVERSIÓN DE ARCHIVOS ---" -ForegroundColor Yellow
    Write-Host " [8] Instalar Filee (Conversor de Archivos por Arrastre)"
    Write-Host ""
    Write-Host " [0] Salir"
    Write-Host ""

    $selection = Read-Host "Selecciona una opción [0-7]"

    switch ($selection) {
        "1" { Invoke-MASActivation; Show-MainMenu }
        "2" {
            Install-SoftwarePackage -PackageId "Google.Chrome" -Name "Google Chrome"
            Install-SoftwarePackage -PackageId "Mozilla.Firefox" -Name "Mozilla Firefox"
            Read-Host "Presiona Enter para continuar..."
            Show-MainMenu
        }
        "3" {
            Install-SoftwarePackage -PackageId "VideoLAN.VLC" -Name "VLC Media Player"
            Read-Host "Presiona Enter para continuar..."
            Show-MainMenu
        }
        "4" {
            Install-SoftwarePackage -PackageId "7zip.7zip" -Name "7-Zip"
            Install-SoftwarePackage -PackageId "Notepad++.Notepad++" -Name "Notepad++"
            Read-Host "Presiona Enter para continuar..."
            Show-MainMenu
        }
        "5" {
            Open-OfficeDownloads
            Read-Host "Presiona Enter para continuar..."
            Show-MainMenu
        }
        "6" {
            Start-Process "https://ninite.com"
            Show-MainMenu
        }
        "7" {
            Open-CertificadosPortal
            Read-Host "Presiona Enter para continuar..."
            Show-MainMenu
        }
        "8" {
            Install-SoftwarePackage -PackageId "Filee.Filee" -Name "Filee Conversor de Archivos"
            Read-Host "Presiona Enter para continuar..."
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

Show-MainMenu