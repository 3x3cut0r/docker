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
line=5
sed -i "${line}s|^.*$|  env_name: ${ENV_NAME:-"prod"}|" /home/worker/app/settings.yaml

# PORT
line=$((line + 1))
sed -i "${line}s|^.*$|  port: ${PORT:-"8080"}|" /home/worker/app/settings.yaml

# CORS_ENABLED
line=$((line + 2))
sed -i "${line}s|^.*$|    enabled: ${CORS_ENABLED:-"false"}|" /home/worker/app/settings.yaml

# CORS_ALLOW_CREDENTIALS
line=$((line + 1))
sed -i "${line}s|^.*$|    allow_credentials: ${CORS_ALLOW_CREDENTIALS:-"false"}|" /home/worker/app/settings.yaml

# CORS_ALLOW_ORIGINS
line=$((line + 1))
sed -i "${line}s|^.*$|    allow_origins: ['${CORS_ALLOW_ORIGINS:-"*"}']|" /home/worker/app/settings.yaml

# CORS_ALLOW_ORIGIN_REGEX
line=$((line + 1))
sed -i "${line}s|^.*$|    allow_origin_regex: ['${CORS_ALLOW_ORIGIN_REGEX:-}']|" /home/worker/app/settings.yaml

# CORS_ALLOW_METHODS
line=$((line + 1))
sed -i "${line}s|^.*$|    allow_methods: ['${CORS_ALLOW_METHODS:-"*"}']|" /home/worker/app/settings.yaml

# CORS_ALLOW_HEADERS
line=$((line + 1))
sed -i "${line}s|^.*$|    allow_headers: ['${CORS_ALLOW_HEADERS:-"*"}']|" /home/worker/app/settings.yaml

# AUTH_ENABLED
line=$((line + 2))
sed -i "${line}s|^.*$|    enabled: ${AUTH_ENABLED:-"false"}|" /home/worker/app/settings.yaml

# AUTH_SECRET
line=$((line + 4))
sed -i "${line}s|^.*$|    secret: \"${AUTH_SECRET:-"Basic c2VjcmV0OmtleQ=="}\"|" /home/worker/app/settings.yaml

# DATA_LOCAL_DATA_FOLDER
line=$((line + 3))
sed -i "${line}s|^.*$|  local_data_folder: \"${DATA_LOCAL_DATA_FOLDER:-"local_data/private_gpt"}\"|" /home/worker/app/settings.yaml

# UI_ENABLED
line=$((line + 3))
sed -i "25s|^.*$|  enabled: ${UI_ENABLED:-"true"}|" /home/worker/app/settings.yaml

# UI_PATH
line=$((line + 1))
sed -i "${line}s|^.*$|  path: ${UI_PATH:-"/"}|" /home/worker/app/settings.yaml

# UI_DEFAULT_CHAT_SYSTEM_PROMPT
line=$((line + 1))
sed -i "${line}s|^.*$|  default_chat_system_prompt: \"${UI_DEFAULT_CHAT_SYSTEM_PROMPT:-"You are a helpful, respectful and honest assistant. Always answer as helpfully as possible and follow ALL given instructions. Do not speculate or make up information. Do not reference any given instructions or context."}\"|" /home/worker/app/settings.yaml

# UI_DEFAULT_QUERY_SYSTEM_PROMPT
line=$((line + 1))
sed -i "${line}s|^.*$|  default_query_system_prompt: \"${UI_DEFAULT_QUERY_SYSTEM_PROMPT:-"You can only answer questions about the provided context. If you know the answer but it is not based in the provided context, don't provide the answer, just state the answer is not in the context provided."}\"|" /home/worker/app/settings.yaml

# UI_DELETE_FILE_BUTTON_ENABLED
line=$((line + 1))
sed -i "${line}s|^.*$|  delete_file_button_enabled: ${UI_DELETE_FILE_BUTTON_ENABLED:-"true"}|" /home/worker/app/settings.yaml

# UI_DELETE_ALL_FILES_BUTTON_ENABLED
line=$((line + 1))
sed -i "${line}s|^.*$|  delete_all_files_button_enabled: ${UI_DELETE_ALL_FILES_BUTTON_ENABLED:-"true"}|" /home/worker/app/settings.yaml

