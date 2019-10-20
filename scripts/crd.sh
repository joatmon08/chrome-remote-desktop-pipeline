#!/bin/bash -
HOSTNAME=$(terraform output hostname)
GCLOUD_ZONE=$(terraform output gcloud_zone)
USER=$(terraform output user)
CODE=$(terraform output crd_code)
PIN=$(terraform output crd_pin)

gcloud compute ssh --zone ${GCLOUD_ZONE} ${USER}@${HOSTNAME} --command 'DISPLAY= /opt/google/chrome-remote-desktop/start-host --code=\"${CODE}\" --redirect-url=\"https://remotedesktop.google.com/_/oauthredirect\" --name=${HOSTNAME} --pin=${PIN}'
