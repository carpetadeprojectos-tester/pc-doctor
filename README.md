# 🐶 PC Doctor

Diagnóstico de PC en un clic. Gratis, portable y sin instalación.

## Qué hace
Un script que lee tu hardware real (CPU, RAM, disco, procesos y errores del sistema)
y muestra un reporte claro. Pensado para equipos lentos: usa solo herramientas nativas de Windows.

## Descargar y usar
1. Descarga `pcdoctor.ps1` (o `run.bat`).
2. Doble clic en `run.bat` (o ejecuta `powershell -ExecutionPolicy Bypass -File pcdoctor.ps1`).
3. Listo: ves el diagnóstico en la pantalla.

Compatible con Windows 10/11.

## Demo web
`index.html` es una **página de ejemplo** con un diagnóstico simulado interactivo
y una opción de pago de muestra. Los datos del escaneo son ficticios; el script
`pcdoctor.ps1` sí lee tu hardware real.

## Estructura
- `pcdoctor.ps1` — diagnóstico real
- `run.bat` — lanzador
- `index.html` + `css/style.css` + `images/dog-doctor.svg` — sitio de ejemplo

## Licencia
MIT — proyecto de ejemplo.