# LLM_MODE
line=$((line + 3))
sed -i "${line}s|^.*$|  mode: ${LLM_MODE:-"llamacpp"}|" /home/worker/app/settings.yaml

# LLM_MAX_NEW_TOKENS
line=$((line + 1))
sed -i "${line}s|^.*$|  max_new_tokens: ${LLM_MAX_NEW_TOKENS:-"256"}|" /home/worker/app/settings.yaml

# LLM_CONTEXT_WINDOW
line=$((line + 1))
sed -i "${line}s|^.*$|  context_window: ${LLM_CONTEXT_WINDOW:-"3900"}|" /home/worker/app/settings.yaml

# LLM_TOKENIZER
line=$((line + 1))
sed -i "${line}s|^.*$|  tokenizer: ${LLM_TOKENIZER:-"meta-llama/Meta-Llama-3.1-8B-Instruct"}|" /home/worker/app/settings.yaml

# LLM_TEMPERATURE
line=$((line + 1))
sed -i "${line}s|^.*$|  temperature: ${LLM_TEMPERATURE:-"0.1"}|" /home/worker/app/settings.yaml

# RAG_SIMILARITY_TOP_K
line=$((line + 3))
sed -i "${line}s|^.*$|  similarity_top_k: ${RAG_SIMILARITY_TOP_K:-"2"}|" /home/worker/app/settings.yaml

# RAG_SIMILARITY_VALUE
line=$((line + 1))
sed -i "${line}s|^.*$|  similarity_value: ${RAG_SIMILARITY_VALUE:-"0.45"}|" /home/worker/app/settings.yaml

# RAG_RERANK_ENABLED
line=$((line + 2))
sed -i "${line}s|^.*$|    enabled: ${RAG_RERANK_ENABLED:-"false"}|" /home/worker/app/settings.yaml

# RAG_RERANK_MODEL
line=$((line + 1))
sed -i "${line}s|^.*$|    model: ${RAG_RERANK_MODEL:-"cross-encoder/ms-marco-MiniLM-L-2-v2"}|" /home/worker/app/settings.yaml

# RAG_RERANK_TOP_N
line=$((line + 1))
sed -i "${line}s|^.*$|    top_n: ${RAG_RERANK_TOP_N:-"1"}|" /home/worker/app/settings.yaml

# SUMMARIZE_USE_ASYNC
line=$((line + 3))
sed -i "${line}s|^.*$|  use_async: ${SUMMARIZE_USE_ASYNC:-"true"}|" /home/worker/app/settings.yaml

# LLAMACPP_PROMPT_STYLE
line=$((line + 3))
sed -i "${line}s|^.*$|  prompt_style: ${LLAMACPP_PROMPT_STYLE:-"llama3"}|" /home/worker/app/settings.yaml

# LLAMACPP_LLM_HF_REPO_ID
line=$((line + 1))
sed -i "${line}s|^.*$|  llm_hf_repo_id: ${LLAMACPP_LLM_HF_REPO_ID:-"lmstudio-community/Meta-Llama-3.1-8B-Instruct-Q4_K_M.gguf"}|" /home/worker/app/settings.yaml

# LLAMACPP_LLM_HF_MODEL_FILE
line=$((line + 1))
sed -i "${line}s|^.*$|  llm_hf_model_file: ${LLAMACPP_LLM_HF_MODEL_FILE:-"Meta-Llama-3.1-8B-Instruct-Q4_K_M.gguf"}|" /home/worker/app/settings.yaml

# LLAMACPP_TFS_Z
line=$((line + 1))
sed -i "${line}s|^.*$|  tfs_z: ${LLAMACPP_TFS_Z:-"1.0"}|" /home/worker/app/settings.yaml

# LLAMACPP_TOP_K
line=$((line + 1))
sed -i "${line}s|^.*$|  top_k: ${LLAMACPP_TOP_K:-"40"}|" /home/worker/app/settings.yaml

# LLAMACPP_TOP_P
line=$((line + 1))
sed -i "${line}s|^.*$|  top_p: ${LLAMACPP_TOP_P:-"0.9"}|" /home/worker/app/settings.yaml

