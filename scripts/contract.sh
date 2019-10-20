#!/bin/bash -
export TFH_org=$(sed -n '/.*organization = "\(.*\)"/s//\1/p' backend)
export WORKSPACE_PREFIX=$(sed -n '/.*prefix = "\(.*\)"/s//\1/p' backend)
export TFH_name=${WORKSPACE_PREFIX}dev

go test ./test/contract/... -v