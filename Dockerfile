
FROM ubuntu:22.04

# Evitar prompts interativos
ENV DEBIAN_FRONTEND=noninteractive

# Atualizar e instalar pacotes necessários
RUN apt-get update && \
    apt-get install -y \
    git \
    python3 \
    python3-pip \
    python3-dev \
    libpython3-dev \
    unixodbc-dev \
    freetds-dev \
    freetds-bin \
    tdsodbc \
    curl \
    gnupg \
    ca-certificates \
    nano \
    tar \
    fonts-liberation \
    libnss3 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    xdg-utils \
    wget \
    unzip \
    libncurses5 \
    libaio1 \
    libpam0g \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Instalar Node.js 20 (via NodeSource) e n8n
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g n8n


# Instalar dependências Python
RUN pip3 install python-docx


# Criar diretório para dados do n8n
RUN mkdir -p /home/node/.n8n /home/node/.cache && \
    useradd -ms /bin/bash node && \
    chown -R node:node /home/node
USER node

# Definir diretório de trabalho
WORKDIR /home/node

# Variáveis de ambiente para n8n
ENV N8N_DATA_FOLDER=/home/node/.n8n
ENV N8N_PORT=5678
ENV N8N_PROTOCOL=https

EXPOSE 5678

CMD ["n8n", "start"]