# LLAMACPP_REPEAT_PENALTY
line=$((line + 1))
sed -i "${line}s|^.*$|  repeat_penalty: ${LLAMACPP_REPEAT_PENALTY:-"1.1"}|" /home/worker/app/settings.yaml

# EMBEDDING_MODE
line=$((line + 3))
sed -i "${line}s|^.*$|  mode: ${EMBEDDING_MODE:-"huggingface"}|" /home/worker/app/settings.yaml

# EMBEDDING_INGEST_MODE
line=$((line + 1))
sed -i "${line}s|^.*$|  ingest_mode: ${EMBEDDING_INGEST_MODE:-"simple"}|" /home/worker/app/settings.yaml

# EMBEDDING_COUNT_WORKERS
line=$((line + 1))
sed -i "${line}s|^.*$|  count_workers: ${EMBEDDING_COUNT_WORKERS:-"2"}|" /home/worker/app/settings.yaml

# EMBEDDING_EMBED_DIM
line=$((line + 1))
sed -i "${line}s|^.*$|  embed_dim: ${EMBEDDING_EMBED_DIM:-"384"}|" /home/worker/app/settings.yaml

# HUGGINGFACE_EMBEDDING_HF_MODEL_NAME
line=$((line + 3))
sed -i "${line}s|^.*$|  embedding_hf_model_name: ${HUGGINGFACE_EMBEDDING_HF_MODEL_NAME:-"nomic-ai/nomic-embed-text-v1.5"}|" /home/worker/app/settings.yaml

# HUGGINGFACE_ACCESS_TOKEN
line=$((line + 1))
sed -i "${line}s|^.*$|  access_token: ${HUGGINGFACE_ACCESS_TOKEN:-"hf_1234"}|" /home/worker/app/settings.yaml

# HUGGINGFACE_TRUST_REMOTE_CODE
line=$((line + 1))
sed -i "${line}s|^.*$|  trust_remote_code: ${HUGGINGFACE_TRUST_REMOTE_CODE:-"true"}|" /home/worker/app/settings.yaml

# VECTORSTORE_DATABASE
line=$((line + 3))
sed -i "${line}s|^.*$|  database: ${VECTORSTORE_DATABASE:-"qdrant"}|" /home/worker/app/settings.yaml

# NODESTORE_DATABASE
line=$((line + 3))
sed -i "${line}s|^.*$|  database: ${NODESTORE_DATABASE:-"simple"}|" /home/worker/app/settings.yaml

# MILVUS_URI
line=$((line + 3))
sed -i "${line}s|^.*$|  uri: ${MILVUS_URI:-"local_data/private_gpt/milvus/milvus_local.db"}|" /home/worker/app/settings.yaml

# MILVUS_TOKEN
line=$((line + 1))
sed -i "${line}s|^.*$|  token: ${MILVUS_TOKEN:-"milvus-1234"}|" /home/worker/app/settings.yaml

# MILVUS_COLLECTION_NAME
line=$((line + 1))
sed -i "${line}s|^.*$|  collection_name: ${MILVUS_COLLECTION_NAME:-"milvus_db"}|" /home/worker/app/settings.yaml

# MILVUS_OVERWRITE
line=$((line + 1))
sed -i "${line}s|^.*$|  overwrite: ${MILVUS_OVERWRITE:-"false"}|" /home/worker/app/settings.yaml

# QDRANT_PATH
line=$((line + 3))
sed -i "${line}s|^.*$|  path: ${QDRANT_PATH:-"local_data/private_gpt/qdrant"}|" /home/worker/app/settings.yaml

# QDRANT_FORCE_DISABLE_CHECK_SAME_THREAD
line=$((line + 1))
sed -i "${line}s|^.*$|  force_disable_check_same_thread: ${QDRANT_FORCE_DISABLE_CHECK_SAME_THREAD:-"true"}|" /home/worker/app/settings.yaml

# CLICKHOUSE_HOST
line=$((line + 13))
sed -i "${line}s|^.*$|  host: ${CLICKHOUSE_HOST:-"localhost"}|" /home/worker/app/settings.yaml

# CLICKHOUSE_PORT
line=$((line + 1))
sed -i "${line}s|^.*$|  port: ${CLICKHOUSE_PORT:-"8443"}|" /home/worker/app/settings.yaml

