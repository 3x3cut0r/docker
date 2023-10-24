#!/bin/sh
set -e

# Set PATH for the virtual environment
export PATH="/venv/bin:$PATH"

# Set ownership
chown -R root:root /app

# Set permissions
chmod -R 644 /app

#####################
# setup environment #
#####################

# install python requirements
if [ -s /app/requirements.txt ]; then
    /venv/bin/pip install --no-cache-dir -r /app/requirements.txt
fi

# TIMEZONE
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# print streamlit version
streamlit --version

# run streamlit
streamlit run /app/streamlit_app.py --server.port=${PORT:-8501} --server.address=0.0.0.0