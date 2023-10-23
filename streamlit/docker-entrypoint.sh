#!/bin/sh
set -e

# Set PATH for the virtual environment
export PATH="/venv/bin:$PATH"

#####################
# setup environment #
#####################

# TIMEZONE
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# print streamlit version
streamlit --version

# run streamlit
streamlit run /app/streamlit_app.py --server.port=${PORT:-8501} --server.address=0.0.0.0