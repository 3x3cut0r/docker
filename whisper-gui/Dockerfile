# Base-Stage
FROM python:3.10-slim AS base
LABEL maintainer="Julian Reith <julianreith@gmx.de>"
LABEL description="Docker container for privateGPT - a production-ready AI project that allows you to ask questions about your documents using the power of Large Language Models (LLMs)."

EXPOSE 7860
WORKDIR /

# install apt prerequisites
RUN apt update && apt install -y \
        curl \
        ffmpeg \
        git \
        wget && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*
    
# install python prerequisites
RUN python -m pip install --upgrade pip \
    gradio \
    pytorch==2.0.0 \
    setuptools-rust \
    torchaudio==2.0.0

# install whisper
RUN python -m pip install git+https://github.com/openai/whisper.git

# install whisperx
RUN python -m pip install git+https://github.com/m-bain/whisperx.git

# install whisper-gui
RUN git clone https://github.com/Pikurrot/whisper-gui
WORKDIR /whisper-gui

# Setup entrypoint
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]