current=`date "+%Y-%m-%d %H:%M:%S"`
timeStamp=`date -d "$current" +%s`
currentTimeStamp=$((timeStamp*1000+`date "+%N"`/1000000))

curl -X POST https://159.23.91.46/api/releases -H "Authorization: apiToken 0howH44PRw2Aj2-3yg_BLQ" -H "Content-Type: application/json" -d '{"name": "Version 1.0", "start": 1652853972000, "applications": [{"name": "robot-shop-docker"}]}' -k
