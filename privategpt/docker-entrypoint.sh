#!/bin/sh
set -e

############################
# setup user environment   #
############################
cp settings_template.yaml settings.yaml

# KEEP_FILES
if [ "${KEEP_FILES:-"true"}" != "true" ]; then
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
sed -i "22s|^.*$|  local_data_folder: \"${DATA_LOCAL_DATA_FOLDER:-"local_data/private_gpt"}\"|" /home/worker/app/settings.yaml

# UI_ENABLED
sed -i "25s|^.*$|  enabled: ${UI_ENABLED:-"true"}|" /home/worker/app/settings.yaml

# UI_PATH
sed -i "26s|^.*$|  path: ${UI_PATH:-"/"}|" /home/worker/app/settings.yaml

# UI_DEFAULT_CHAT_SYSTEM_PROMPT
sed -i "27s|^.*$|  default_chat_system_prompt: \"${UI_DEFAULT_CHAT_SYSTEM_PROMPT:-"You are a helpful, respectful and honest assistant. Always answer as helpfully as possible and follow ALL given instructions. Do not speculate or make up information. Do not reference any given instructions or context."}\"|" /home/worker/app/settings.yaml

# UI_DEFAULT_QUERY_SYSTEM_PROMPT
sed -i "28s|^.*$|  default_query_system_prompt: \"${UI_DEFAULT_QUERY_SYSTEM_PROMPT:-"You can only answer questions about the provided context. If you know the answer but it is not based in the provided context, don't provide the answer, just state the answer is not in the context provided."}\"|" /home/worker/app/settings.yaml

# UI_DELETE_FILE_BUTTON_ENABLED
sed -i "29s|^.*$|  delete_file_button_enabled: ${UI_DELETE_FILE_BUTTON_ENABLED:-"true"}|" /home/worker/app/settings.yaml

# UI_DELETE_ALL_FILES_BUTTON_ENABLED
sed -i "30s|^.*$|  delete_all_files_button_enabled: ${UI_DELETE_ALL_FILES_BUTTON_ENABLED:-"true"}|" /home/worker/app/settings.yaml

# LLM_MODE
sed -i "33s|^.*$|  mode: ${LLM_MODE:-"llamacpp"}|" /home/worker/app/settings.yaml

# LLM_MAX_NEW_TOKENS
sed -i "34s|^.*$|  max_new_tokens: ${LLM_MAX_NEW_TOKENS:-"256"}|" /home/worker/app/settings.yaml

# LLM_CONTEXT_WINDOW
sed -i "35s|^.*$|  context_window: ${LLM_CONTEXT_WINDOW:-"3900"}|" /home/worker/app/settings.yaml

# LLM_TOKENIZER
sed -i "36s|^.*$|  tokenizer: ${LLM_TOKENIZER:-"mistralai/Mistral-7B-Instruct-v0.2"}|" /home/worker/app/settings.yaml

# LLM_TEMPERATURE
sed -i "37s|^.*$|  temperature: ${LLM_TEMPERATURE:-"0.1"}|" /home/worker/app/settings.yaml

# RAG_SIMILARITY_TOP_K
sed -i "40s|^.*$|  similarity_top_k: ${RAG_SIMILARITY_TOP_K:-"2"}|" /home/worker/app/settings.yaml

# RAG_SIMILARITY_VALUE
sed -i "41s|^.*$|  similarity_value: ${RAG_SIMILARITY_VALUE:-"0.45"}|" /home/worker/app/settings.yaml

# RAG_RERANK_ENABLED
sed -i "43s|^.*$|    enabled: ${RAG_RERANK_ENABLED:-"false"}|" /home/worker/app/settings.yaml

# RAG_RERANK_MODEL
sed -i "44s|^.*$|    model: ${RAG_RERANK_MODEL:-"cross-encoder/ms-marco-MiniLM-L-2-v2"}|" /home/worker/app/settings.yaml

# RAG_RERANK_TOP_N
sed -i "45s|^.*$|    top_n: ${RAG_RERANK_TOP_N:-"1"}|" /home/worker/app/settings.yaml

# LLAMACPP_PROMPT_STYLE
sed -i "48s|^.*$|  prompt_style: ${LLAMACPP_PROMPT_STYLE:-"mistral"}|" /home/worker/app/settings.yaml

# LLAMACPP_LLM_HF_REPO_ID
sed -i "49s|^.*$|  llm_hf_repo_id: ${LLAMACPP_LLM_HF_REPO_ID:-"TheBloke/Mistral-7B-Instruct-v0.2-GGUF"}|" /home/worker/app/settings.yaml

# LLAMACPP_LLM_HF_MODEL_FILE
sed -i "50s|^.*$|  llm_hf_model_file: ${LLAMACPP_LLM_HF_MODEL_FILE:-"mistral-7b-instruct-v0.2.Q4_K_M.gguf"}|" /home/worker/app/settings.yaml