# CLICKHOUSE_USERNAME
line=$((line + 1))
sed -i "${line}s|^.*$|  username: ${CLICKHOUSE_USERNAME:-"admin"}|" /home/worker/app/settings.yaml

# CLICKHOUSE_PASSWORD
line=$((line + 1))
sed -i "${line}s|^.*$|  password: ${CLICKHOUSE_PASSWORD:-"clickhouse"}|" /home/worker/app/settings.yaml

# CLICKHOUSE_DATABASE
line=$((line + 1))
sed -i "${line}s|^.*$|  database: ${CLICKHOUSE_DATABASE:-"embeddings"}|" /home/worker/app/settings.yaml

# CLICKHOUSE_SECURE
line=$((line + 1))
sed -i "${line}s|^.*$|  secure: ${CLICKHOUSE_SECURE:-"False"}|" /home/worker/app/settings.yaml

# CLICKHOUSE_INTERFACE
line=$((line + 1))
sed -i "${line}s|^.*$|  interface: ${CLICKHOUSE_INTERFACE:-""}|" /home/worker/app/settings.yaml

# CLICKHOUSE_SETTINGS
line=$((line + 1))
sed -i "${line}s|^.*$|  settings: ${CLICKHOUSE_SETTINGS:-""}|" /home/worker/app/settings.yaml

# CLICKHOUSE_CONNECT_TIMEOUT
line=$((line + 1))
sed -i "${line}s|^.*$|  connect_timeout: ${CLICKHOUSE_CONNECT_TIMEOUT:-""}|" /home/worker/app/settings.yaml

# CLICKHOUSE_SEND_RECEIVE_TIMEOUT
line=$((line + 1))
sed -i "${line}s|^.*$|  send_receive_timeout: ${CLICKHOUSE_SEND_RECEIVE_TIMEOUT:-""}|" /home/worker/app/settings.yaml

# CLICKHOUSE_VERIFY
line=$((line + 1))
sed -i "${line}s|^.*$|  verify: ${CLICKHOUSE_VERIFY:-""}|" /home/worker/app/settings.yaml

# CLICKHOUSE_CA_CERT
line=$((line + 1))
sed -i "${line}s|^.*$|  ca_cert: ${CLICKHOUSE_CA_CERT:-""}|" /home/worker/app/settings.yaml

# CLICKHOUSE_CLIENT_CERT
line=$((line + 1))
sed -i "${line}s|^.*$|  client_cert: ${CLICKHOUSE_CLIENT_CERT:-""}|" /home/worker/app/settings.yaml

# CLICKHOUSE_CLIENT_CERT_KEY
line=$((line + 1))
sed -i "${line}s|^.*$|  client_cert_key: ${CLICKHOUSE_CLIENT_CERT_KEY:-""}|" /home/worker/app/settings.yaml

# CLICKHOUSE_HTTP_PROXY
line=$((line + 1))
sed -i "${line}s|^.*$|  http_proxy: ${CLICKHOUSE_HTTP_PROXY:-""}|" /home/worker/app/settings.yaml

# CLICKHOUSE_HTTPS_PROXY
line=$((line + 1))
sed -i "${line}s|^.*$|  https_proxy: ${CLICKHOUSE_HTTPS_PROXY:-""}|" /home/worker/app/settings.yaml

# CLICKHOUSE_SERVER_HOST_NAME
line=$((line + 1))
sed -i "${line}s|^.*$|  server_host_name: ${CLICKHOUSE_SERVER_HOST_NAME:-""}|" /home/worker/app/settings.yaml

# POSTGRES_HOST
line=$((line + 3))
sed -i "${line}s|^.*$|  host: ${POSTGRES_HOST:-"postgres"}|" /home/worker/app/settings.yaml

# POSTGRES_PORT
line=$((line + 1))
sed -i "${line}s|^.*$|  port: ${POSTGRES_PORT:-"5432"}|" /home/worker/app/settings.yaml

# POSTGRES_DATABASE
line=$((line + 1))
sed -i "${line}s|^.*$|  database: ${POSTGRES_DATABASE:-"postgres"}|" /home/worker/app/settings.yaml

