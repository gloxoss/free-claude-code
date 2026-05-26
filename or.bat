@echo off
:: Start the free-claude-code proxy and launch Claude Code with OpenRouter backend

set REPO_DIR=%~dp0

:: Use OpenRouter provider
set MODEL=open_router/anthropic/claude-3.5-sonnet
set MODEL_OPUS=%MODEL%
set MODEL_SONNET=%MODEL%
set MODEL_HAIKU=%MODEL%

:: Start proxy in background
start /B "" uv run uvicorn server:app --host 0.0.0.0 --port 8084 --app-dir "%REPO_DIR%" 2>nul

:: Give server a moment to start
timeout /t 2 /nobreak >nul

:: Launch Claude Code pointed at local proxy
set ANTHROPIC_AUTH_TOKEN=freecc
set ANTHROPIC_BASE_URL=http://localhost:8084
claude %*