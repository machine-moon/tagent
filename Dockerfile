FROM fedora:42

# Install system dependencies in a single layer
RUN dnf update -y && dnf install -y \
    nodejs \
    npm \
    git \
    vim \
    htop \
    python3 \
    python3-pip \
    gcc \
    gcc-c++ \
    make \
    wget \
    && dnf group install -y development-tools c-development \
    && dnf clean all \
    && rm -rf /var/cache/dnf

# Create user, this allows the container to run with the same permissions as your host user.
ARG AGENT_UID=1000
ARG AGENT_GID=1000
RUN groupadd -g $AGENT_GID agent && \
    useradd -m -u $AGENT_UID -g $AGENT_GID -s /bin/bash agent && \
    chown -R agent:agent /home/agent

# Configure environment
ARG NPM_CONFIG_PREFIX=/home/agent/npm
ARG NODE_ENV=production
ARG TZ=America/Toronto
ENV NPM_CONFIG_PREFIX=$NPM_CONFIG_PREFIX \
    NODE_ENV=$NODE_ENV \
    TZ=$TZ \
    PATH="${PATH}:$NPM_CONFIG_PREFIX/bin"

# Install npm packages in a single layer
RUN npm install -g \
    @google/gemini-cli \
    opencode-ai \
    @modelcontextprotocol/server-memory \
    @modelcontextprotocol/server-filesystem \
    @upstash/context7-mcp


EXPOSE 34117 8080 433 80  

USER agent

# Custom script to source a script which (for me) loads a library of custom bash functions, see tsuite repository.
RUN bash -c "echo 'source $HOME/workspace/agents.sh' >> $HOME/.bashrc"

WORKDIR /home/agent/workspace
