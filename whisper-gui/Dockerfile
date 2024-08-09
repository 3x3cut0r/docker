# Base-Stage
FROM condaforge/miniforge3 AS base
LABEL maintainer="Julian Reith <julianreith@gmx.de>"
LABEL description="Docker container for whisper-gui - A simple GUI made with gradio to use Whisper from https://github.com/Pikurrot/whisper-gui"

EXPOSE 7860
ENV TZ="Europe/Berlin"

# install apt prerequisites
WORKDIR /
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apt update && apt install -y \
        curl \
        ffmpeg \
        git \
        vim \
        wget && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*
    
# create conda env and clone whisper-gui
SHELL ["bash", "-c"]
RUN conda create --name whisper-gui python=3.10 -y && \
    conda clean -a -y && \
    echo "conda activate whisper-gui" >> ~/.bashrc && \
    source /opt/conda/etc/profile.d/conda.sh && \
    conda activate whisper-gui && \
    pip install gradio torch==2.0.0 torchaudio==2.0.1 && \
    pip install git+https://github.com/m-bain/whisperx.git && \
    git clone https://github.com/Pikurrot/whisper-gui

# prepare whisper-gui
WORKDIR /whisper-gui
COPY configs/config.json configs/config.json
RUN mkdir -p outputs && \
    sed -i 's/demo\.launch(inbrowser=args\.autolaunch, share=args\.share)/demo.launch(server_name="0.0.0.0", server_port=7860)/' main.py && \
    chmod +x *.py scripts/*.py && \
    chmod +x *.sh scripts/*.sh

# setup entrypoint
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
