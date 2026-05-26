@echo off
:: Start the free-claude-code proxy and launch Claude Code with Ollama Cloud backend

set REPO_DIR=%~dp0

:: Ollama official cloud endpoint
set OLLAMA_BASE_URL=https://ollama.com

:: Required for Ollama Cloud API
set OLLAMA_API_KEY=8580bc0c146d4cf499684c256677a35f.-02lv_V8AeTtn-ciXqPSMz1Y

:: Model selection for Ollama Cloud
set MODEL=ollama/gemma4:cloud
set MODEL_OPUS=%MODEL%
set MODEL_SONNET=%MODEL%
set MODEL_HAIKU=%MODEL%

:: Start proxy in background
start /B "" uv run uvicorn server:app --host 0.0.0.0 --port 8083 --app-dir "%REPO_DIR%" 2>nul

:: Give server a moment to start
timeout /t 2 /nobreak >nul

:: Launch Claude Code pointed at local proxy
set ANTHROPIC_AUTH_TOKEN=freecc
set ANTHROPIC_BASE_URL=http://localhost:8083
claude %*