# IPScope

IPScope 是一个基于 FastAPI、GeoLite2 和 GeoCN 的轻量级 IP 地理位置与 ASN 查询服务。

| 字段                    |
| ------------------------- |
| ip                      | 
| addr                    | 
| as.number               | 
| as.name                 | 
| as.info                 | 
| location.latitude       | 
| location.longitude      | 
| country.code            | 
| country.name            | 
| registered_country.code |
| registered_country.name | 
| regions                 | 
| regions_short           | 
| type                    |

### 使用方法

查询其他ipv4：`https://ip.xxx.com/1.1.1.1` `https://ip.xxx.com/?ip=1.1.1.1`

查询其他ipv6：`https://ip.xxx.com/2409:8900:1800::` `https://ip.xxx.com/?ip=2409:8900:1800::`

### Python 版本

最低支持 Python 3.13。Docker 镜像默认使用 Python 3.14。

### 数据库文件

服务启动前需要准备以下数据库文件，默认从当前工作目录读取：

| 文件 | 下载地址 |
| --- | --- |
| GeoLite2-City.mmdb | https://github.com/P3TERX/GeoLite.mmdb/raw/download/GeoLite2-City.mmdb |
| GeoLite2-ASN.mmdb | https://github.com/P3TERX/GeoLite.mmdb/raw/download/GeoLite2-ASN.mmdb |
| GeoCN.mmdb | https://github.com/ljxi/GeoCN/releases/download/Latest/GeoCN.mmdb |

Docker 部署会通过 `update_and_restart.sh` 自动下载并每 7 天检查更新一次。本地运行时需要手动下载，或自行执行该脚本。

### 环境变量

| 变量 | 默认值 | 说明 |
| --- | --- | --- |
| LOG_FILE | /code/ip_query.log | 查询日志文件路径 |
| GEOIP_CITY_DB | GeoLite2-City.mmdb | GeoLite2 城市数据库路径 |
| GEOIP_ASN_DB | GeoLite2-ASN.mmdb | GeoLite2 ASN 数据库路径 |
| GEOIP_CN_DB | GeoCN.mmdb | GeoCN 数据库路径 |

### 本地运行

安装依赖：

```sh
pip install -r requirements.txt
```

启动 API 服务：

```sh
LOG_FILE=./ip_query.log python main.py api --host 0.0.0.0 --port 7887
```

命令行查询模式：

```sh
LOG_FILE=./ip_query.log python main.py query
```

Windows PowerShell 示例：

```powershell
$env:LOG_FILE = ".\ip_query.log"
python main.py api --host 0.0.0.0 --port 7887
```

### Docker 部署


#### 构建镜像

`docker build -t geoip-api .`

#### 运行容器

`docker run -d --name geoip-api -p 7887:7887 geoip-api`

---

### 在线拉取

`docker pull ghcr.io/pseuo/geoip:main`

`docker run --name geoip -d -p 7887:7887 ghcr.io/pseuo/geoip`
