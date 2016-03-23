#! /bin/bash
#
# Dependencies:
#   brew install jq
#
# Setup:
#   chmod +x ./aws-cli-assumerole.sh
#
# Execute:
#   source ./aws-cli-assumerole.sh

unset  AWS_SESSION_TOKEN
export AWS_ACCESS_KEY_ID=<user_access_key>
export AWS_SECRET_ACCESS_KEY=<user_secret_key>
export AWS_REGION=eu-west-1

temp_role=$(aws sts assume-role \
                    --role-arn "arn:aws:iam::<aws_account_number>:role/<role_name>" \
                    --role-session-name "<some_session_name>")

export AWS_ACCESS_KEY_ID=$(echo $temp_role | jq .Credentials.AccessKeyId | xargs)
export AWS_SECRET_ACCESS_KEY=$(echo $temp_role | jq .Credentials.SecretAccessKey | xargs)
export AWS_SESSION_TOKEN=$(echo $temp_role | jq .Credentials.SessionToken | xargs)

env | grep -i AWS_