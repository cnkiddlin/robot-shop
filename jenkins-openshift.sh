#!/bin/bash
docker login -u kiddlin -p kiddlkd0122001
oc login --token=eyJhbGciOiJSUzI1NiIsImtpZCI6IlRxMFl2NUNpSFM3TERnU3hXM3J5NFVOYVZuNGt4N2h2cDlnNWZMTzFhbkUifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImRlbW8tYWRtaW4tdG9rZW4tMmpmeGQiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiZGVtby1hZG1pbiIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6ImUyMDA3ZWEzLTMzYTctNGNjZS1hNjZlLTQ3MTc1MjMxM2JlYiIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDpkZWZhdWx0OmRlbW8tYWRtaW4ifQ.sYZ7K6Smk9Wvr9u1LgRGeRlPL4tdq45o4WaYtKhQKgmifCXaQQOQpSKlwYVgGGAOOWqqpR3QZudwaphq-0jHvt-Z2ezZQ26hYwkIirtDG-NrCxMWPVflLBgx2XWgVX6ZilIclWmfZ2MwNq7ScU3533Qkonjb4ASgCRy8u_eSjO7ofUGy5lmLnPOZQVDPkzvK2VVIcOjiTxVZI79V1WR6sJvUQe2NGKoVceGEYobklIwLr30-Dz9oEcVc5LjMKB2n_PJ_iCavTaCqkyzErI-LKWYp4hPslQ9Ngk8JYG4jBc5yOKW-EZxb5pVHviUwzTT8dIibmEnirfRhHJ9iy8M2LA --server=https://c100-e.au-syd.containers.cloud.ibm.com:30052
export KUBECONFIG=/root/.kube/config

cd robot-shop
docker compose build
docker compose push

oc delete project robot-shop
sleep 1m

oc adm new-project robot-shop
oc adm policy add-scc-to-user anyuid -z default -n robot-shop
oc adm policy add-scc-to-user privileged -z default -n robot-shop

cd K8s
helm install robot-shop --set openshift=true --set image.repo=kiddlin -n robot-shop --set image.version=2.1.0 helm
sleep 1m

oc project robot-shop
oc expose web

line=`cat .env |head -n 3|tail -n 1`
version=${line: 4}

current=`date "+%Y-%m-%d %H:%M:%S"`
timeStamp=`date -d "$current" +%s`
Date=`date "+%N"`
currentTimeStamp=$((timeStamp*1000+$((10#$Date))/1000000))


curl -X POST https://159.23.91.46/api/releases -H "Authorization: apiToken 0howH44PRw2Aj2-3yg_BLQ" -H "Content-Type: application/json" -d '{"name": "'${version}'", "start": '${currentTimeStamp}', "applications": [{"name": "robot-shop-openshift"}]}' -k
