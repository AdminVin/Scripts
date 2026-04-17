# ================= LLM Setup =================
# LLM Source: https://huggingface.co

$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

# =========================
# CONFIG (NEW CLEAN MODEL)
# =========================
$MODEL_ID = "Qwen/Qwen2.5-7B-Instruct"
$MODEL_DIR = "$PSScriptRoot\models\Qwen2.5-7B-Instruct"

# =========================
# CLEAN OLD RUN FILE
# =========================
if (Test-Path "$PSScriptRoot\run.py") {
    Remove-Item "$PSScriptRoot\run.py" -Force
    Write-Host "Removed old run.py"
}

# =========================
# DOWNLOAD MODEL
# =========================
if (!(Test-Path $MODEL_DIR)) {
    Write-Host "Downloading model..."
    python -c "from huggingface_hub import snapshot_download; snapshot_download('$MODEL_ID', local_dir=r'$MODEL_DIR', local_dir_use_symlinks=False)"
}

# =========================
# DEPENDENCIES
# =========================
pip install transformers accelerate bitsandbytes gradio huggingface_hub torch

# =========================
# RUN APP (CHAT UI)
# =========================
$runScript = @"
import torch
from transformers import AutoTokenizer, AutoModelForCausalLM, BitsAndBytesConfig
import gradio as gr

# Ensure that GPU is used if available
device = 'cuda' if torch.cuda.is_available() else 'cpu'

model_path = r'$MODEL_DIR'

# 4-bit quantization (optional, you can adjust this if needed)
bnb_config = BitsAndBytesConfig(
    load_in_4bit=True,
    bnb_4bit_compute_dtype=torch.float16,
    bnb_4bit_quant_type='nf4',
    bnb_4bit_use_double_quant=True
)

tokenizer = AutoTokenizer.from_pretrained(model_path, use_fast=True)
if tokenizer.pad_token is None:
    tokenizer.pad_token = tokenizer.eos_token

# Load model and explicitly move to GPU if available
model = AutoModelForCausalLM.from_pretrained(
    model_path,
    device_map="auto",  # Automatically assign model layers to available devices
    quantization_config=bnb_config
).to(device)  # Move model to GPU if available

model.eval()

# chat history storage
history = []

def chat(user_message, chat_history):
    messages = [{"role": "system", "content": "You are a helpful assistant."}]

    for u, a in chat_history:
        messages.append({"role": "user", "content": u})
        messages.append({"role": "assistant", "content": a})

    messages.append({"role": "user", "content": user_message})

    # Fix: Join all messages to create a proper string input for the tokenizer
    messages_content = [message['content'] for message in messages]
    text = " ".join(messages_content)

    inputs = tokenizer(text, return_tensors="pt", padding=True, truncation=True).to(device)

    with torch.no_grad():
        output = model.generate(
            **inputs,
            max_new_tokens=512,
            do_sample=True,
            temperature=0.7,
            top_p=0.9,
            eos_token_id=tokenizer.eos_token_id
        )

    response = tokenizer.decode(output[0], skip_special_tokens=True)

    # return updated chat history (GPT style UI)
    chat_history.append((user_message, response))
    return "", chat_history


with gr.Blocks() as app:
    gr.Markdown("# 💬 Local GPT Chat")

    chatbot = gr.Chatbot()
    msg = gr.Textbox(label="Message")
    clear = gr.Button("Clear")

    msg.submit(chat, [msg, chatbot], [msg, chatbot])
    clear.click(lambda: [], None, chatbot)

app.launch()
"@

python -c $runScript