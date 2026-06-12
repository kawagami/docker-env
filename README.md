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
├── docker-compose.yml              # 基礎服務（nginx、database、valkey、certbot）
├── nginx/nginx.conf                # Nginx 主設定
├── nginx/cloudflare.ini            # Cloudflare API Token（不進 git，需自行建立）
├── api-server-axum/
│   ├── docker-compose-prod.yml
│   ├── prod.conf                   # Nginx vhost
│   ├── .env                        # 需自行建立（參考 .env 說明）
│   ├── uploads/                    # 上傳檔案（VPS 上需存在）
│   └── torrents/                   # torrent 檔案（VPS 上需存在）
├── next-blog/
│   ├── docker-compose-prod.yml
│   ├── prod.conf
│   └── .env.production
├── shells/
│   ├── issue-cert.sh               # 首次取得 Let's Encrypt 憑證（部署後執行一次）
│   ├── up.sh                       # CI 部署用，依 .env 的 COMPOSE_FILE 啟動
│   └── ...                         # 其他常用腳本
└── .github/workflows/docker-env.yml  # push main 自動部署
```

## 部署

### 自動部署（平常用這個）

push 到 `main` → GitHub Actions SSH 進 VPS 執行 `git pull` + `shells/up.sh`。
`up.sh` 依 VPS 上 `.env` 的 `COMPOSE_FILE` 變數決定啟動哪些服務，VPS 上需設定：

```env
COMPOSE_FILE=docker-compose.yml:api-server-axum/docker-compose-prod.yml:next-blog/docker-compose-prod.yml
```

注意：部署不會自動 pull 新 image，更新 `kawagami77/*` image 後需在 VPS 手動 `docker compose pull`。

### 手動啟動

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
3. 啟動所有服務（此時 nginx 會因找不到憑證起不來，屬正常現象）
4. 取得憑證：`bash shells/issue-cert.sh`
5. 重啟 nginx：`docker compose restart nginx`

### 自動更新

憑證每 90 天到期，certbot container 每 12 小時自動 renew，nginx 每 6 小時自動 reload 載入新憑證，無需手動處理。

## api-server-axum .env 設定

```env
APP_PORT=3000
DATABASE_URL=postgres://kawa:kawa@database:5432
JWT_SECRET=<secret>
REDIS_HOST=valkey
HACKMD_TOKEN=<token>
```
