#!/bin/bash -
HOSTNAME=$(terraform output hostname)
GCLOUD_PROJECT=$(terraform output project)
GCLOUD_ZONE=$(terraform output gcloud_zone)
USER=$(terraform output user)
CODE=$(terraform output crd_code)
PIN=$(terraform output crd_pin)

echo $SSH_PUBLIC_KEY > ${HOME}/.ssh/google_compute_engine.pub
chmod 0600 ${HOME}/.ssh/google_compute_engine.pub
cp ${HOME}/.ssh/id_rsa_aede9c90744f2d2ba8aa78236a99a10b ${HOME}/.ssh/google_compute_engine
gcloud config set project ${GCLOUD_PROJECT}
gcloud auth activate-service-account packer-builder@hc-da-test.iam.gserviceaccount.com --key-file=${GOOGLE_APPLICATION_CREDENTIALS}
gcloud compute ssh --zone ${GCLOUD_ZONE} ${USER}@${HOSTNAME} --command 'DISPLAY= /opt/google/chrome-remote-desktop/start-host --name=\"${HOSTNAME}\" --code=\"${CODE}\" --pin=\"${PIN}\" --redirect-url=\"https://remotedesktop.google.com/_/oauthredirect\"'