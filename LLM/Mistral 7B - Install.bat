:: LLM Source: https://huggingface.co/mistralai

@echo off
:: ================= INSTALL MISTRAL (FIXED) =================

echo === Creating virtual environment with Python 3.11 ===
py -3.11 -m venv llm_env

echo === Activating virtual environment ===
call llm_env\Scripts\activate

echo === Upgrading pip ===
python -m pip install --upgrade pip

echo === Installing dependencies ===
python -m pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
python -m pip install transformers accelerate sentencepiece

echo.
echo === Choose Model to Install ===
echo 1. Mistral-3-8B-Instruct-2512 (higher quality, more VRAM)
echo 2. Mistral-3-3B-Instruct-2512 (lighter, faster)
set /p MODEL_CHOICE=Enter choice (1 or 2): 

if "%MODEL_CHOICE%"=="1" (
    set MODEL_NAME=mistralai/Mistral-3-8B-Instruct-2512
) else if "%MODEL_CHOICE%"=="2" (
    set MODEL_NAME=mistralai/Mistral-3-3B-Instruct-2512
) else (
    echo Invalid choice. Defaulting to 3B model.
    set MODEL_NAME=mistralai/Mistral-3-3B-Instruct-2512
)

echo === Selected model: %MODEL_NAME% ===

echo === Creating test script ===
(
echo from transformers import AutoModelForCausalLM, AutoTokenizer, pipeline
echo model_name = "%MODEL_NAME%"
echo tokenizer = AutoTokenizer.from_pretrained(model_name)
echo model = AutoModelForCausalLM.from_pretrained(model_name, device_map="auto")
echo generator = pipeline("text-generation", model=model, tokenizer=tokenizer)
echo prompt = "Hello, AI! Let's do some chaotic but safe fun."
echo output = generator(prompt, max_new_tokens=200, do_sample=True, temperature=1.0)
echo print(output[0]['generated_text'])
) > Mistral7B_Run.py

echo === Running test ===
python Mistral7B_Run.py

echo.
echo === Installation complete! ===
pause