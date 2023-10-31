#!/bin/sh

############################
# setup global environment #
############################

# Set PATH for the virtual environment
export PATH="/venv/bin:$PATH"

# Set permissions
chmod -R 755 /app

############################
# setup user environment   #
############################

# install python requirements (only once)
install_complete="/app/requirements.complete"
if [ -s /app/requirements.txt ]; then
    if [ ! -f $install_complete ]; then
        /venv/bin/pip install --no-cache-dir -r /app/requirements.txt 2>/dev/null
        touch $install_complete
    fi
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
    exit 0
fi

