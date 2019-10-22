# chrome-remote-desktop-pipeline

A pipeline to deploy a Chrome Remote Desktop host
based on a development environment.

See [joatmon08/chrome-remote-desktop-image](https://github.com/joatmon08/chrome-remote-desktop-image) for the image used.

## Pre-Requisites

- Terraform
- Terraform Cloud
- Google Cloud
- CircleCI

## Usage

1. Make sure to create a Terraform Cloud workspace and add the variables
   required in `variables.tf`.

1. Add the following to the CircleCI environment variables;
   ```shell
   GCLOUD_SERVICE_KEY="json service account key"
   SSH_PUBLIC_KEY="SSH public key for host"
   TFCLOUD_SERVICE_KEY="API token for Terraform Cloud"
   ```

## Caveat

Run `make code-retrieve` to open a browser and retrieve a refresh token.
You must do this before running the pipeline.