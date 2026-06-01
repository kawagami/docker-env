# Vultr VPS Docker 環境

## 服務架構

| 服務 | Image | 說明 |
|------|-------|------|
| nginx | nginx:alpine | 反向代理 |
| database | postgres:17-alpine | 資料庫 |
| valkey | valkey/valkey:alpine | Cache（Redis 相容） |
| api-server-axum | kawagami77/api-server:axum | Rust/Axum 後端 |
| next-blog | kawagami77/my-next-blog:latest | Next.js 前端 |

## 目錄結構

```
docker-env/
├── docker-compose.yml              # 基礎服務（nginx、database、valkey）
├── nginx/nginx.conf                # Nginx 主設定
├── api-server-axum/
│   ├── docker-compose-prod.yml
│   ├── prod.conf                   # Nginx vhost
│   └── .env                       # 需自行建立（參考 .env 說明）
├── next-blog/
│   ├── docker-compose-prod.yml
│   ├── prod.conf
│   └── .env.production
├── sqlx-cli/migrations/            # DB migration 檔案
└── shells/                         # 常用腳本
```

## 啟動

```bash
docker compose \
  -f docker-compose.yml \
  -f api-server-axum/docker-compose-prod.yml \
  -f next-blog/docker-compose-prod.yml \
  up -d
```

## api-server-axum .env 設定

```env
APP_PORT=3000
DATABASE_URL=postgres://kawa:kawa@database:5432
JWT_SECRET=<secret>
REDIS_HOST=valkey
HACKMD_TOKEN=<token>
```
