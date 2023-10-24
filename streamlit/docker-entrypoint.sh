#!/bin/sh
set -e

############################
# setup global environment #
############################

# Set PATH for the virtual environment
export PATH="/venv/bin:$PATH"

# Set ownership
chown -R root:root /app

# Set permissions
chmod -R 644 /app

# export streamlit version
export VERSION=$(streamlit --version | cut -d' ' -f3)

############################
# setup user environment   #
############################

# install python requirements
if [ -s /app/requirements.txt ]; then
    /venv/bin/pip install --no-cache-dir -r /app/requirements.txt > /dev/null 2>&1
fi

# TIMEZONE
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

############################
# run app                  #
############################

# if started without args, run streamlit_app.py
if [ "$#" = "0" ]; then
    # print streamlit version
    streamlit --version

    # run streamlit
    streamlit run /app/streamlit_app.py --server.port=${PORT:-8501} --server.address=0.0.0.0

# if started with args, run args instead
else
    exec "$@"
fi