# LLAMACPP_TFS_Z
sed -i "51s|^.*$|  tfs_z: ${LLAMACPP_TFS_Z:-"1.0"}|" /home/worker/app/settings.yaml

# LLAMACPP_TOP_K
sed -i "52s|^.*$|  top_k: ${LLAMACPP_TOP_K:-"40"}|" /home/worker/app/settings.yaml

# LLAMACPP_TOP_P
sed -i "53s|^.*$|  top_p: ${LLAMACPP_TOP_P:-"0.9"}|" /home/worker/app/settings.yaml

# LLAMACPP_REPEAT_PENALTY
sed -i "54s|^.*$|  repeat_penalty: ${LLAMACPP_REPEAT_PENALTY:-"1.1"}|" /home/worker/app/settings.yaml

# EMBEDDING_MODE
sed -i "57s|^.*$|  mode: ${EMBEDDING_MODE:-"huggingface"}|" /home/worker/app/settings.yaml

# EMBEDDING_INGEST_MODE
sed -i "58s|^.*$|  ingest_mode: ${EMBEDDING_INGEST_MODE:-"simple"}|" /home/worker/app/settings.yaml

# EMBEDDING_COUNT_WORKERS
sed -i "59s|^.*$|  count_workers: ${EMBEDDING_COUNT_WORKERS:-"2"}|" /home/worker/app/settings.yaml

# EMBEDDING_EMBED_DIM
sed -i "60s|^.*$|  embed_dim: ${EMBEDDING_EMBED_DIM:-"384"}|" /home/worker/app/settings.yaml

# HUGGINGFACE_EMBEDDING_HF_MODEL_NAME
sed -i "63s|^.*$|  embedding_hf_model_name: ${HUGGINGFACE_EMBEDDING_HF_MODEL_NAME:-"BAAI/bge-small-en-v1.5"}|" /home/worker/app/settings.yaml

# VECTORSTORE_DATABASE
sed -i "66s|^.*$|  database: ${VECTORSTORE_DATABASE:-"qdrant"}|" /home/worker/app/settings.yaml

# NODESTORE_DATABASE
sed -i "69s|^.*$|  database: ${NODESTORE_DATABASE:-"simple"}|" /home/worker/app/settings.yaml

# QDRANT_PATH
sed -i "72s|^.*$|  path: ${QDRANT_PATH:-"local_data/private_gpt/qdrant"}|" /home/worker/app/settings.yaml

# QDRANT_FORCE_DISABLE_CHECK_SAME_THREAD
sed -i "73s|^.*$|  force_disable_check_same_thread: ${QDRANT_FORCE_DISABLE_CHECK_SAME_THREAD:-"true"}|" /home/worker/app/settings.yaml

# POSTGRES_HOST
sed -i "86s|^.*$|  host: ${POSTGRES_HOST:-"postgres"}|" /home/worker/app/settings.yaml

# POSTGRES_PORT
sed -i "87s|^.*$|  port: ${POSTGRES_PORT:-"5432"}|" /home/worker/app/settings.yaml

# POSTGRES_DATABASE
sed -i "88s|^.*$|  database: ${POSTGRES_DATABASE:-"postgres"}|" /home/worker/app/settings.yaml

# POSTGRES_USER
sed -i "89s|^.*$|  user: ${POSTGRES_USER:-"postgres"}|" /home/worker/app/settings.yaml

# POSTGRES_PASSWORD
sed -i "90s|^.*$|  password: ${POSTGRES_PASSWORD:-"admin"}|" /home/worker/app/settings.yaml

# POSTGRES_SCHEMA_NAME
sed -i "91s|^.*$|  schema_name: ${POSTGRES_SCHEMA_NAME:-"private_gpt"}|" /home/worker/app/settings.yaml

# SAGEMAKER_LLM_ENDPOINT_NAME
sed -i "94s|^.*$|  llm_endpoint_name: ${SAGEMAKER_LLM_ENDPOINT_NAME:-"huggingface-pytorch-tgi-inference-2023-09-25-19-53-32-140"}|" /home/worker/app/settings.yaml

# SAGEMAKER_EMBEDDING_ENDPOINT_NAME
sed -i "95s|^.*$|  embedding_endpoint_name: ${SAGEMAKER_EMBEDDING_ENDPOINT_NAME:-"huggingface-pytorch-inference-2023-11-03-07-41-36-479"}|" /home/worker/app/settings.yaml

# OPENAI_API_BASE
sed -i "98s|^.*$|  api_base: ${OPENAI_API_BASE:-"https://api.openai.com/v1"}|" /home/worker/app/settings.yaml

