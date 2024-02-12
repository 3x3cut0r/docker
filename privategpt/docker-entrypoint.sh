#!/bin/sh
set -e

############################
# setup user environment   #
############################

# KEEP_FILES
if [ "${KEEP_FILES:-False}" != "True" ]; then
    rm -rf /home/worker/app/local_data/*
fi

# PROMPT_STYLE
if [ "${PROMPT_STYLE}" != "" ]; then
    sed -i "s|prompt_style: \"mistral\"|prompt_style: \"${PROMPT_STYLE}\"|g" /home/worker/app/settings.yaml
fi

# PGPT_HF_MODEL_FILE
if [ "${PGPT_HF_MODEL_FILE}" != "" ]; then
    sed -i "s|llm_hf_model_file: mistral-7b-instruct-v0.2.Q4_K_M.gguf|llm_hf_model_file: ${PGPT_HF_MODEL_FILE}|g" /home/worker/app/settings.yaml
fi

# EMBEDDING_HF_MODEL_NAME
if [ "${EMBEDDING_HF_MODEL_NAME}" != "" ]; then
    sed -i "s|embedding_hf_model_name: BAAI/bge-small-en-v1.5|embedding_hf_model_name: ${EMBEDDING_HF_MODEL_NAME}|g" /home/worker/app/settings.yaml
fi

# TOKENIZER
if [ "${TOKENIZER}" != "" ]; then
    sed -i "s|tokenizer: mistralai/Mistral-7B-Instruct-v0.2|tokenizer: ${TOKENIZER}|g" /home/worker/app/settings.yaml
fi

# MAX_NEW_TOKENS
if [ "${MAX_NEW_TOKENS}" != "" ]; then
    sed -i "s|max_new_tokens: 512|max_new_tokens: ${MAX_NEW_TOKENS}|g" /home/worker/app/settings.yaml
fi

# CONTEXT_WINDOW
if [ "${CONTEXT_WINDOW}" != "" ]; then
    sed -i "s|context_window: 3900|context_window: ${CONTEXT_WINDOW}|g" /home/worker/app/settings.yaml
fi

# LOGO_BG_COLOR
sed -i "s|background-color: #C7BAFF;|background-color: ${LOGO_BG_COLOR:-#C7BAFF};|" /home/worker/app/private_gpt/ui/ui.py

# LOGO_SVG_BASE64
sed -i "s|logo_svg = \"data:image/svg+xml;base64,.*\"|logo_svg = \"data:image/svg+xml;base64,${LOGO_SVG_BASE64}\"|g" /home/worker/app/private_gpt/ui/images.py

# LOGO_HEIGHT
sed -i "s|\.logo img { height: 25% }|\.logo img { height: ${LOGO_HEIGHT:-25%} }|g" /home/worker/app/private_gpt/ui/ui.py

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