# POSTGRES_USER
line=$((line + 1))
sed -i "${line}s|^.*$|  user: ${POSTGRES_USER:-"postgres"}|" /home/worker/app/settings.yaml

# POSTGRES_PASSWORD
line=$((line + 1))
sed -i "${line}s|^.*$|  password: ${POSTGRES_PASSWORD:-"admin"}|" /home/worker/app/settings.yaml

# POSTGRES_SCHEMA_NAME
line=$((line + 1))
sed -i "${line}s|^.*$|  schema_name: ${POSTGRES_SCHEMA_NAME:-"private_gpt"}|" /home/worker/app/settings.yaml

# SAGEMAKER_LLM_ENDPOINT_NAME
line=$((line + 3))
sed -i "${line}s|^.*$|  llm_endpoint_name: ${SAGEMAKER_LLM_ENDPOINT_NAME:-"huggingface-pytorch-tgi-inference-2023-09-25-19-53-32-140"}|" /home/worker/app/settings.yaml

# SAGEMAKER_EMBEDDING_ENDPOINT_NAME
line=$((line + 1))
sed -i "${line}s|^.*$|  embedding_endpoint_name: ${SAGEMAKER_EMBEDDING_ENDPOINT_NAME:-"huggingface-pytorch-inference-2023-11-03-07-41-36-479"}|" /home/worker/app/settings.yaml

# OPENAI_API_BASE
line=$((line + 3))
sed -i "${line}s|^.*$|  api_base: ${OPENAI_API_BASE:-"https://api.openai.com/v1"}|" /home/worker/app/settings.yaml

# OPENAI_API_KEY
line=$((line + 1))
sed -i "${line}s|^.*$|  api_key: ${OPENAI_API_KEY:-"sk-1234"}|" /home/worker/app/settings.yaml

# OPENAI_MODEL
line=$((line + 1))
sed -i "${line}s|^.*$|  model: ${OPENAI_MODEL:-"gpt-3.5-turbo"}|" /home/worker/app/settings.yaml

# OPENAI_REQUEST_TIMEOUT
line=$((line + 1))
sed -i "${line}s|^.*$|  request_timeout: ${OPENAI_REQUEST_TIMEOUT:-"120.0"}|" /home/worker/app/settings.yaml

# OPENAI_EMBEDDING_API_BASE
line=$((line + 1))
sed -i "${line}s|^.*$|  embedding_api_base: ${OPENAI_EMBEDDING_API_BASE:-$OPENAI_API_BASE}|" /home/worker/app/settings.yaml

# OPENAI_EMBEDDING_API_KEY
line=$((line + 1))
sed -i "${line}s|^.*$|  embedding_api_key: ${OPENAI_EMBEDDING_API_KEY:-$OPENAI_API_KEY}|" /home/worker/app/settings.yaml

# OPENAI_EMBEDDING_MODEL
line=$((line + 1))
sed -i "${line}s|^.*$|  embedding_model: ${OPENAI_EMBEDDING_MODEL:-"text-embedding-3-small"}|" /home/worker/app/settings.yaml

# GEMINI_API_KEY
line=$((line + 3))
sed -i "${line}s|^.*$|  api_key: ${GEMINI_API_KEY:-"AI1234"}|" /home/worker/app/settings.yaml

# GEMINI_MODEL
line=$((line + 1))
sed -i "${line}s|^.*$|  model: ${GEMINI_MODEL:-"models/gemini-pro"}|" /home/worker/app/settings.yaml

# GEMINI_EMBEDDING_MODEL
line=$((line + 1))
sed -i "${line}s|^.*$|  embedding_model: ${GEMINI_EMBEDDING_MODEL:-"models/embedding-001"}|" /home/worker/app/settings.yaml

# OLLAMA_API_BASE
line=$((line + 3))
sed -i "${line}s|^.*$|  api_base: ${OLLAMA_API_BASE:-"http://localhost:11434"}|" /home/worker/app/settings.yaml

# OLLAMA_EMBEDDING_API_BASE
line=$((line + 1))
sed -i "${line}s|^.*$|  embedding_api_base: ${OLLAMA_EMBEDDING_API_BASE:-$OLLAMA_API_BASE}|" /home/worker/app/settings.yaml

