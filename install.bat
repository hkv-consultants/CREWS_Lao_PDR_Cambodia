@echo off
echo ============================================================
echo   CREWS UFFFS Nowcast - Environment Setup
echo ============================================================
echo.

:: Change to the directory where this script lives
cd /d "%~dp0"
echo Working directory: %CD%
echo.

:: Check if pixi is available
where pixi >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ERROR: pixi not found. Please install pixi first:
    echo   https://pixi.sh/latest/#installation
    echo.
    pause
    exit /b 1
)

:: Clean old environment if it exists
echo [1/3] Cleaning old environment...
pixi clean
echo.

:: Install environment
echo [2/3] Installing environment (this may take a few minutes)...
pixi install
if %ERRORLEVEL% neq 0 (
    echo.
    echo ERROR: pixi install failed. Check the error above.
    pause
    exit /b 1
)
echo.

:: Set up Jupyter kernel
echo [3/3] Setting up Jupyter kernel...
pixi run setup-kernel
echo.

echo ============================================================
echo   Setup complete!
echo.
echo   To start Jupyter Lab, run:
echo     pixi run notebook
echo ============================================================
echo.
pause
