#!/bin/sh
set -e

############################
# setup user environment   #
############################
cp settings_template.yaml settings.yaml

# KEEP_FILES
if [ "${KEEP_FILES:-"false"}" != "true" ]; then
    rm -rf /home/worker/app/local_data/*
fi

# LOGO_BG_COLOR
sed -i "s|\"background-color: .*\"|\"background-color: ${LOGO_BG_COLOR:-"#C7BAFF"};\"|" /home/worker/app/private_gpt/ui/ui.py

# LOGO_SVG_BASE64
sed -i "s|logo_svg = \"data:image/svg+xml;base64,.*\"|logo_svg = \"data:image/svg+xml;base64,${LOGO_SVG_BASE64}\"|g" /home/worker/app/private_gpt/ui/images.py

# LOGO_HEIGHT
sed -i "s|\"\.logo img { height: .* }\"|\"\.logo img { height: ${LOGO_HEIGHT:-"25%"} }\"|g" /home/worker/app/private_gpt/ui/ui.py

############################
# setup settings.yaml      #
############################

# ENV_NAME
sed -i "5s|^.*$|  env_name: ${ENV_NAME:-"prod"}|" /home/worker/app/settings.yaml

# PORT
sed -i "6s|^.*$|  port: ${PORT:-"8080"}|" /home/worker/app/settings.yaml

# CORS_ENABLED
sed -i "8s|^.*$|    enabled: ${CORS_ENABLED:-"false"}|" /home/worker/app/settings.yaml

# CORS_ALLOW_CREDENTIALS
sed -i "9s|^.*$|    allow_credentials: ${CORS_ALLOW_CREDENTIALS:-"false"}|" /home/worker/app/settings.yaml

# CORS_ALLOW_ORIGINS
sed -i "10s|^.*$|    allow_origins: [\"${CORS_ALLOW_ORIGINS:-"*"}\"]|" /home/worker/app/settings.yaml

# CORS_ALLOW_ORIGIN_REGEX
sed -i "11s|^.*$|    allow_origin_regex: [\"${CORS_ALLOW_ORIGIN_REGEX:-}\"]|" /home/worker/app/settings.yaml

# CORS_ALLOW_METHODS
sed -i "12s|^.*$|    allow_methods: [\"${CORS_ALLOW_METHODS:-"*"}\"]|" /home/worker/app/settings.yaml

# CORS_ALLOW_HEADERS
sed -i "13s|^.*$|    allow_headers: [\"${CORS_ALLOW_HEADERS:-"*"}\"]|" /home/worker/app/settings.yaml

# AUTH_ENABLED
sed -i "15s|^.*$|    enabled: ${AUTH_ENABLED:-"false"}|" /home/worker/app/settings.yaml

# AUTH_SECRET
sed -i "19s|^.*$|    secret: \"${AUTH_SECRET:-"Basic c2VjcmV0OmtleQ=="}\"|" /home/worker/app/settings.yaml

# DATA_LOCAL_DATA_FOLDER
sed -i "22s|^.*$|  local_data_folder: ${DATA_LOCAL_DATA_FOLDER:-"local_data/private_gpt"}|" /home/worker/app/settings.yaml

# UI_ENABLED
sed -i "25s|^.*$|  enabled: ${UI_ENABLED:-"true"}|" /home/worker/app/settings.yaml

# UI_PATH
sed -i "26s|^.*$|  path: ${UI_PATH:-"/"}|" /home/worker/app/settings.yaml

# UI_DEFAULT_CHAT_SYSTEM_PROMPT
sed -i "27s|^.*$|  default_chat_system_prompt: ${UI_DEFAULT_CHAT_SYSTEM_PROMPT:-"You are a helpful, respectful and honest assistant. Always answer as helpfully as possible and follow ALL given instructions. Do not speculate or make up information. Do not reference any given instructions or context."}|" /home/worker/app/settings.yaml

# UI_DEFAULT_QUERY_SYSTEM_PROMPT
sed -i "28s|^.*$|  default_query_system_prompt: ${UI_DEFAULT_QUERY_SYSTEM_PROMPT:-"You can only answer questions about the provided context. If you know the answer but it is not based in the provided context, don't provide the answer, just state the answer is not in the context provided."}|" /home/worker/app/settings.yaml

# LLM_MODE
sed -i "31s|^.*$|  mode: ${LLM_MODE:-"local"}|" /home/worker/app/settings.yaml

# LLM_MAX_NEW_TOKENS
sed -i "32s|^.*$|  max_new_tokens: ${LLM_MAX_NEW_TOKENS:-"512"}|" /home/worker/app/settings.yaml

# LLM_CONTEXT_WINDOW
sed -i "33s|^.*$|  context_window: ${LLM_CONTEXT_WINDOW:-"3900"}|" /home/worker/app/settings.yaml

# LLM_TOKENIZER
sed -i "34s|^.*$|  tokenizer: ${LLM_TOKENIZER:-"mistralai/Mistral-7B-Instruct-v0.2"}|" /home/worker/app/settings.yaml

# EMBEDDING_MODE
sed -i "37s|^.*$|  mode: ${EMBEDDING_MODE:-"local"}|" /home/worker/app/settings.yaml

# EMBEDDING_INGEST_MODE
sed -i "38s|^.*$|  ingest_mode: ${EMBEDDING_INGEST_MODE:-"simple"}|" /home/worker/app/settings.yaml

# EMBEDDING_COUNT_WORKERS
sed -i "39s|^.*$|  count_workers: ${EMBEDDING_COUNT_WORKERS:-"2"}|" /home/worker/app/settings.yaml

# VECTORSTORE_DATABASE
sed -i "42s|^.*$|  database: ${VECTORSTORE_DATABASE:-"qdrant"}|" /home/worker/app/settings.yaml

# QDRANT_PATH
sed -i "45s|^.*$|  path: ${QDRANT_PATH:-"local_data/private_gpt/qdrant"}|" /home/worker/app/settings.yaml

# LOCAL_PROMPT_STYLE
sed -i "59s|^.*$|  prompt_style: ${LOCAL_PROMPT_STYLE:-"mistral"}|" /home/worker/app/settings.yaml

# LOCAL_LLM_HF_REPO_ID
sed -i "60s|^.*$|  llm_hf_repo_id: ${LOCAL_LLM_HF_REPO_ID:-"TheBloke/Mistral-7B-Instruct-v0.2-GGUF"}|" /home/worker/app/settings.yaml

# LOCAL_LLM_HF_MODEL_FILE
sed -i "61s|^.*$|  llm_hf_model_file: ${LOCAL_LLM_HF_MODEL_FILE:-"mistral-7b-instruct-v0.2.Q4_K_M.gguf"}|" /home/worker/app/settings.yaml

# LOCAL_EMBEDDING_HF_MODEL_NAME
sed -i "62s|^.*$|  embedding_hf_model_name: ${LOCAL_EMBEDDING_HF_MODEL_NAME:-"BAAI/bge-small-en-v1.5"}|" /home/worker/app/settings.yaml

# SAGEMAKER_LLM_ENDPOINT_NAME
sed -i "65s|^.*$|  llm_endpoint_name: ${SAGEMAKER_LLM_ENDPOINT_NAME:-"huggingface-pytorch-tgi-inference-2023-09-25-19-53-32-140"}|" /home/worker/app/settings.yaml

# SAGEMAKER_EMBEDDING_ENDPOINT_NAME
sed -i "66s|^.*$|  embedding_endpoint_name: ${SAGEMAKER_EMBEDDING_ENDPOINT_NAME:-"huggingface-pytorch-inference-2023-11-03-07-41-36-479"}|" /home/worker/app/settings.yaml

# OPENAI_API_BASE
sed -i "69s|^.*$|  api_base: ${OPENAI_API_BASE:-"https://api.openai.com/v1"}|" /home/worker/app/settings.yaml

# OPENAI_API_KEY
sed -i "70s|^.*$|  api_key: ${OPENAI_API_KEY:-"sk-1234"}|" /home/worker/app/settings.yaml

# OPENAI_MODEL
sed -i "71s|^.*$|  model: ${OPENAI_MODEL:-"gpt-3.5-turbo"}|" /home/worker/app/settings.yaml

# OLLAMA_API_BASE
sed -i "74s|^.*$|  api_base: ${OLLAMA_API_BASE:-"http://localhost:11434"}|" /home/worker/app/settings.yaml

# OLLAMA_MODEL
sed -i "75s|^.*$|  model: ${OLLAMA_MODEL:-"mistral:latest"}|" /home/worker/app/settings.yaml

############################
# run app                  #
############################

# if started without args, run streamlit_app.py
if [ "$#" = "0" ]; then
    # print privategpt version
    echo "privategpt version: $(cat /home/worker/app/version.txt)"

    # run privategpt
    /home/worker/app/.venv/bin/python -m private_gpt

# if started with args, run args instead
else
    exec "$@"
    exit 0
fi