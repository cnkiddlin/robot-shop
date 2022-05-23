#!/bin/bash
export INSTANA_AGENT_KEY="qUMhYJxjSv6uZh2SyqTEnw"

echo start build
sudo docker compose build

echo start up
sudo nohup docker compose up >/dev/null 2>&1 &


current=`date "+%Y-%m-%d %H:%M:%S"`
timeStamp=`date -d "$current" +%s`
currentTimeStamp=$((timeStamp*1000+`date "+%N"`/1000000))
sudo curl -X POST https://159.23.91.46/api/releases -H "Authorization: apiToken 0howH44PRw2Aj2-3yg_BLQ" -H "Content-Type: application/json" -d '{"name": "New Release", "start": '${currentTimeStamp}', "applications": [{"name": "robot-shop-docker"}]}' -k


