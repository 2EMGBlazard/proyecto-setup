# 🛠️ Suite de Deployment, Activación y Mantenimiento de Software

Proyecto universitario desarrollado para la asignatura de **Calidad y Pruebas de Software**.

Esta herramienta es un asistente de consola en PowerShell que automatiza el proceso de post-instalación en sistemas operativos Windows. Permite realizar despliegues silenciosos de software esencial (navegadores, reproductores, compresión y editores) utilizando el gestor oficial **Winget** (con respaldo en **Ninite**), además de integrar herramientas de verificación y licencias del sistema mediante scripts optimizados.

---

## 🚀 Ejecución Rápida (Desde cualquier PC)

Para ejecutar la suite en cualquier computadora sin necesidad de descargar archivos manualmente, abre **PowerShell como Administrador** y ejecuta el siguiente comando:

```powershell
irm https://tinyurl.com/mi-setup | iex

¿Cómo funciona este comando?

irm (Invoke-RestMethod): Consulta la URL acortada y descarga el código fuente del script directamente en la memoria RAM del equipo desde el repositorio oficial de GitHub (https://raw.githubusercontent.com/2EMGBlazard/proyecto-setup/main/src/Menu.ps1).

| (Pipeline): Redirige el contenido descargado sin guardar nada en el disco duro.

iex (Invoke-Expression): Ejecuta el script inmediatamente en la consola de PowerShell.

📋 Menú Interactivo de la Consola
Al iniciar la herramienta, se desplegará el siguiente menú en pantalla:

Plaintext
====================================================
   SUITE DE DEPLOYMENT Y MANTENIMIENTO DE SOFTWARE  
====================================================

 --- ACTIVACIONES Y LICENCIAMIENTO ---
 [1] HWID - Activación Permanente de Windows
 [2] Ohook - Activación Permanente de Office
 [3] TSforge / Online KMS - Activación Windows/Office/ESU
 [4] Consultar Estado de Activación

 --- DEPLOYMENT DE HERRAMIENTAS (WINGET / NINITE) ---
 [5] Instalar Navegadores (Chrome / Firefox)
 [6] Instalar Reproductores (VLC Media Player)
 [7] Instalar Utilidades (7-Zip / Notepad++)
 [8] Abrir Descargas de ISOs (Office / Windows)
 [9] Abrir Ninite.com (Selección Manual)

 [0] Salir
📖 Guía Paso a Paso de Uso
Módulo 1: Licenciamiento y Diagnóstico (Opciones 1 a 4)
Seleccionar Opción: Ingresa el número 1, 2, 3 o 4 según el tipo de verificación o proceso a ejecutar.

Ejecución de Asistente: El script conectará con los módulos oficiales de validación y mostrará en pantalla el estado actual de las licencias de Windows o Microsoft Office.

Módulo 2: Instalación Automatizada de Software (Opciones 5 a 7)
Seleccionar Categoría: Ingresa 5 para navegadores, 6 para reproductores o 7 para utilidades básicas.

Proceso Silencioso: La herramienta verificará si el sistema cuenta con Winget.

Si Winget está disponible: Descargará e instalará las aplicaciones de fondo sin pedir confirmaciones adicionales (modo --silent).

Si Winget no está disponible: Abrirá automáticamente el navegador web en la plataforma Ninite para permitir la descarga directa de los paquetes.

Módulo 3: Descargas Oficiales y Utilidades Web (Opciones 8 y 9)
Opción 8 (ISO y Descargas de Office/Windows): Redirige a los enlaces oficiales para descargar imágenes de disco (ISOs) e instaladores Click-to-Run de Microsoft Office.

Opción 9 (Ninite Web): Abre el sitio web de Ninite en el navegador predeterminado para realizar selecciones personalizadas de software.

🧪 Estructura del Proyecto y Pruebas de Calidad
Este proyecto incluye una estructura modular preparada para la integración de pruebas unitarias con el framework Pester, cumpliendo con los estándares requeridos en la asignatura de Calidad de Software:

Plaintext
proyecto-setup/
├── src/
│   ├── Menu.ps1             # Script principal ejecutable con todo el flujo integrado
│   └── Installers.ps1       # Módulo secundario con funciones de instalación
├── tests/
│   └── Installers.Tests.ps1 # Pruebas unitarias escritas con el framework Pester
└── README.md                # Documentación del proyecto
Ejecución de Pruebas Unitarias (Pester)
Si deseas validar la cobertura del código y ejecutar las pruebas unitarias en tu equipo local:

Instala el módulo de Pester en PowerShell:

PowerShell
Install-Module -Name Pester -Force -Scope CurrentUser
Corre las pruebas desde la raíz del proyecto:

PowerShell
Invoke-Pester .\tests\Installers.Tests.ps1
🔗 Enlaces Oficiales
Repositorio de GitHub: github.com/2EMGBlazard/proyecto-setup

Código Fuente Raw: src/Menu.ps1
