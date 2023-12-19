#!/bin/sh
set -e

############################
# setup user environment   #
############################

# HEADER_BG_COLOR
sed -i "s|background-color: #C7BAFF;|background-color: ${LOGO_BG_COLOR:-#C7BAFF};|" /home/worker/app/private_gpt/ui/ui.py

# LOGO_SVG_BASE64
sed -i "s|logo_svg = \"data:image/svg+xml;base64,.*\"|logo_svg = \"data:image/svg+xml;base64,${LOGO_SVG_BASE64}\"|g" /home/worker/app/private_gpt/ui/images.py

# LOGO_HEIGHT
sed -i "s|\.logo img { height: 25% }|\.logo img { height: ${LOGO_HEIGHT:-50%} }|g" /home/worker/app/private_gpt/ui/ui.py

# KEEP_FILES
if [ "${KEEP_FILES:-False}" != "True" ]; then
    rm -rf /home/worker/app/local_data/*
fi

############################
# run app                  #
############################

# if started without args, run streamlit_app.py
if [ "$#" = "0" ]; then
    # print privategpt version
    echo "privategpt version: $(cat /home/worker/app/version.txt)"

    # run privategpt
    /home/worker/app/.venv/bin/python -m private_gpt

# if started with args, run args instead
else
    exec "$@"
    exit 0
fi