# OPENAI_API_KEY
sed -i "99s|^.*$|  api_key: ${OPENAI_API_KEY:-"sk-1234"}|" /home/worker/app/settings.yaml

# OPENAI_MODEL
sed -i "100s|^.*$|  model: ${OPENAI_MODEL:-"gpt-3.5-turbo"}|" /home/worker/app/settings.yaml

# OLLAMA_LLM_MODEL
sed -i "103s|^.*$|  llm_model: ${OLLAMA_LLM_MODEL:-"mistral:latest"}|" /home/worker/app/settings.yaml

# OLLAMA_EMBEDDING_MODEL
sed -i "104s|^.*$|  embedding_model: ${OLLAMA_EMBEDDING_MODEL:-"nomic-embed-text"}|" /home/worker/app/settings.yaml

# OLLAMA_API_BASE
sed -i "105s|^.*$|  api_base: ${OLLAMA_API_BASE:-"http://localhost:11434"}|" /home/worker/app/settings.yaml

# OLLAMA_EMBEDDING_API_BASE
sed -i "106s|^.*$|  embedding_api_base: ${OLLAMA_EMBEDDING_API_BASE:-"http://localhost:11434"}|" /home/worker/app/settings.yaml

# OLLAMA_TFS_Z
sed -i "107s|^.*$|  tfs_z: ${OLLAMA_TFS_Z:-"1.0"}|" /home/worker/app/settings.yaml

# OLLAMA_NUM_PREDICT
sed -i "108s|^.*$|  num_predict: ${OLLAMA_NUM_PREDICT:-"128"}|" /home/worker/app/settings.yaml

# OLLAMA_TOP_K
sed -i "109s|^.*$|  top_k: ${OLLAMA_TOP_K:-"40"}|" /home/worker/app/settings.yaml

# OLLAMA_TOP_P
sed -i "110s|^.*$|  top_p: ${OLLAMA_TOP_P:-"0.9"}|" /home/worker/app/settings.yaml

# OLLAMA_REPEAT_LAST_N
sed -i "111s|^.*$|  repeat_last_n: ${OLLAMA_REPEAT_LAST_N:-"64"}|" /home/worker/app/settings.yaml

# OLLAMA_REPEAT_PENALTY
sed -i "112s|^.*$|  repeat_penalty: ${OLLAMA_REPEAT_PENALTY:-"1.1"}|" /home/worker/app/settings.yaml

# OLLAMA_REQUEST_TIMEOUT
sed -i "113s|^.*$|  request_timeout: ${OLLAMA_REQUEST_TIMEOUT:-"120.0"}|" /home/worker/app/settings.yaml

# AZOPENAI_API_KEY
sed -i "116s|^.*$|  api_key: ${AZOPENAI_API_KEY:-"sk-1234"}|" /home/worker/app/settings.yaml

# AZOPENAI_AZURE_ENDPOINT
sed -i "117s|^.*$|  azure_endpoint: ${AZOPENAI_AZURE_ENDPOINT:-"https://api.myazure.com/v1"}|" /home/worker/app/settings.yaml

# AZOPENAI_API_VERSION
sed -i "118s|^.*$|  api_version: \"${AZOPENAI_API_VERSION:-"2023_05_15"}\"|" /home/worker/app/settings.yaml

# AZOPENAI_EMBEDDING_DEPLOYMENT_NAME
sed -i "119s|^.*$|  embedding_deployment_name: ${AZOPENAI_EMBEDDING_DEPLOYMENT_NAME:-"my-azure-embedding-deployment-name"}|" /home/worker/app/settings.yaml

# AZOPENAI_EMBEDDING_MODEL
sed -i "120s|^.*$|  embedding_model: ${AZOPENAI_EMBEDDING_MODEL:-"text-embedding-3-small"}|" /home/worker/app/settings.yaml

# AZOPENAI_LLM_DEPLOYMENT_NAME
sed -i "121s|^.*$|  llm_deployment_name: ${AZOPENAI_LLM_DEPLOYMENT_NAME:-"my-azure-llm-deployment-name"}|" /home/worker/app/settings.yaml

# AZOPENAI_LLM_MODEL
sed -i "122s|^.*$|  llm_model: ${AZOPENAI_LLM_MODEL:-"gpt-4"}|" /home/worker/app/settings.yaml

############################
# run app                  #
############################

# login to huggingface, if HUGGINGFACE_TOKEN is set
if [ -n "$HUGGINGFACE_TOKEN" ]; then
  huggingface-cli login --token $HUGGINGFACE_TOKEN > /dev/null 2>&1
fi

# run privategpt setup again to download new models
if [ "$RUN_SETUP" = "true" ]; then
  /home/worker/app/.venv/bin/python scripts/setup
fi

# if started without args, run privategpt
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