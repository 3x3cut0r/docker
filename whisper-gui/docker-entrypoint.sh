#!/bin/bash

# set timezone
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# set language
sed -i 's/"language": "[^"]*"/"language": "'"${LANGUAGE:-"en"}"'"/' /whisper-gui/configs/config.json

# run app
source /opt/conda/etc/profile.d/conda.sh && \
conda activate whisper-gui && \
python -u main.py --autolaunch