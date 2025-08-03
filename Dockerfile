# Use Ubuntu as base image for Roc compatibility
FROM --platform=linux/amd64 ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV ROC_VERSION=0.12.0

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    build-essential \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js and npm
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# Install Roc (using alpha3-rolling release)
RUN wget -O roc.tar.gz "https://github.com/roc-lang/roc/releases/download/alpha3-rolling/roc-linux_x86_64-alpha3-rolling.tar.gz" \
    && tar -xzf roc.tar.gz \
    && mv roc_nightly-linux_x86_64-*/roc /usr/local/bin/ \
    && rm -rf roc_nightly-linux_x86_64-* \
    && rm roc.tar.gz

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./
COPY tailwind.config.js ./

# Install Node.js dependencies
RUN npm ci --only=production

# Copy source code
COPY src/ ./src/
COPY static/ ./static/
COPY templates/ ./templates/
COPY content/ ./content/

# Build CSS
RUN npm run build:css

# Build Roc application
RUN roc build src/main.roc --linker legacy --output main

# Expose port (Railway will set PORT environment variable)
EXPOSE 8000

# Create a startup script to handle Railway's PORT environment variable
RUN echo '#!/bin/bash\n\
if [ -n "$PORT" ]; then\n\
    export ROC_BASIC_WEBSERVER_PORT=$PORT\n\
fi\n\
exec ./main' > /app/start.sh && chmod +x /app/start.sh

# Start the application
CMD ["/app/start.sh"]
