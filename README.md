# Vultr VPS Website Structure

## 簡介

本專案使用 Docker Compose 架設一個完整的開發環境，包含以下服務：
- **Nginx**：用於反向代理和靜態檔案伺服器。
- **PostgreSQL**：作為資料庫。
- **Rust SQLx CLI**：用於管理資料庫遷移。
- **Microsoft Garnet**：提供分散式計算框架。

## 環境需求

在執行此專案前，請確保已安裝以下工具：
- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

## 快速開始

### 1. Clone 專案

```bash
git clone <YOUR_REPOSITORY_URL>
cd <PROJECT_DIRECTORY>
```

### 2. 建立必要目錄

確保以下目錄存在並設定對應內容：
- `nginx/nginx.conf`：Nginx 配置檔案。
- `sqlx-cli/.env`：SQLx CLI 配置檔案，包含資料庫連線資訊。
- `sqlx-cli/migrations`：存放資料庫遷移檔案。

### 3. 啟動服務

執行以下指令以啟動所有服務：

```bash
docker-compose up -d
```

### 4. 確認服務狀態

檢查所有服務是否正常啟動：

```bash
docker-compose ps
```

### 5. 使用 SQLx CLI 管理資料庫

進入 `sqlx-cli` 容器並執行遷移：

```bash
docker-compose run sqlx-cli migrate run
```

## 服務詳解

### 1. Nginx

- 容器名稱：`my-nginx`
- 配置檔案路徑：`./nginx/nginx.conf`
- 對應的端口：
  - HTTP：`80`
  - HTTPS：`443`

### 2. PostgreSQL

- 容器名稱：`my-pgsql`
- 資料庫名稱：`kawa`
- 預設使用者：`kawa`
- 預設密碼：`kawa`
- 資料路徑：`../dbdata`
- 健康檢查：
  - 測試命令：`pg_isready -d kawa -U kawa`
  - 重試次數：5

### 3. Rust SQLx CLI

- 容器名稱：`sqlx-cli`
- 功能：執行資料庫遷移
- 需要掛載：
  - `.env` 檔案
  - `migrations` 資料夾

### 4. Microsoft Garnet

- 容器名稱：`garnet`
- 功能：分散式計算框架
- 備註：目前未開放外部端口。

## 關於資料庫遷移

確保 `sqlx-cli/.env` 檔案中正確設定資料庫連線資訊，例如：

```env
DATABASE_URL=postgres://kawa:kawa@database:5432/kawa
```

## 停止與移除服務

### 停止所有服務

```bash
docker-compose down
```

### 清理資料

移除資料庫資料：

```bash
docker-compose down -v
```

## 參考資源

- [Nginx 官方文件](https://nginx.org/en/docs/)
- [PostgreSQL 官方文件](https://www.postgresql.org/docs/)
- [Rust SQLx CLI](https://github.com/launchbadge/sqlx)
- [Microsoft Garnet](https://microsoft.github.io/garnet/)
