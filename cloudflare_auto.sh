#!/bin/bash

# Konfigurasi
ZONE_ID="your_zone_id"
API_TOKEN="your_api_token"
THRESHOLD=80  # Persentase CPU yang dianggap tinggi
CHECK_INTERVAL=60  # Waktu pengecekan dalam detik
CLOUDFLARE_API="https://api.cloudflare.com/client/v4/zones/$ZONE_ID/settings/security_level"

# Fungsi untuk mengaktifkan dan menonaktifkan Under Attack Mode
set_under_attack_mode() {
    local mode="$1"
    curl -s -X PATCH "$CLOUDFLARE_API" \
        -H "Authorization: Bearer $API_TOKEN" \
        -H "Content-Type: application/json" \
        --data "{\"value\":\"$mode\"}" > /dev/null
}

# Loop untuk monitoring CPU
while true; do
    CPU_LOAD=$(awk '{print $1}' <(uptime | awk -F'[a-z]:' '{ print $2 }'))
    CPU_LOAD_INT=${CPU_LOAD%.*}  # Ambil nilai integer

    if [ "$CPU_LOAD_INT" -ge "$THRESHOLD" ]; then
        echo "CPU tinggi ($CPU_LOAD_INT%), mengaktifkan Under Attack Mode..."
        set_under_attack_mode "under_attack"
    else
        echo "CPU normal ($CPU_LOAD_INT%), menonaktifkan Under Attack Mode..."
        set_under_attack_mode "high"
    fi

    sleep $CHECK_INTERVAL
done
