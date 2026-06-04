# Vultr VPS Docker 環境

## 服務架構

| 服務 | Image | 說明 |
|------|-------|------|
| nginx | nginx:alpine | 反向代理 |
| database | postgres:17-alpine | 資料庫 |
| valkey | valkey/valkey:alpine | Cache（Redis 相容） |
| api-server-axum | kawagami77/api-server:axum | Rust/Axum 後端 |
| next-blog | kawagami77/my-next-blog:latest | Next.js 前端 |
| certbot | certbot/dns-cloudflare | Let's Encrypt 憑證自動更新 |

## 目錄結構

```
docker-env/
├── docker-compose.yml              # 基礎服務（nginx、database、valkey）
├── nginx/nginx.conf                # Nginx 主設定
├── nginx/cloudflare.ini            # Cloudflare API Token（不進 git，需自行建立）
├── api-server-axum/
│   ├── docker-compose-prod.yml
│   ├── prod.conf                   # Nginx vhost
│   └── .env                       # 需自行建立（參考 .env 說明）
├── next-blog/
│   ├── docker-compose-prod.yml
│   ├── prod.conf
│   └── .env.production
└── shells/
    ├── issue-cert.sh               # 首次取得 Let's Encrypt 憑證（部署後執行一次）
    └── ...                         # 其他常用腳本
```

## 啟動

```bash
docker compose \
  -f docker-compose.yml \
  -f api-server-axum/docker-compose-prod.yml \
  -f next-blog/docker-compose-prod.yml \
  up -d
```

## HTTPS 憑證設定

使用 Let's Encrypt（DNS-01 via Cloudflare API），Cloudflare SSL/TLS 模式需設為 **Full (Strict)**。

### 首次部署流程

1. 建立 `nginx/cloudflare.ini`，填入 Cloudflare API Token（Zone / DNS / Edit 權限）：
   ```ini
   dns_cloudflare_api_token = YOUR_API_TOKEN
   ```
2. 設定權限：`chmod 600 nginx/cloudflare.ini`
3. 啟動所有服務
4. 取得憑證：`bash shells/issue-cert.sh`
5. 重啟 nginx：`docker compose restart nginx`

憑證每 90 天到期，certbot container 每 12 小時自動 renew。

## api-server-axum .env 設定

```env
APP_PORT=3000
DATABASE_URL=postgres://kawa:kawa@database:5432
JWT_SECRET=<secret>
REDIS_HOST=valkey
HACKMD_TOKEN=<token>
```
