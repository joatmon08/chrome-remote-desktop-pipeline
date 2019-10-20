#!/bin/bash -
export TFH_org=$(sed -n '/.*organization = "\(.*\)"/s//\1/p' backend)
export TFH_name=$(sed -n '/.*name = "\(.*\)"/s//\1/p' backend)

go test ./test/contract/... -v