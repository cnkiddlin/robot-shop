#!/bin/bash
export INSTANA_AGENT_KEY="qUMhYJxjSv6uZh2SyqTEnw"

echo start build
sudo docker compose build

echo start up
sudo nohup docker compose up >/dev/null 2>&1 &

line=`cat .env |head -n 3|tail -n 1`
version=${line: 4}

current=`date "+%Y-%m-%d %H:%M:%S"`
timeStamp=`date -d "$current" +%s`
currentTimeStamp=$((timeStamp*1000+`date "+%N"`/1000000))
sudo curl -X POST https://159.23.91.46/api/releases -H "Authorization: apiToken 0howH44PRw2Aj2-3yg_BLQ" -H "Content-Type: application/json" -d '{"name": "'${version}'", "start": '${currentTimeStamp}', "applications": [{"name": "robot-shop-docker"}]}' -k


