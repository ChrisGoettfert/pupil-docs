#!/bin/bash
echo "Deploying to production"
eval "$(ssh-agent -s)"
chmod 600 ./docs_deploy_key
echo -e "Host $SERVER_IP\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config
ssh-add ./docs_deploy_key
rsync -hrvz --delete --exclude '.htaccess' -e 'ssh -i ./docs_deploy_key -o "StrictHostKeyChecking no"' src/.vuepress/dist/ ${SERVER_USER}@${SERVER_IP}:~/domains/docs.pupil-labs.com/html/
echo "Production deployed"