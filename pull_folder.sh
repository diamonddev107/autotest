#!/bin/bash

GIT_REPO=github.com/dmitrynazm123/autotest.git
GIT_BRANCH=master
GIT_USER=dmitrynazm123
GIT_PASS=readytogo418

username=qd1
password=ctm123

git pull https://$GIT_USER:$GIT_PASS@github.com/dmitrynazm123/autotest.git master

CTM_SERVER=$1
FOLDER=$2

FILE_NAME=${CTM_SERVER}_${FOLDER}.json

EM_HOSTNAME=vpma-ctm-prd01.vpmagroup.com
endpoint=https://$EM_HOSTNAME:8443/automation-api

# Login
login=$(curl -k -H "Content-Type: application/json" -X POST -d "{\"username\":\"$username\",\"password\":\"$password\"}"   "$endpoint/session/login" )

token=$(echo $login | grep -Eo '"token"[^,]*' | grep -Eo '[^:]*$')
token=$(echo "$token" | sed -e 's/^"//' -e 's/"$//')
token=$(echo "$token" | tr -d '"')

result=$(curl -k -H "Authorization: Bearer $token" -X POST -F "definitionsFile=@export/$FILE_NAME" "$endpoint/deploy")

echo ${result}