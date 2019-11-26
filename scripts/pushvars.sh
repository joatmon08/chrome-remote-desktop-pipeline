#!/bin/bash -

while getopts ":l:" opt; do
  case ${opt} in
    l )
      local=1
      ;;
    \? )
      echo "Invalid option: $OPTARG" 1>&2
      ;;
    : )
      echo "Invalid option: $OPTARG requires an argument" 1>&2
      ;;
  esac
done
shift $((OPTIND -1))

export TFH_token=$(sed -n '/.*token = "\(.*\)"/s//\1/p' ${HOME}/.terraformrc)
export TFH_org=$(sed -n '/.*organization = "\(.*\)"/s//\1/p' backend/${INFRA_ENVIRONMENT})
export TFH_name=$(sed -n '/.*name = "\(.*\)"/s//\1/p' backend/${INFRA_ENVIRONMENT})

if [[ "$local" -eq 1 ]]; then
  tfh pushvars -overwrite GOOGLE_CREDENTIALS -senv-var GOOGLE_CREDENTIALS="$TF_VAR_credentials" \
    -overwrite CONFIRM_DESTROY -env-var CONFIRM_DESTROY=1 \
    -overwrite crd_code -svar crd_code=${TF_VAR_crd_code} \
    -overwrite crd_pin -svar crd_pin=${TF_VAR_crd_pin} \
    -overwrite crd_user -svar crd_user=${TF_VAR_crd_user} \
    -overwrite public_key -svar public_key="${TF_VAR_public_key}" \
    -overwrite project -svar project=${TF_VAR_project} \
    -overwrite prefix -var prefix=${TF_VAR_prefix} \
    -overwrite region -var region=${TF_VAR_region}
else
  tfh pushvars -overwrite crd_code -svar crd_code=${TF_VAR_crd_code} \
    -overwrite region -var region=${TF_VAR_region}
fi