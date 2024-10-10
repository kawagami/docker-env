# FROM rust:1.77
FROM rust:1.78.0-slim-bullseye

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    pkg-config \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

RUN cargo install sqlx-cli

CMD cargo --version