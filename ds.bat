@echo off
:: Start the free-claude-code proxy and launch Claude Code with DeepSeek backend

set REPO_DIR=%~dp0

:: Ensure uv is available
set PATH=%USERPROFILE%\.local\bin;%PATH%

:: Start proxy in background
start /B "" uv run uvicorn server:app --host 0.0.0.0 --port 8082 --app-dir "%REPO_DIR%" 2>nul

:: Give server a moment to start
timeout /t 3 /nobreak >nul

:: Launch Claude Code pointed at local proxy
set ANTHROPIC_AUTH_TOKEN=freecc
set ANTHROPIC_BASE_URL=http://localhost:8082
claude %*
