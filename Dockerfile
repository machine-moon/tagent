FROM fedora:latest

# Install Node.js and system dependencies
RUN dnf update -y \
    && dnf install -y \
        nodejs \
        npm \
        htop \
        git \
        vim \
        nano \
        python3 \
        python3-pip \
        gcc \
        gcc-c++ \
        make \
        libluv \
        lua-lpeg \
        wget \
    && dnf group install -y development-tools c-development \
    && dnf clean all \
    && rm -rf /var/cache/dnf

# Create a dedicated user for the agent
RUN useradd -m -s /bin/bash agent

# Set working directory
WORKDIR /home/agent


# Set environment variables
ENV NODE_ENV=production
ENV NPM_CONFIG_PREFIX=/home/agent/mcp-services
ENV PATH="${PATH}:/home/agent/mcp-services/bin"


# Install Gemini CLI globally
RUN npm install -g @google/gemini-cli

# Create directories for MCP services and workspace
RUN mkdir -p /home/agent/mcp-services /home/agent/workspace

# Install selected MCP servers globally
RUN npm install -g \
    @modelcontextprotocol/server-memory \
    @modelcontextprotocol/server-filesystem \
    @upstash/context7-mcp 

# Install the Gemini CLI
RUN chown -R agent:agent /home/agent

# Switch to the agent user
USER agent

# Expose any ports if needed (adjust as necessary)
EXPOSE 34117
EXPOSE 8080
EXPOSE 433
EXPOSE 80

# Set the default command
# CMD ["gemini"]