# OLLAMA_LLM_MODEL
line=$((line + 1))
sed -i "${line}s|^.*$|  llm_model: ${OLLAMA_LLM_MODEL:-"llama3.1:latest"}|" /home/worker/app/settings.yaml

# OLLAMA_EMBEDDING_MODEL
line=$((line + 1))
sed -i "${line}s|^.*$|  embedding_model: ${OLLAMA_EMBEDDING_MODEL:-"nomic-embed-text"}|" /home/worker/app/settings.yaml

# OLLAMA_KEEP_ALIVE
line=$((line + 1))
sed -i "${line}s|^.*$|  keep_alive: ${OLLAMA_KEEP_ALIVE:-"5m"}|" /home/worker/app/settings.yaml

# OLLAMA_TFS_Z
line=$((line + 1))
sed -i "${line}s|^.*$|  tfs_z: ${OLLAMA_TFS_Z:-"1.0"}|" /home/worker/app/settings.yaml

# OLLAMA_NUM_PREDICT
line=$((line + 1))
sed -i "${line}s|^.*$|  num_predict: ${OLLAMA_NUM_PREDICT:-"128"}|" /home/worker/app/settings.yaml

# OLLAMA_TOP_K
line=$((line + 1))
sed -i "${line}s|^.*$|  top_k: ${OLLAMA_TOP_K:-"40"}|" /home/worker/app/settings.yaml

# OLLAMA_TOP_P
line=$((line + 1))
sed -i "${line}s|^.*$|  top_p: ${OLLAMA_TOP_P:-"0.9"}|" /home/worker/app/settings.yaml

# OLLAMA_REPEAT_LAST_N
line=$((line + 1))
sed -i "${line}s|^.*$|  repeat_last_n: ${OLLAMA_REPEAT_LAST_N:-"64"}|" /home/worker/app/settings.yaml

# OLLAMA_REPEAT_PENALTY
line=$((line + 1))
sed -i "${line}s|^.*$|  repeat_penalty: ${OLLAMA_REPEAT_PENALTY:-"1.1"}|" /home/worker/app/settings.yaml

# OLLAMA_REQUEST_TIMEOUT
line=$((line + 1))
sed -i "${line}s|^.*$|  request_timeout: ${OLLAMA_REQUEST_TIMEOUT:-"120.0"}|" /home/worker/app/settings.yaml

# AZOPENAI_API_KEY
line=$((line + 3))
sed -i "${line}s|^.*$|  api_key: ${AZOPENAI_API_KEY:-"sk-1234"}|" /home/worker/app/settings.yaml

# AZOPENAI_AZURE_ENDPOINT
line=$((line + 1))
sed -i "${line}s|^.*$|  azure_endpoint: ${AZOPENAI_AZURE_ENDPOINT:-"https://api.myazure.com/v1"}|" /home/worker/app/settings.yaml

# AZOPENAI_API_VERSION
line=$((line + 1))
sed -i "${line}s|^.*$|  api_version: \"${AZOPENAI_API_VERSION:-"2023_05_15"}\"|" /home/worker/app/settings.yaml

# AZOPENAI_EMBEDDING_DEPLOYMENT_NAME
line=$((line + 1))
sed -i "${line}s|^.*$|  embedding_deployment_name: ${AZOPENAI_EMBEDDING_DEPLOYMENT_NAME:-"my-azure-embedding-deployment-name"}|" /home/worker/app/settings.yaml

# AZOPENAI_EMBEDDING_MODEL
line=$((line + 1))
sed -i "${line}s|^.*$|  embedding_model: ${AZOPENAI_EMBEDDING_MODEL:-"text-embedding-3-small"}|" /home/worker/app/settings.yaml

# AZOPENAI_LLM_DEPLOYMENT_NAME
line=$((line + 1))
sed -i "${line}s|^.*$|  llm_deployment_name: ${AZOPENAI_LLM_DEPLOYMENT_NAME:-"my-azure-llm-deployment-name"}|" /home/worker/app/settings.yaml

# AZOPENAI_LLM_MODEL
line=$((line + 1))
sed -i "${line}s|^.*$|  llm_model: ${AZOPENAI_LLM_MODEL:-"gpt-4"}|" /home/worker/app/settings.yaml

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