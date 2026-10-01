# Darkoza CLI

Darkoza CLI is a downstream-branded coding agent based on the open-source Kilo Code CLI.

## Parspack configuration

Darkoza treats Parspack as an OpenAI-compatible provider.

The server launcher reads the existing Parspack credential from
/root/goths-ai-platform/tools/.env unless DARKOZA_ENV_FILE is set.
The credential is never copied into Darkoza config files.

Set a model with:

    export DARKOZA_MODEL="xiaomi/mimo-v2.5"

Optional overrides:

    export DARKOZA_BASE_URL="https://ai.parspack.com/v1"
    export DARKOZA_CONTEXT="131072"
    export DARKOZA_OUTPUT="16384"

Useful commands:

    darkoza setup
    darkoza doctor
    darkoza models
    darkoza

Use any model ID returned by darkoza models.
The generated config stores only the endpoint, model metadata,
and an environment-variable reference for the API key.

The upstream MIT license and attribution are retained.
