ARG IMAGE=python:3.12-alpine
ARG CMAKE_ARGS="-DLLAMA_BLAS=ON -DLLAMA_BLAS_VENDOR=OpenBLAS -DLLAMA_AVX=OFF -DLLAMA_AVX2=OFF -DLLAMA_F16C=OFF -DLLAMA_FMA=OFF"

# App-Stage
FROM ${IMAGE}
ARG IMAGE

LABEL maintainer="Julian Reith <julianreith@gmx.de>"
LABEL description="Docker container for llama-cpp-python"

WORKDIR /

VOLUME /model
EXPOSE 8000/tcp

# Setup llama-cpp-python
RUN apk add --no-cache --virtual .build-deps build-base cmake ninja-build && \
    apk add --no-cache curl gfortran openblas-dev runit tzdata && \
    rm -rf /var/lib/apt/lists/* && \
    python -m venv /venv && \
    /venv/bin/pip install --upgrade pip \
        anyio \
        pytest \
        scikit-build \
        setuptools \
        fastapi \
        uvicorn \
        sse-starlette \
        pydantic-settings \
        starlette-context \
        huggingface-hub \
        huggingface_hub[cli] && \
    LLAMA_OPENBLAS=ON \
    CMAKE_ARGS=$CMAKE_ARGS \
    /venv/bin/pip install --no-cache-dir llama-cpp-python && \
    apk del --no-network .build-deps && \
    mkdir -p \
        /runit-services/llama-cpp-python \
        /runit-services/syslogd && \
    echo -e "#!/bin/sh\nbusybox syslogd -n -O /dev/stdout" > \
        /runit-services/syslogd/run && \
    echo -e "#!/bin/sh\n/venv/bin/python3 -B -m llama_cpp.server --model /model/model.gguf" > \
        /runit-services/llama-cpp-python/run && \
    chmod +x /runit-services/syslogd/run \
        /runit-services/llama-cpp-python/run

# Store versions in /VERSION
RUN touch /VERSION && \
    echo "alpine=$(cat /etc/alpine-release)" > /VERSION && \
    echo "python=$(/venv/bin/python3 --version | cut -d' ' -f2)" >> /VERSION && \
    echo "pip=$(/venv/bin/pip3 --version| cut -d' ' -f2)" >> /VERSION && \
    echo "llama-cpp-python=$(/venv/bin/pip freeze | grep llama_cpp_python | cut -d= -f3)" >> /VERSION

# Setup environment
ENV TZ="UTC" \
    MODEL_DOWNLOAD="True" \
    MODEL_REPO="TheBloke/Llama-2-7B-Chat-GGUF" \
    MODEL="llama-2-7b-chat.Q4_K_M.gguf" \
    MODEL_PATH="/model" \
    MODEL_ALIAS="llama-2-7b-chat" \
    SEED=4294967295 \
    N_CTX=1024 \
    N_BATCH=512 \
    N_GPU_LAYERS=0 \
    MAIN_GPU=0 \
    ROPE_FREQ_BASE=0.0 \
    ROPE_FREQ_SCALE=0.0 \
    MUL_MAT_Q=True \
    LOGITS_ALL=True \
    VOCAB_ONLY=False \
    USE_MMAP=True \
    USE_MLOCK=True \
    EMBEDDING=True \
    N_THREADS=4 \
    LAST_N_TOKENS_SIZE=64 \
    LORA_BASE="" \
    LORA_PATH="" \
    NUMA=False \
    CHAT_FORMAT="llama-2" \
    CACHE=False \
    CACHE_TYPE="ram" \
    CACHE_SIZE=2147483648 \
    VERBOSE=True \
    HOST="0.0.0.0" \
    PORT=8000 \
    INTERRUPT_REQUESTS=True \
    QUIET="False"

# Setup entrypoint
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

HEALTHCHECK --interval=5s --timeout=10s --retries=3 \
    CMD sv status /runit-services/llama-cpp-python || exit 1