#!/bin/bash
# Ended up not using this script, as Github actions over 2k IPs, and Azure keyvault only supports setting 1k in the networks ACL rules.
RESPONSEACTIONS=$(curl -s https://api.github.com/meta | jq '.actions')
ACTIONSIPS=$(echo $RESPONSEACTIONS | sed 's/[]"['\s']//g') # Remove double quotes and brackets from response
ACTIONSIPS1=$(echo $ACTIONSIPS | sed "s/ //g")
echo $ACTIONSIPS1

mv githubactionsips.tf githubactionsips.tf_old

cat << EOF > githubactionsips.tf
variable "actionsips" {
  type        = string
  default     = "$ACTIONSIPS1"
  description = "Github actions IPs, obtained from https://api.github.com/meta."
}
EOF