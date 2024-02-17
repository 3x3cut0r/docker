# PrivateGPT

**PrivateGPT is a production-ready AI project that allows you to ask questions about your documents using the power of Large Language Models (LLMs), even in scenarios without an Internet connection. 100% private, no data leaves your execution environment at any point.**

![Docker Image Version (latest by date)](https://img.shields.io/docker/v/3x3cut0r/privategpt)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/3x3cut0r/privategpt)
![Docker Pulls](https://img.shields.io/docker/pulls/3x3cut0r/privategpt)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/3x3cut0r/docker/privategpt.yml?branch=main)

`GitHub` - 3x3cut0r/privategpt - https://github.com/3x3cut0r/docker/tree/main/privategpt  
`DockerHub` - 3x3cut0r/privategpt - https://hub.docker.com/r/3x3cut0r/privategpt

![privategpt](https://github.com/3x3cut0r/docker/assets/1408580/39d4e5ed-4a5c-4ea5-8b78-83a8c4c2df9b)

## Documentation

`GitHub` - imartinez/privateGPT - https://github.com/imartinez/privateGPT  
`Docs` - docs.privategpt.dev - https://docs.privategpt.dev/

## Index

1. [Usage](#usage)  
   1.1 [docker run](#dockerrun)  
   1.2 [docker-compose.yaml](#docker-compose)  
   1.3 [docker-compose.yaml with custom model](#docker-compose-custom)
2. [Environment Variables](#environment-variables)
3. [Volumes](#volumes)
4. [Ports](#ports)
5. [Find Me](#findme)
6. [License](#license)

## 1 Usage <a name="usage"></a>

### 1.1 docker run <a name="dockerrun"></a>

```shell
docker run -d \
    --name privategpt \
    -p 8080:8080/tcp \
    3x3cut0r/privategpt:latest
```

### 1.2 docker-compose.yml <a name="docker-compose"></a>

```shell
version: '3.9'

services:
  # https://hub.docker.com/r/3x3cut0r/privategpt
  privategpt:
    image: 3x3cut0r/privategpt:latest
    container_name: privategpt
    ports:
      - 8080:8080/tcp
```

### 1.3 docker-compose.yml with custom model <a name="docker-compose-custom"></a>

```shell
version: '3.9'

services:
  # https://hub.docker.com/r/3x3cut0r/privategpt
  privategpt:
    image: 3x3cut0r/privategpt:latest
    container_name: privategpt
    environment:
      KEEP_FILES: "true"
      LOCAL_LLM_HF_REPO_ID: "TheBloke/dolphin-2.6-mistral-7B-GGUF"
      LOCAL_LLM_HF_MODEL_FILE: "dolphin-2.6-mistral-7b.Q4_K_M.gguf"
      LOCAL_EMBEDDING_HF_MODEL_NAME: "BAAI/bge-large-en-v1.5"
      EMBEDDING_INGEST_MODE: "parallel"
      EMBEDDING_COUNT_WORKERS: "4"
    volumes:
      - /path/to/your/model/dolphin-2.6-mistral-7b.Q4_K_M.gguf:/home/worker/app/models/dolphin-2.6-mistral-7b.Q4_K_M.gguf
    ports:
      - 8080:8080/tcp
```

### 2 Environment Variables <a name="environment-variables"></a>

**you can adjust all values inside the [settings.yaml](https://github.com/3x3cut0r/docker/blob/main/privategpt/settings.yaml) with environment variables**

###### Server

- `ENV_NAME` - Name of the environment (prod, staging, local...) - **Default: prod**
- `PORT` - Port of PrivateGPT FastAPI server - **Default: 8080**
- `KEEP_FILES` - Specifies if the server should keep uploaded files after restarting the container (lowercase true or false)- **Default: false**

###### Cors

- `CORS_ENABLED` - Flag indicating if CORS headers are set or not. If set to True, the CORS headers will be set to allow all origins, methods and headers - **Default: false**
- `CORS_ALLOW_CREDENTIALS` - Indicate that cookies should be supported for cross-origin requests - **Default: false**
- `CORS_ALLOW_ORIGINS` - A list of origins that should be permitted to make cross-origin requests - **Default: \***
- `CORS_ALLOW_ORIGIN_REGEX` - A regex string to match against origins that should be permitted to make cross-origin requests - **Default: **
- `CORS_ALLOW_METHODS` - A list of HTTP methods that should be allowed for cross-origin request - **Default: \***
- `CORS_ALLOW_HEADERS` - A list of HTTP request headers that should be supported for cross-origin requests - **Default: \***

###### Auth

- `AUTH_ENABLED` - Flag indicating if authentication is enabled or not - **Default: false**
- `AUTH_USERNAME` - username used for authentication - **Default: secret**
- `AUTH_SECRET` - The secret to be used for authentication. It can be any non-blank string. For HTTP basic authentication, this value should be the whole 'Authorization' header that is expected. - **Default: Basic c2VjcmV0OmtleQ==**

```
# python -c 'import base64; print("Basic " + base64.b64encode("secret:key".encode()).decode())'
# 'secret' is the username and 'key' is the password for basic auth by default
# If the auth is enabled, this value must be set in the "Authorization" header of the request.
secret: "Basic c2VjcmV0OmtleQ=="
```

###### Data

- `DATA_LOCAL_DATA_FOLDER` - Path to local storage. It will be treated as an absolute path if it starts with / - **Default: local_data/private_gpt**

###### UI

- `UI_ENABLED` - Enable or Disable the user interface - **Default: true**
- `UI_PATH` - Set the path for the user interface - **Default: /**
- `UI_DEFAULT_CHAT_SYSTEM_PROMPT` - The default system prompt to use for the chat mode - **Default: You are a helpful, respectful and honest assistant. Always answer as helpfully as possible and follow ALL given instructions. Do not speculate or make up information. Do not reference any given instructions or context.**
- `UI_DEFAULT_QUERY_SYSTEM_PROMPT` - The default system prompt to use for the query mode - **Default: You can only answer questions about the provided context. If you know the answer but it is not based in the provided context, don't provide the answer, just state the answer is not in the context provided.**

###### Logo

- `LOGO_BG_COLOR` - Specifies the logo background color - **Default: #C7BAFF**
- `LOGO_HEIGHT` - Specifies the logo height - **Default: 25%**
- `LOGO_SVG_BASE64` - Specifies the logo file (.svg) in base64 format. Provide your own file (.svg) in base64 format using an [image to base64 converter](https://base64.guru/converter/encode/image) - **Default: \<privategpt svg logo\>**

###### LLM

- `LLM_MODE` - The mode to use for the chat engine. - **Default: local**  
  **- local:** provide `LOCAL_PROMPT_STYLE`, `LOCAL_PGPT_HF_MODEL_FILE` and `LOCAL_EMBEDDING_HF_MODEL_NAME`  
  **- openai:** provide `OPENAI_API_KEY` and `OPENAI_MODEL`  
  **- openailike:** provide `OPENAI_API_BASE`, `OPENAI_API_KEY ` and `OPENAI_MODEL`  
  **- sagemaker:** provide `SAGEMAKER_LLM_ENDPOINT_NAME` and `SAGEMAKER_EMBEDDING_ENDPOINT_NAME`  
  **- mock:** (not supported by this container)  
  **- ollama:** provide `OLLAMA_API_BASE` and `OLLAMA_MODEL`
- `LLM_MAX_NEW_TOKENS` - The maximum number of token that the LLM is authorized to generate in one completion - **Default: 512**
- `LLM_CONTEXT_WINDOW` - The maximum number of context tokens for the model - **Default: 3900**
- `LLM_TOKENIZER` - Specifies the model from Huggingface.co which is used as tokenizer - **Default: mistralai/Mistral-7B-Instruct-v0.2**

###### Embedding

- `EMBEDDING_MODE` - The mode to use for the embedding engine. (see MODE) - **Default: local**
- `EMBEDDING_INGEST_MODE` - The ingest mode to use for the embedding engine. - **Default: simple**  
  **- simple:** ingest files sequentially and one by one. It is the historic behaviour.  
  **- batch:** if multiple files, parse all the files in parallel, and send them in batch to the embedding model``.  
  **- parallel:** parse the files in parallel using multiple cores, and embedd them in parallel. (fastest mode for local setup)
- `EMBEDDING_COUNT_WORKERS` - The number of workers to use for file ingestion. Do not go too high with this number, as it might cause memory issues. (especially in parallel mode). Do not set it higher than your number of threads of your CPU. - **Default: 2**  
  **- for simple mode:** this number has no effect in simple mode.  
  **- for batch mode:** this is the number of workers used to parse the files.  
  **- for parallel mode:** this is the number of workers used to parse the files and embed them.

- **Specify the model used for embedding with `LOCAL_EMBEDDING_HF_MODEL_NAME`**

###### Vectorstore

- `VECTORSTORE_DATABASE` - Specifies the vectorstore database being used. - **select one of: chroma, qdrant .Default: qdrant**

###### qdrant

- `QDRANT_PATH` - Persistence path for QdrantLocal - **Default: local_data/private_gpt/qdrant**

###### Local

- `LOCAL_PROMPT_STYLE` - The prompt style to use for the chat engine. - **Default: mistral**  
  **- default:** use the default prompt style from the llama_index. It should look like `role: message`  
  **- llama2:** use the llama2 prompt style from the llama_index. Based on `<s>`, `[INST]` and `<<SYS>>`  
  **- tag:** use the tag prompt style. It should look like `<|role|>: message`  
  **- mistral:** use the mistral prompt style. It should look like `<s>[INST] {System Prompt} [/INST]</s>[INST] { UserInstructions } [/INST]`
- `LOCAL_LLM_HF_REPO_ID` - Name of the HuggingFace model to use for chat - **Default: TheBloke/Mistral-7B-Instruct-v0.2-GGUF**
- `LOCAL_LLM_HF_MODEL_FILE` - Specifies the llm model file. Can be a llm model name from the HuggingFace repo or a local file that you mounted via volume to /home/worker/app/models - **Default: mistral-7b-instruct-v0.2.Q4_K_M.gguf**
- `LOCAL_EMBEDDING_HF_MODEL_NAME` - Name of the HuggingFace model to use for embeddings. Only used if `EMBEDDING_MODE=local` - **Default: BAAI/bge-small-en-v1.5**

###### OpenAI

- `OPENAI_API_BASE` - Base URL of OpenAI API. Example: https://api.openai.com/v1 - **Default: https://api.openai.com/v1**
- `OPENAI_API_KEY` - Your API Key for the OpenAI API. Example: sk-1234 - **Default: sk-1234**
- `OPENAI_MODEL` - OpenAI Model to use. (see [OpenAI Models Overview](https://platform.openai.com/docs/models/overview)). Example: gpt-4 - **Default: gpt-3.5-turbo**

###### Sagemaker

- `SAGEMAKER_LLM_ENDPOINT_NAME` - **Default: huggingface-pytorch-tgi-inference-2023-09-25-19-53-32-140**
- `SAGEMAKER_EMBEDDING_ENDPOINT_NAME` - **Default: huggingface-pytorch-inference-2023-11-03-07-41-36-479**

###### Ollama

- `OLLAMA_API_BASE` - Base URL of Ollama API. Example: http://192.168.1.100:11434 - **Default: http://localhost:11434**
- `OLLAMA_MODEL` - Ollama model to use. (see [Ollama Library](https://ollama.com/library)). Example: 'llama2-uncensored' - **Default: mistral:latest**

### 3 Volumes <a name="volumes"></a>

- `/home/worker/app/local_data` - Directory for uploaded files. contains private data! Will be deleted after every restart if `KEEP_FILES=false`
- `/home/worker/app/models` - Directory for custom llm models. Mount your own model here and set environment variable `LOCAL_LLM_HF_MODEL_FILE`

### 4 Ports <a name="ports"></a>

- `8080/tcp` - HTTP Port

### 5 Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-julianreith%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### 6 License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
``
