#!/bin/bash -

if [[ ! $(terraform state list) ]]; then
  echo "Resources already deleted"
  exit 0
fi

HOSTNAME=$(terraform output hostname)
GCLOUD_PROJECT=$(terraform output project)
GCLOUD_ZONE=$(terraform output gcloud_zone)

gcloud config set project ${GCLOUD_PROJECT}
gcloud auth activate-service-account terraform@${GCLOUD_PROJECT}.iam.gserviceaccount.com --key-file=${GOOGLE_APPLICATION_CREDENTIALS}
gcloud compute instances stop ${HOSTNAME} --zone ${GCLOUD_ZONE}