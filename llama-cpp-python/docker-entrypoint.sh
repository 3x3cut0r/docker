#!/bin/sh
set -e

############################
# setup global environment #
############################

# Set PATH for the virtual environment
export PATH="/venv/bin:$PATH"

# For mlock support (--cap-add SYS_RESOURCE must be added to docker in order to do this)
ulimit -l unlimited 2>/dev/null || true

############################
# setup user environment   #
############################

# TIMEZONE
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

############################
# run app                  #
############################

# download model
if [ "$MODEL_REPO" != "local" ] && { [ "$MODEL_DOWNLOAD" = "True" ] || [ "$MODEL_DOWNLOAD" = "true" ] || [ "$MODEL_DOWNLOAD" = "TRUE" ]; }; then
    if [ ! -e "${MODEL_PATH}"/"${MODEL}" ]; then
        if [ "$QUIET" != "true" ]; then
            echo -e "\nINFO: downloading model from repository ${MODEL_REPO:-'TheBloke/Llama-2-7B-Chat-GGUF'}\n"
        fi
        mkdir -p "${MODEL_PATH}"
        /venv/bin/huggingface-cli download --repo-type model --local-dir="${MODEL_PATH}" --local-dir-use-symlinks=False --resume-download --token="${HF_TOKEN:-''}" "${MODEL_REPO}" "${MODEL}"
    fi    
fi

# if started without args, run app.py
if [ "$#" = "0" ]; then

    # set parameters
    param=""
    param="${param} --model '${MODEL_PATH:-"/model"}/${MODEL:-"llama-2-7b-chat.Q4_K_M.gguf"}'"
    param="${param} --model_alias ${MODEL_ALIAS:-'llama-2-7b-chat'}"
    param="${param} --seed ${SEED:-4294967295}"
    param="${param} --n_ctx ${N_CTX:-2048}"
    param="${param} --n_batch ${N_BATCH:-512}"
    param="${param} --n_gpu_layers ${N_GPU_LAYERS:-0}"
    param="${param} --main_gpu ${MAIN_GPU:-0}"
    param="${param} --rope_freq_base ${ROPE_FREQ_BASE:-0.0}"
    param="${param} --rope_freq_scale ${ROPE_FREQ_SCALE:-0.0}"
    param="${param} --mul_mat_q ${MUL_MAT_Q:-True}"
    param="${param} --logits_all ${LOGITS_ALL:-True}"
    param="${param} --vocab_only ${VOCAB_ONLY:-False}"
    param="${param} --use_mmap ${USE_MMAP:-True}"
    param="${param} --use_mlock ${USE_MLOCK:-True}"
    param="${param} --n_threads ${N_THREADS:-6}"
    param="${param} --last_n_tokens_size ${LAST_N_TOKENS_SIZE:-64}"
    param="${param} --lora_base ${LORA_BASE:-''}"
    param="${param} --lora_path ${LORA_PATH:-''}"
    param="${param} --numa ${NUMA:-False}"
    param="${param} --chat_format ${CHAT_FORMAT:-'llama-2'}"
    param="${param} --cache ${CACHE:-False}"
    param="${param} --cache_type ${CACHE_TYPE:-'ram'}"
    param="${param} --cache_size ${CACHE_SIZE:-2147483648}"
    param="${param} --verbose ${VERBOSE:-True}"
    param="${param} --host ${HOST:-'0.0.0.0'}"
    param="${param} --port ${PORT:-8000}"
    param="${param} --interrupt_requests ${INTERRUPT_REQUESTS:-True}"

    if [ "$QUIET" != "true" ]; then
        # print llama-cpp-python version
        pip freeze | grep llama_cpp_python

        echo -e "\nINFO: /venv/bin/python3 -B -m llama_cpp.server ${param}\n"
    fi
    echo -e "#!/bin/sh\n/venv/bin/python3 -B -m llama_cpp.server ${param}" > /runit-services/llama-cpp-python/run

# if started with args, run args instead
else
    # if first arg is --help, assume we want to run python3 -B -m llama_cpp.server --help
    if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        /venv/bin/python3 -B -m llama_cpp.server --help
        exit 0

    # if first arg looks like a flag, assume we want to run python3 -B -m llama_cpp.server
    elif [ "$( echo "$1" | cut -c1 )" = "-" ]; then
        if [ "$QUIET" != "true" ]; then
            echo -e "\nINFO: /venv/bin/python3 -B -m llama_cpp.server --host ${HOST:-'0.0.0.0'} $@\n\n"
        fi
        echo -e "#!/bin/sh\n/venv/bin/python3 -B -m llama_cpp.server $@" > /runit-services/llama-cpp-python/run

    # if the first arg is "python" or "python3" ...
    elif [ "$1" = "python" ] || [ "$1" = "python3" ]; then
        shift # remove first argument (python or python3)
        if [ "$QUIET" != "true" ]; then
            echo -e "\nINFO: /venv/bin/python3 $@\n\n"
        fi
        echo -e "#!/bin/sh\n/venv/bin/python3 ${@}" > /runit-services/llama-cpp-python/run

    # if first arg doesn't looks like a flag or python, we just run the command
    else
        exec "$@"
        exit 0
    fi
fi

exec runsvdir /runit-services
