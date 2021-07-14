#!/bin/bash

GIT_REPO=github.com/dmitrynazm123/autotest.git
GIT_BRANCH=master
GIT_USER=dmitrynazm123
GIT_PASS=readytogo418

username=qd1
password=ctm123


CTM_SERVER=$1
FOLDER=$2

EM_HOSTNAME=vpma-ctm-prd01.vpmagroup.com
endpoint=https://$EM_HOSTNAME:8443/automation-api
# Login
login=$(curl -k -H "Content-Type: application/json" -X POST -d "{\"username\":\"$username\",\"password\":\"$password\"}"   "$endpoint/session/login" )

token=$(echo $login | grep -Eo '"token"[^,]*' | grep -Eo '[^:]*$')
token=$(echo "$token" | sed -e 's/^"//' -e 's/"$//')
token=$(echo "$token" | tr -d '"')

result=$(curl -k -H "Authorization: Bearer $token" "$endpoint/deploy/jobs?ctm=$CTM_SERVER&folder=$FOLDER&format=JSON")

echo ${result} >> export/${CTM_SERVER}_${FOLDER}.json

# git push https://$GIT_USER:$GIT_PASS@$GIT_REPO --all
# git remote set-url origin https://$GIT_USER:$GIT_PASS@github.com/autopush_test.git --all
# git push origin master

# git config --global user.name "$GIT_USER"
# git config --global user.password "$GIT_PASS"
git add .
git commit -m "add export xml"
git push origin master

# git add .
# git commit -m "add export xml"
# git push https://$GIT_USER:$GIT_PASS@github.com/dmitrynazm123/autotest.git master