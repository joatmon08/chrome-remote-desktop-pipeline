#!/bin/bash -
export TFH_org=$(sed -n '/.*organization = "\(.*\)"/s//\1/p' backend/${INFRA_ENVIRONMENT})
export TFH_name=$(sed -n '/.*name = "\(.*\)"/s//\1/p' backend/${INFRA_ENVIRONMENT})

go test ./test/contract/... -v