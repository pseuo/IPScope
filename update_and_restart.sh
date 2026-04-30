#!/bin/sh

download_db() {
    file="$1"
    url="$2"
    echo "Updating ${file}..."
    curl --fail --show-error --silent --location -o "${file}" "${url}"
}

retry_later() {
    echo "$1"
    sleep 60
}

while true; do
    date
    download_db "GeoLite2-City.mmdb" "https://github.com/P3TERX/GeoLite.mmdb/raw/download/GeoLite2-City.mmdb" || { retry_later "Failed to update GeoLite2-City.mmdb"; continue; }
    
    download_db "GeoLite2-ASN.mmdb" "https://github.com/P3TERX/GeoLite.mmdb/raw/download/GeoLite2-ASN.mmdb" || { retry_later "Failed to update GeoLite2-ASN.mmdb"; continue; }
    
    download_db "GeoCN.mmdb" "https://github.com/ljxi/GeoCN/releases/download/Latest/GeoCN.mmdb" || { retry_later "Failed to update GeoCN.mmdb"; continue; }

    echo "Attempting to restart uvicorn..."
    pkill -f "uvicorn"
    
    nohup uvicorn main:app --host 0.0.0.0 --port 7887 --no-server-header --proxy-headers &
    
    sleep 5
    
    if pgrep -f "uvicorn" > /dev/null; then
        echo "uvicorn restarted successfully."
    else
        echo "Failed to restart uvicorn, retrying..."
        continue
    fi

    sleep 604800
done
