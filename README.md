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
   1. You can do this manually by creating a `local.env` file as such
      ```shell
      export TF_VAR_credentials=$(cat key-terraform.json)
      export TF_VAR_crd_code=""
      export TF_VAR_crd_pin=<add PIN here>
      export TF_VAR_crd_user=<make sure this is the same user as your image>
      export TF_VAR_public_key=$(cat circleci.pub)
      export TF_VAR_project=<add gcp project here>
      export TF_VAR_prefix=<choose a prefix>
      export TF_VAR_region=<choose a gcp region>
      export INFRA_ENVIRONMENT=<choose your backend configuration file>
      ```
    1. Then, run the `pushvars` script to push these up locally.
       ```shell
       bash ./scripts/pushvars.sh -l true
       ```

1. Note that the `TF_VAR_crd_code` and `TF_VAR_region` will be overwritten by
   CircleCI.

1. Get the refresh token from
   [remotedesktop.google.com/headless](https://remotedesktop.google.com/headless).
   Copy this. You need to get a new one *each* time you run the pipeline

1. Add the following to the CircleCI environment variables;
   ```shell
   GCLOUD_SERVICE_KEY="json service account key"
   SSH_PUBLIC_KEY="SSH public key for host"
   TFCLOUD_SERVICE_KEY="API token for Terraform Cloud"
   TF_VAR_crd_code="Refresh token that you got above."
   TF_VAR_region="Region you want to deploy the instance to"
   ```