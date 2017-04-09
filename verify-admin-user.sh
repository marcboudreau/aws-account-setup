#!/bin/bash
#
# verify-admin-user.sh
#   Verifies that a provided AWS Access Key is valid and its corresponding IAM
#   User is correctly configured.
#
# Usage:
#   verify-admin-user.sh
#
# Environment Variables:
#   AWS_ACCESS_KEY_ID       The Access Key ID
#   AWS_SECRET_ACCESS_KEY   The secret Access Key
#
set -eo pipefail

function test_result() {
  if [[ $(eval "$2" ; echo $?) == '0' ]]; then
    echo "[  [32;1mOK[0m  ] $1"
  else
    echo "[[31;1mFAILED[0m] $1"
    exit 1
  fi
}

test_result "AWS_ACCESS_KEY_ID is provided" "test -n '$AWS_ACCESS_KEY_ID'"
test_result "AWS_SECRET_ACCESS_KEY is provided" "test -n '$AWS_SECRET_ACCESS_KEY'"

get_user_resp=$(docker run \
    -e AWS_DEFAULT_REGION=us-east-1 \
    -e AWS_ACCESS_KEY_ID \
    -e AWS_SECRET_ACCESS_KEY \
    jess/awscli iam get-user)

get_user_username=$(docker run \
    -e VALUE="$get_user_resp" \
    jess/jq \
    bash -c 'echo $VALUE | jq -r ".User.UserName"')

test_result "Provided Access Key belongs to 'admin' user" "test $get_user_username = 'admin'"

list_attached_user_policies_resp=$(docker run \
    -e AWS_DEFAULT_REGION=us-east-1 \
    -e AWS_ACCESS_KEY_ID \
    -e AWS_SECRET_ACCESS_KEY \
    jess/awscli iam list-attached-user-policies \
        --user-name admin)

get_attached_user_policy_name=$(docker run \
    -e VALUE="$list_attached_user_policies_resp" \
    jess/jq \
    bash -c 'echo $VALUE | jq -r ".AttachedPolicies[].PolicyName"')

test_result "The 'admin' user has 'AdministratorAccess' attached to itself" "test $get_attached_user_policy_name = 'AdministratorAccess'"
