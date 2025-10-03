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
    conda update -n base -c conda-forge -c pytorch conda && \
    conda config --set solver classic && \
    conda remove -n base conda-libmamba-solver -y && \
    echo "conda activate whisper-gui" >> ~/.bashrc && \
    source /opt/conda/etc/profile.d/conda.sh -y && \
    conda activate whisper-gui && \
    conda install -c conda-forge -c pytorch \
        "numpy<2" \
        pytorch==2.1.2 \
        torchaudio==2.1.2 \
        cpuonly && \
    printf "numpy<2\n" > /tmp/pip_constraints.txt && \
    PIP_CONSTRAINT=/tmp/pip_constraints.txt pip install \
        ctranslate2==4.0.0 \
        faster-whisper==1.0.0 \
        gradio==4.44.1 \
        gradio-client==1.3.0 \
        git+https://github.com/m-bain/whisperx.git@v3.1.1 && \
    rm /tmp/pip_constraints.txt && \
    python - <<'PY'
from pathlib import Path
from textwrap import dedent
from gradio_client import utils


def patch_gradio() -> None:
    path = Path(utils.__file__)
    text = path.read_text()

    guard = (
        'def _json_schema_to_python_type(schema: Any, defs) -> str:\n'
        '    """Convert the json schema into a python type hint"""\n'
        '    if schema == {}:\n'
        '        return "Any"'
    )
    replacement = (
        'def _json_schema_to_python_type(schema: Any, defs) -> str:\n'
        '    """Convert the json schema into a python type hint"""\n'
        '    if isinstance(schema, bool):\n'
        '        return "Any" if schema else "None"\n'
        '    if schema == {}:\n'
        '        return "Any"'
    )
    if 'if isinstance(schema, bool):' not in text:
        text = text.replace(guard, replacement)

    additional_guard = (
        '        if "additionalProperties" in schema:\n'
        '            des += [\n'
        '                f"str, {_json_schema_to_python_type(schema[\'additionalProperties\'], defs)}"\n'
        '            ]'
    )
    additional_replacement = (
        '        if "additionalProperties" in schema:\n'
        '            additional_props = schema["additionalProperties"]\n'
        '            if isinstance(additional_props, bool):\n'
        '                additional_type = "Any" if additional_props else "None"\n'
        '            else:\n'
        '                additional_type = _json_schema_to_python_type(additional_props, defs)\n'
        '            des += [\n'
        '                f"str, {additional_type}"\n'
        '            ]'
    )
    if 'additional_props = schema["additionalProperties"]' not in text:
        text = text.replace(additional_guard, additional_replacement)

    path.write_text(text)


def patch_pyannote() -> None:
    path = Path(
        "/opt/conda/envs/whisper-gui/lib/python3.10/site-packages/pyannote/audio/pipelines/"
        "speaker_verification.py"
    )
    if not path.exists():
        return

    text = path.read_text()
    needle = (
        "from speechbrain.pretrained import (\n"
        "    SpeakerRecognition,\n"
        "    EncoderClassifier,\n"
        ")"
    )
    if needle not in text or "speechbrain.inference" in text:
        return

    replacement = dedent(
        """\
        try:
            from speechbrain.inference import (
                SpeakerRecognition,
                EncoderClassifier,
            )
        except ImportError:
            from speechbrain.pretrained import (
                SpeakerRecognition,
                EncoderClassifier,
            )
        """
    ).rstrip() + "\n"
    text = text.replace(needle, replacement)
    path.write_text(text)


if __name__ == "__main__":
    patch_gradio()
    patch_pyannote()
PY
    && python - <<'PY'
from pathlib import Path
from textwrap import dedent

path = Path("/opt/conda/envs/whisper-gui/lib/python3.10/site-packages/pyannote/audio/pipelines/speaker_verification.py")
if path.exists():
    text = path.read_text()
    needle = "from speechbrain.pretrained import (\n    SpeakerRecognition,\n    EncoderClassifier,\n)"
    if needle in text and "speechbrain.inference" not in text:
        replacement = dedent(
            """\
            try:
                from speechbrain.inference import (
                    SpeakerRecognition,
                    EncoderClassifier,
                )
            except ImportError:
                from speechbrain.pretrained import (
                    SpeakerRecognition,
                    EncoderClassifier,
                )
            """
        ).rstrip() + "\n"
        text = text.replace(needle, replacement)
        path.write_text(text)
PY

RUN git clone https://github.com/Pikurrot/whisper-gui

# prepare whisper-gui
WORKDIR /whisper-gui
COPY configs/config.json configs/config.json
RUN source /opt/conda/etc/profile.d/conda.sh && \
    conda activate whisper-gui && \
    mkdir -p outputs && \
    sed -i 's/demo\.launch(inbrowser=args\.autolaunch, share=args\.share)/demo.launch(server_name="0.0.0.0", server_port=7860)/' main.py && \
    sed -i 's/\(^[^d]*\)blockPrint()/# \1blockPrint()/' main.py && \
    chmod +x *.py scripts/*.py && \
    chmod +x *.sh scripts/*.sh

# store versions in /VERSION
RUN source /opt/conda/etc/profile.d/conda.sh && \
    conda activate whisper-gui && \
    touch /VERSION && \
    whisper_gui_version=$(git describe --tags $(git rev-list --tags --max-count=1)) && \
    echo "whisper-gui=$whisper_gui_version" > /VERSION && \
    whisperx_version=$(pip show whisperx | grep Version | cut -d' ' -f2) && \
    echo "whisperx=v$whisperx_version" >> /VERSION 

# setup entrypoint
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
