#!/bin/bash -
HOSTNAME=$(terraform output hostname)
GCLOUD_PROJECT=$(terraform output project)
GCLOUD_ZONE=$(terraform output gcloud_zone)
USER=$(terraform output user)
CODE=$(terraform output crd_code)
PIN=$(terraform output crd_pin)

echo $SSH_PUBLIC_KEY > ${HOME}/.ssh/google_compute_engine.pub
chmod 0600 ${HOME}/.ssh/google_compute_engine.pub
cp ${HOME}/.ssh/id_rsa_${KEY_FINGERPRINT} ${HOME}/.ssh/google_compute_engine
gcloud config set project ${GCLOUD_PROJECT}
gcloud auth activate-service-account terraform@${GCLOUD_PROJECT}.iam.gserviceaccount.com --key-file=${GOOGLE_APPLICATION_CREDENTIALS}
sleep 60

if [[ $(gcloud compute ssh --zone ${GCLOUD_ZONE} ${USER}@${HOSTNAME} --command "ps aux | grep \"[ch]rome-remote-desktop-host\"") ]]; then
  echo "Already initialized"
  exit 0
else
  gcloud compute ssh --zone ${GCLOUD_ZONE} ${USER}@${HOSTNAME} --command "DISPLAY= /opt/google/chrome-remote-desktop/start-host --name=\"${HOSTNAME}\" --pin=\"${PIN}\" --code=\"${CODE}\" --redirect-url=\"https://remotedesktop.google.com/_/oauthredirect\""
fi
