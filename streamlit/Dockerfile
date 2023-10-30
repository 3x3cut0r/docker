ARG IMAGE=python:3.11-slim

# Build-Stage
FROM ${IMAGE} as builder
ARG IMAGE

# Setup and build streamlit
WORKDIR /build
RUN apt update && \
    apt install -y build-essential cmake curl software-properties-common && \
    rm -rf /var/lib/apt/lists/* && \
    python -m venv /venv && \
    /venv/bin/pip install --upgrade pip && \
    /venv/bin/pip install --no-cache-dir streamlit streamlit-extras

# App-Stage
FROM ${IMAGE}
ARG IMAGE

LABEL maintainer="Julian Reith <julianreith@gmx.de>"
LABEL description="Docker container for Streamlit - an open-source app framework for Machine Learning and Data Science teams"

WORKDIR /app

VOLUME /app
EXPOSE 8501/tcp

# Copy streamlit from builder
COPY --from=builder /venv /venv
COPY app/ ./

RUN apt update && \
    apt install -y curl tzdata

# Store versions in /VERSION
RUN touch /VERSION && \
    echo "debian=$(cat /etc/issue | cut -d' ' -f3)" > /VERSION && \
    echo "python=$(/venv/bin/python3 --version | cut -d' ' -f2)" >> /VERSION && \
    echo "pip=$(/venv/bin/pip3 --version| cut -d' ' -f2)" >> /VERSION && \
    echo "streamlit=$(/venv/bin/streamlit --version | cut -d' ' -f3)" >> /VERSION

# Setup environment
ENV TZ="UTC"

# Setup entrypoint
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

HEALTHCHECK --interval=5s --timeout=10s --retries=3 \
    CMD curl --fail http://localhost:8501/_stcore/health || exit 1
