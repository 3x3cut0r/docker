# Base-Stage
FROM python:3.11.8-slim-bookworm as base

# ADD HUGGINGFACE_TOKEN
ARG HUGGINGFACE_TOKEN

# Install poetry
RUN pip install pipx
RUN python3 -m pipx ensurepath
RUN pipx install poetry
ENV PATH="/root/.local/bin:$PATH"
ENV PATH=".venv/bin/:$PATH"

# Dependencies to build llama-cpp
RUN apt update && apt install -y \
        libopenblas-dev \
        ninja-build \
        build-essential \
        graphicsmagick \
        pkg-config \
        wget \
        curl \
        git \
        jq && \
    python -m pip install --upgrade pip huggingface_hub && \
    huggingface-cli login --token $HUGGINGFACE_TOKEN && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# https://python-poetry.org/docs/configuration/#virtualenvsin-project
ENV POETRY_VIRTUALENVS_IN_PROJECT=true

# Dependencies-Stage
FROM base as dependencies

WORKDIR /home/worker/app
RUN git clone https://github.com/zylon-ai/private-gpt .
COPY settings_template.yaml .
RUN poetry install --extras "ui llms-llama-cpp llms-openai llms-openai-like llms-ollama llms-sagemaker llms-azopenai embeddings-ollama embeddings-huggingface embeddings-openai embeddings-sagemaker embeddings-azopenai vector-stores-qdrant vector-stores-chroma vector-stores-postgres storage-nodestore-postgres" && \
    poetry run python scripts/setup && \
    rm -rf \
        .git* \
        .docker* \
        docker* \
        Dockerfile* \
        local_data/.gitignore \
        models/cache/models--* \
        models/embedding/* \
        models/mistral* \
        settings-* \
        tests*

# App-Stage
FROM base as app
LABEL maintainer="Julian Reith <julianreith@gmx.de>"
LABEL description="Docker container for privateGPT - a production-ready AI project that allows you to ask questions about your documents using the power of Large Language Models (LLMs)."

ARG CMAKE_ARGS='-DLLAMA_BLAS=ON -DLLAMA_BLAS_VENDOR="OpenBLAS" -DLLAMA_AVX=OFF -DLLAMA_AVX2=OFF -DLLAMA_F16C=OFF -DLLAMA_FMA=OFF'
    
ENV MPLCONFIGDIR="/home/worker/app/models/.config/matplotlib" \
    HF_HOME="/home/worker/app/models/cache" \
    PYTHONUNBUFFERED=1 \
    PORT=8080
EXPOSE 8080

# Prepare a non-root user "worker"
RUN adduser --system worker
WORKDIR /home/worker/app

# Copy from dependencies
COPY --chown=worker --from=dependencies /home/worker/app/ ./
RUN mkdir -p local_data models/cache .config/matplotlib && \
    chown -R worker:nogroup /home/worker/app && \
    pip install doc2text docx2txt EbookLib html2text python-pptx Pillow && \
    FORCE_CMAKE=1 CMAKE_ARGS="${CMAKE_ARGS}" \
    /home/worker/app/.venv/bin/pip install --force-reinstall --no-cache-dir llama-cpp-python && \
    huggingface-cli logout

# Store versions in /VERSION
RUN touch /VERSION && \
    echo "debian=$(cat /etc/issue | cut -d' ' -f3)" > /VERSION && \
    echo "python=$(/home/worker/app/.venv/bin/python3 --version | cut -d' ' -f2)" >> /VERSION && \
    echo "pip=$(/home/worker/app/.venv/bin/pip3 --version| cut -d' ' -f2)" >> /VERSION && \
    echo "llama-cpp-python=$(/home/worker/app/.venv/bin/pip3 freeze | grep llama_cpp_python | cut -d= -f3)" >> /VERSION && \
    echo "privategpt=$(cat /home/worker/app/version.txt)" >> /VERSION

# Setup environment
ENV PYTHONPATH="$PYTHONPATH:/private_gpt/" \
    QUIET="false" \
    KEEP_FILES="true" \
    LOGO_BG_COLOR="#C7BAFF" \
    LOGO_HEIGHT="25%" \
    LOGO_SVG_BASE64="PHN2ZyB3aWR0aD0iODYxIiBoZWlnaHQ9Ijk4IiB2aWV3Qm94PSIwIDAgODYxIDk4IiBmaWxsPSJub25lIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPgo8cGF0aCBkPSJNNDguMTM0NSAwLjE1NzkxMUMzNi44Mjk5IDEuMDM2NTQgMjYuMTIwNSA1LjU1MzI4IDE3LjYyNTYgMTMuMDI1QzkuMTMwNDYgMjAuNDk2NyAzLjMxMTcgMzAuNTE2OSAxLjA0OTUyIDQxLjU3MDVDLTEuMjEyNzMgNTIuNjIzOCAwLjIwNDQxOSA2NC4xMDk0IDUuMDg2MiA3NC4yOTA1QzkuOTY4NjggODQuNDcxNiAxOC4wNTAzIDkyLjc5NDMgMjguMTA5OCA5OEwzMy43MDI2IDgyLjU5MDdMMzUuNDU0MiA3Ny43NjU2QzI5LjgzODcgNzQuMTY5MiAyNS41NDQ0IDY4Ljg2MDcgMjMuMjE0IDYyLjYzNDRDMjAuODgyMiA1Ni40MDg2IDIwLjYzOSA0OS41OTkxIDIyLjUyMDQgNDMuMjI0M0MyNC40MDI5IDM2Ljg0OTUgMjguMzA5NiAzMS4yNTI1IDMzLjY1NjEgMjcuMjcwNkMzOS4wMDIgMjMuMjg4MyA0NS41MDAzIDIxLjEzNSA1Mi4xNzg5IDIxLjEzM0M1OC44NTczIDIxLjEzMDMgNjUuMzU3MSAyMy4yNzgzIDcwLjcwNjUgMjcuMjU1OEM3Ni4wNTU0IDMxLjIzNCA3OS45NjY0IDM2LjgyNzcgODEuODU0MyA0My4yMDA2QzgzLjc0MjkgNDkuNTczNiA4My41MDYyIDU2LjM4MzYgODEuMTgwMSA2Mi42MTE3Qzc4Ljg1NDUgNjguODM5NiA3NC41NjUgNzQuMTUxNCA2OC45NTI5IDc3Ljc1MjhMNzAuNzA3NCA4Mi41OTA3TDc2LjMwMDIgOTcuOTk3MUM4Ni45Nzg4IDkyLjQ3MDUgOTUuNDA4OCA4My40NDE5IDEwMC4xNjMgNzIuNDQwNEMxMDQuOTE3IDYxLjQzOTQgMTA1LjcwNCA0OS4xNDE3IDEwMi4zODkgMzcuNjNDOTkuMDc0NiAyNi4xMTc5IDkxLjg2MjcgMTYuMDk5MyA4MS45NzQzIDkuMjcwNzlDNzIuMDg2MSAyLjQ0MTkxIDYwLjEyOTEgLTAuNzc3MDg2IDQ4LjEyODYgMC4xNTg5MzRMNDguMTM0NSAwLjE1NzkxMVoiIGZpbGw9IiMxRjFGMjkiLz4KPGcgY2xpcC1wYXRoPSJ1cmwoI2NsaXAwXzVfMTkpIj4KPHBhdGggZD0iTTIyMC43NzIgMTIuNzUyNEgyNTIuNjM5QzI2Ny4yNjMgMTIuNzUyNCAyNzcuNzM5IDIxLjk2NzUgMjc3LjczOSAzNS40MDUyQzI3Ny43MzkgNDYuNzg3IDI2OS44ODEgNTUuMzUwOCAyNTguMzE0IDU3LjQxMDdMMjc4LjgzIDg1LjM3OTRIMjYxLjM3TDI0Mi4wNTQgNTcuOTUzM0gyMzUuNTA2Vjg1LjM3OTRIMjIwLjc3NEwyMjAuNzcyIDEyLjc1MjRaTTIzNS41MDQgMjYuMzAyOFY0NC40MDdIMjUyLjYzMkMyNTguOTYyIDQ0LjQwNyAyNjIuOTk5IDQwLjgyOTggMjYyLjk5OSAzNS40MTAyQzI2Mi45OTkgMjkuODgwOSAyNTguOTYyIDI2LjMwMjggMjUyLjYzMiAyNi4zMDI4SDIzNS41MDRaIiBmaWxsPSIjMUYxRjI5Ii8+CjxwYXRoIGQ9Ik0yOTUuMTc2IDg1LjM4NDRWMTIuNzUyNEgzMDkuOTA5Vjg1LjM4NDRIMjk1LjE3NloiIGZpbGw9IiMxRjFGMjkiLz4KPHBhdGggZD0iTTM2My43OTUgNjUuNzYzTDM4NS42MiAxMi43NTI0SDQwMS40NDRMMzcxLjIxNSA4NS4zODQ0SDM1Ni40ODNMMzI2LjI1NCAxMi43NTI0SDM0Mi4wNzhMMzYzLjc5NSA2NS43NjNaIiBmaWxsPSIjMUYxRjI5Ii8+CjxwYXRoIGQ9Ik00NDguMzI3IDcyLjA1MDRINDE1LjY5OEw0MTAuMjQxIDg1LjM4NDRIMzk0LjQxOEw0MjQuNjQ3IDEyLjc1MjRINDM5LjM3OUw0NjkuNjA4IDg1LjM4NDRINDUzLjc4M0w0NDguMzI3IDcyLjA1MDRaTTQ0Mi43NjEgNTguNUw0MzIuMDY2IDMyLjM3NDhMNDIxLjI2MiA1OC41SDQ0Mi43NjFaIiBmaWxsPSIjMUYxRjI5Ii8+CjxwYXRoIGQ9Ik00NjUuMjIxIDEyLjc1MjRINTMwLjU5MlYyNi4zMDI4SDUwNS4yNzVWODUuMzg0NEg0OTAuNTM5VjI2LjMwMjhINDY1LjIyMVYxMi43NTI0WiIgZmlsbD0iIzFGMUYyOSIvPgo8cGF0aCBkPSJNNTk1LjE5MyAxMi43NTI0VjI2LjMwMjhINTYyLjEyOFY0MS4xNTUxSDU5NS4xOTNWNTQuNzA2NUg1NjIuMTI4VjcxLjgzNEg1OTUuMTkzVjg1LjM4NDRINTQ3LjM5NVYxMi43NTI0SDU5NS4xOTNaIiBmaWxsPSIjMUYxRjI5Ii8+CjxwYXRoIGQ9Ik0xNjcuMjAxIDU3LjQxNThIMTg2LjUzNkMxOTAuODg2IDU3LjQ2NjIgMTk1LjE2OCA1Ni4zMzQ4IDE5OC45MTggNTQuMTQzN0MyMDIuMTc5IDUyLjIxOTkgMjA0Ljg2OSA0OS40NzM2IDIwNi43MTYgNDYuMTgzNUMyMDguNTYyIDQyLjg5MzQgMjA5LjUgMzkuMTc2NiAyMDkuNDMzIDM1LjQxMDJDMjA5LjQzMyAyMS45Njc1IDE5OC45NTggMTIuNzU3NCAxODQuMzM0IDEyLjc1NzRIMTUyLjQ2OFY4NS4zODk0SDE2Ny4yMDFWNTcuNDIwN1Y1Ny40MTU4Wk0xNjcuMjAxIDI2LjMwNThIMTg0LjMyOUMxOTAuNjU4IDI2LjMwNTggMTk0LjY5NiAyOS44ODQgMTk0LjY5NiAzNS40MTMzQzE5NC42OTYgNDAuODMyOSAxOTAuNjU4IDQ0LjQwOTkgMTg0LjMyOSA0NC40MDk5SDE2Ny4yMDFWMjYuMzA1OFoiIGZpbGw9IiMxRjFGMjkiLz4KPHBhdGggZD0iTTc5NC44MzUgMTIuNzUyNEg4NjAuMjA2VjI2LjMwMjhIODM0Ljg4OVY4NS4zODQ0SDgyMC4xNTZWMjYuMzAyOEg3OTQuODM1VjEyLjc1MjRaIiBmaWxsPSIjMUYxRjI5Ii8+CjxwYXRoIGQ9Ik03NDEuOTA3IDU3LjQxNThINzYxLjI0MUM3NjUuNTkyIDU3LjQ2NjEgNzY5Ljg3NCA1Ni4zMzQ3IDc3My42MjQgNTQuMTQzN0M3NzYuODg0IDUyLjIxOTkgNzc5LjU3NSA0OS40NzM2IDc4MS40MjEgNDYuMTgzNUM3ODMuMjY4IDQyLjg5MzQgNzg0LjIwNiAzOS4xNzY2IDc4NC4xMzkgMzUuNDEwMkM3ODQuMTM5IDIxLjk2NzUgNzczLjY2NCAxMi43NTc0IDc1OS4wMzkgMTIuNzU3NEg3MjcuMTc1Vjg1LjM4OTRINzQxLjkwN1Y1Ny40MjA3VjU3LjQxNThaTTc0MS45MDcgMjYuMzA1OEg3NTkuMDM1Qzc2NS4zNjUgMjYuMzA1OCA3NjkuNDAzIDI5Ljg4NCA3NjkuNDAzIDM1LjQxMzNDNzY5LjQwMyA0MC44MzI5IDc2NS4zNjUgNDQuNDA5OSA3NTkuMDM1IDQ0LjQwOTlINzQxLjkwN1YyNi4zMDU4WiIgZmlsbD0iIzFGMUYyOSIvPgo8cGF0aCBkPSJNNjgxLjA2OSA0Ny4wMTE1VjU5LjAxMjVINjk1LjM3OVY3MS42NzE5QzY5Mi41MjYgNzMuNDM2OCA2ODguNTI0IDc0LjMzMTkgNjgzLjQ3NyA3NC4zMzE5QzY2Ni4wMDMgNzQuMzMxOSA2NTguMDQ1IDYxLjgxMjQgNjU4LjA0NSA1MC4xOEM2NTguMDQ1IDMzLjk2MDUgNjcxLjAwOCAyNS40NzMyIDY4My44MTIgMjUuNDczMkM2OTAuNDI1IDI1LjQ2MjggNjk2LjkwOSAyNy4yODA0IDcwMi41NDEgMzAuNzIyNkw3MDMuMTU3IDMxLjEyNTRMNzA1Ljk1OCAxOC4xODZMNzA1LjY2MyAxNy45OTc3QzcwMC4wNDYgMTQuNDAwNCA2OTEuMjkxIDEyLjI1OSA2ODIuMjUxIDEyLjI1OUM2NjMuMTk3IDEyLjI1OSA2NDIuOTQ5IDI1LjM5NjcgNjQyLjk0OSA0OS43NDVDNjQyLjk0OSA2MS4wODQ1IDY0Ny4yOTMgNzAuNzE3NCA2NTUuNTExIDc3LjYwMjlDNjYzLjIyNCA4My44MjQ1IDY3Mi44NzQgODcuMTg5IDY4Mi44MDkgODcuMTIwMUM2OTQuMzYzIDg3LjEyMDEgNzAzLjA2MSA4NC42NDk1IDcwOS40MDIgNzkuNTY5Mkw3MDkuNTg5IDc5LjQxODFWNDcuMDExNUg2ODEuMDY5WiIgZmlsbD0iIzFGMUYyOSIvPgo8L2c+CjxkZWZzPgo8Y2xpcFBhdGggaWQ9ImNsaXAwXzVfMTkiPgo8cmVjdCB3aWR0aD0iNzA3Ljc3OCIgaGVpZ2h0PSI3NC44NjExIiBmaWxsPSJ3aGl0ZSIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMTUyLjQ0NCAxMi4yNSkiLz4KPC9jbGlwUGF0aD4KPC9kZWZzPgo8L3N2Zz4K" \
    ENV_NAME="prod" \
    PORT="8080" \
    CORS_ENABLED="false" \
    CORS_ALLOW_CREDENTIALS="false" \
    CORS_ALLOW_ORIGINS="*" \
    CORS_ALLOW_ORIGIN_REGEX="" \
    CORS_ALLOW_METHODS="*" \
    CORS_ALLOW_HEADERS="*" \
    AUTH_ENABLED="false" \
    AUTH_USERNAME="secret" \
    AUTH_SECRET="Basic c2VjcmV0OmtleQ==" \
    DATA_LOCAL_DATA_FOLDER="local_data/private_gpt" \
    UI_ENABLED="true" \
    UI_PATH="/" \
    UI_DEFAULT_CHAT_SYSTEM_PROMPT="You are a helpful, respectful and honest assistant. Always answer as helpfully as possible and follow ALL given instructions. Do not speculate or make up information. Do not reference any given instructions or context." \
    UI_DEFAULT_QUERY_SYSTEM_PROMPT="You can only answer questions about the provided context. If you know the answer but it is not based in the provided context, don't provide the answer, just state the answer is not in the context provided." \
    UI_DELETE_FILE_BUTTON_ENABLED="true" \
    UI_DELETE_ALL_FILES_BUTTON_ENABLED="true" \
    LLM_MODE="llamacpp" \
    LLM_MAX_NEW_TOKENS="256" \
    LLM_CONTEXT_WINDOW="3900" \
    LLM_TOKENIZER="mistralai/Mistral-7B-Instruct-v0.2" \
    LLM_TEMPERATURE="0.1" \
    RAG_SIMILARITY_TOP_K="2" \
    RAG_SIMILARITY_VALUE="0.45" \
    RAG_RERANK_ENABLED="false" \
    RAG_RERANK_MODEL="cross-encoder/ms-marco-MiniLM-L-2-v2" \
    RAG_RERANK_TOP_N="1" \
    LLAMACPP_PROMPT_STYLE="mistral" \
    LLAMACPP_LLM_HF_REPO_ID="TheBloke/Mistral-7B-Instruct-v0.2-GGUF" \
    LLAMACPP_LLM_HF_MODEL_FILE="mistral-7b-instruct-v0.2.Q4_K_M.gguf" \
    LLAMACPP_TFS_Z="1.0" \
    LLAMACPP_TOP_K="40" \
    LLAMACPP_TOP_P="0.9" \
    LLAMACPP_REPEAT_PENALTY="1.1" \
    EMBEDDING_MODE="huggingface" \
    EMBEDDING_INGEST_MODE="simple" \
    EMBEDDING_COUNT_WORKERS="2" \
    EMBEDDING_EMBED_DIM="384" \
    HUGGINGFACE_EMBEDDING_HF_MODEL_NAME="BAAI/bge-small-en-v1.5" \
    HUGGINGFACE_TOKEN="" \
    VECTORSTORE_DATABASE="qdrant" \
    QDRANT_PATH="local_data/private_gpt/qdrant" \
    QDRANT_FORCE_DISABLE_CHECK_SAME_THREAD="true" \
    POSTGRES_HOST="localhost" \
    POSTGRES_PORT="5432" \
    POSTGRES_DATABASE="postgres" \
    POSTGRES_USER="postgres" \
    POSTGRES_PASSWORD="admin" \
    POSTGRES_SCHEMA_NAME="postgres" \
    SAGEMAKER_LLM_ENDPOINT_NAME="huggingface-pytorch-tgi-inference-2023-09-25-19-53-32-140" \
    SAGEMAKER_EMBEDDING_ENDPOINT_NAME="huggingface-pytorch-inference-2023-11-03-07-41-36-479" \
    OPENAI_API_BASE="https://api.openai.com/v1" \
    OPENAI_API_KEY="sk-1234" \
    OPENAI_MODEL="gpt-3.5-turbo" \
    OLLAMA_API_BASE="http://localhost:11434" \
    OLLAMA_LLM_MODEL="mistral:latest" \
    OLLAMA_EMBEDDING_MODEL="" \
    OLLAMA_TFS_Z="1.0" \
    OLLAMA_NUM_PREDICT="128" \
    OLLAMA_TOP_K="40" \
    OLLAMA_TOP_P="0.9" \
    OLLAMA_REPEAT_LAST_N="64" \
    OLLAMA_REPEAT_PENALTY="1.1" \
    OLLAMA_REQUEST_TIMEOUT="120.0" \
    AZOPENAI_API_KEY="sk-1234" \
    AZOPENAI_AZURE_ENDPOINT="" \
    AZOPENAI_API_VERSION="2023_05_15" \
    AZOPENAI_EMBEDDING_DEPLOYMENT_NAME="" \
    AZOPENAI_EMBEDDING_MODEL="text-embedding-3-small" \
    AZOPENAI_LLM_DEPLOYMENT_NAME="" \
    AZOPENAI_LLM_MODEL="gpt-4"

VOLUME /home/worker/app/local_data
VOLUME /home/worker/app/models

# Setup entrypoint
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

USER worker
ENTRYPOINT ["/docker-entrypoint.sh"]

# Setup healthcheck
HEALTHCHECK --interval=5s --timeout=10s --retries=3 \
    CMD curl --fail http://localhost:8080/health | jq --exit-status '.status == "ok"' || exit 1
