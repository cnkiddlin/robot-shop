sudo docker stop `docker ps -aq`

sudo sed -i 's/2.2.0/2.1.0/' .env

sudo docker compose up

current=`date "+%Y-%m-%d %H:%M:%S"`
timeStamp=`date -d "$current" +%s`
Date=`date "+%N"`
currentTimeStamp=$((timeStamp*1000+$((10#$Date))/1000000))

curl -X POST https://159.23.91.46/api/releases -H "Authorization: apiToken 0howH44PRw2Aj2-3yg_BLQ" -H "Content-Type: application/json" -d '{"name": "Roll Back: 2.1.0", "start": '${currentTimeStamp}', "applications": [{"name": "robot-shop-docker"}]}' -k
