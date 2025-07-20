# Vultr VPS Website Structure

## 簡介
* 因為 VPS 目前為 1 核心 1G RAM 故 loki & grafana 先不啟用
* 要啟用 loki & grafana 的服務的話需先執行以下動作
```shell
# 在 docker-compose.yml 同一層執行：

sudo mkdir -p ./grafana-data
sudo chown -R 472:472 ./grafana-data

sudo mkdir -p ./loki-data
sudo chown -R 10001:10001 ./loki-data
```
* 流程之後可能測試是否能改善為不用手動執行以上指令
