#!/bin/bash

# run app
source /opt/conda/etc/profile.d/conda.sh && \
conda activate whisper-gui && \
python -u main.py --autolaunch