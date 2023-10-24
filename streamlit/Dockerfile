# Build-Stage
FROM python:3.10-slim as builder
LABEL maintainer="Julian Reith <julianreith@gmx.de>"
LABEL description="Docker container for Streamlit - an open-source app framework for Machine Learning and Data Science teams"

WORKDIR /build
RUN apt update && \
    apt install -y build-essential cmake curl software-properties-common && \
    rm -rf /var/lib/apt/lists/* && \
    python -m venv /venv && \
    /venv/bin/pip install --upgrade pip && \
    /venv/bin/pip install --no-cache-dir streamlit

# App-Stage
FROM python:3.10-slim

WORKDIR /app

VOLUME /app
EXPOSE 8501/tcp

COPY --from=builder /venv /venv
COPY app/ ./
COPY docker-entrypoint.sh /

RUN chmod +x /docker-entrypoint.sh && \
    apt update && \
    apt install -y curl tzdata

ENV TZ="UTC"

ENTRYPOINT ["/docker-entrypoint.sh"]

HEALTHCHECK --interval=5s --timeout=10s --retries=3 \
    CMD curl --fail http://localhost:8501/_stcore/health || exit 1
