:: LLM Source: https://huggingface.co/mistralai

@echo off
:: ================= UNINSTALL MISTRAL (FIXED) =================
:: Removes environment, scripts, and downloaded models

echo === Starting cleanup ===

:: Remove virtual environment
if exist llm_env (
    echo === Removing virtual environment 'llm_env' ===
    rmdir /s /q llm_env
) else (
    echo No virtual environment found
)

:: Remove test script
if exist run_mistral.py (
    echo === Removing test script 'run_mistral.py' ===
    del /f /q run_mistral.py
) else (
    echo No test script found
)

:: Remove Hugging Face Mistral models ONLY (safer)
set HF_CACHE=%USERPROFILE%\.cache\huggingface\hub

if exist "%HF_CACHE%" (
    echo === Searching for Mistral models in Hugging Face cache ===
    
    for /d %%D in ("%HF_CACHE%\models--mistralai--*") do (
        echo Removing %%D
        rmdir /s /q "%%D"
    )

    echo === Mistral model cleanup complete ===
) else (
    echo No Hugging Face cache found
)

:: OPTIONAL: Clear pip cache (can free several GB)
echo.
set /p CLEAR_PIP=Do you want to clear pip cache too? (y/n): 
if /i "%CLEAR_PIP%"=="y" (
    echo === Clearing pip cache ===
    python -m pip cache purge
)

echo.
echo === Cleanup complete! ===
echo Your system is now clean of Mistral install files and models.
pause