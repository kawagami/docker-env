# 第一階段：構建工具
FROM rust:1.82.0-slim-bookworm AS builder

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    pkg-config \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# 安裝 sqlx-cli
RUN cargo install sqlx-cli

# 第二階段：僅保留執行環境
FROM debian:bookworm-slim

# 安裝 sqlx-cli 運行所需的最小依賴
RUN apt-get update && apt-get install -y \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# 從 builder 複製已編譯好的 sqlx-cli
COPY --from=builder /usr/local/cargo/bin/sqlx /usr/local/bin/sqlx

# 驗證 sqlx-cli 是否可用
CMD ["sqlx", "--version"]
