#!/bin/bash -x

tfh pushvars -svar credentials="$TF_VAR_credentials" \
    -svar crd_code=${TF_VAR_crd_code} \
    -svar crd_pin=${TF_VAR_crd_pin} \
    -svar crd_user=${TF_VAR_crd_user} \
    -svar public_key="${TF_VAR_public_key}" \
		-svar project=${TF_VAR_project} \
		-var prefix=${TF_VAR_prefix} \
		-var region=${TF_VAR_region}