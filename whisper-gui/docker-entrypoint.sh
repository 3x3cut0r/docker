#!/bin/bash

# set timezone
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# set language
sed -i 's/"language": "[^"]*"/"language": "'"${LANGUAGE:-"en"}"'"/' configs/config.json

# print privategpt version
echo "$(cat /VERSION)"

# run app
source /opt/conda/etc/profile.d/conda.sh && \
conda activate whisper-gui && \
python main.py --autolaunch
