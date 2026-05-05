@echo off
cd /d "%~dp0"
echo Starting Jupyter Lab...
pixi run notebook
