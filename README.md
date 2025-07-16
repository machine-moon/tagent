# T-Agent

A containerized development environment with AI tools (Gemini, OpenCode) and enhanced shell capabilities.

## Quick Start

```bash
make all  # Build, start, and enter container
```

## Features

- **AI Tools**: Pre-installed Gemini CLI and OpenCode
- **Enhanced Shell**: Custom prompt and environment variables
- **Persistent Storage**: Workspace and home directory volumes
- **Development Tools**: Node.js, Python, build tools, and more

## Container Management

Use the `t()` function for seamless container interaction:

```bash
t container-id tool [args...]
# Run tools in container workspace
t agent gemini -p "analyze this code"
t agent gemini -d
t agent gemini --show_memory_usage
t agent my-project gemini -p "review changes"
t agent my-project gemini -p "generate tests"
```

The function automatically detects if the second argument is a directory path within the workspace and sets the working directory accordingly.

## Configuration

### Environment Setup

Create a file to source env variables or don't, project using default ARGS in Dockerfile (has assumpitons on UID and workspace folder):
Copy the example environment file and edit it with your values:

```bash
# Agent Configuration
export AGENT_UID=1000
export AGENT_GID=1000

# Environment Variables
export NPM_CONFIG_PREFIX=/home/agent/npm
export NODE_ENV=production
export TZ=America/Toronto

# API Keys (optional - can be set during runtime)
export GEMINI_API_KEY=
export OPENCODE_API_KEY=
export OPENROUTER_API_KEY=
```

### Custom Init Script

The container sources `agents.sh` on startup. Customize it for your workflow:

```bash
# Example agents.sh configuration
export TZ=America/Toronto
export PS1='\[\033[01;67m\]\A \[\033[01;32m\]\W\[\033[00m\] '

alias gemini="gemini --show_memory_usage"
```

## Gemini OAuth Setup

**Important**: When setting up Gemini OAuth, replace `localhost` with the container IP in the callback URL:

```bash
# Get container IP
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' agent

# Use this IP instead of localhost:34117 in your OAuth callback URL
```

## Commands

```bash
make build   # Build container
make serve   # Start container
make enter   # Enter container shell
make remove  # Stop and remove container with volumes
```

## Deployment

You can deploy T-Agent using either **Docker Compose** or a simple **docker run** command.

### Docker Compose

Start the container:

```bash
docker compose up -d
```

Stop the container and remove resources:

```bash
docker compose down -v
```


### Docker Run

Alternatively, run the container directly:

```bash
docker run 
```

Replace `your-dockerhub-username/t-agent:latest` with your actual image name if needed.

## Architecture

- **Base**: Fedora 42
- **User**: Non-root agent user (UID/GID 1000)
- **Workspace**: `/home/agent/workspace` (mounted from host)
- **Home**: `/home/agent` (persistent Docker volume)
- **Ports**: 34117, 8080, 80, 443