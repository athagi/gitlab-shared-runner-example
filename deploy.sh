#!/bin/bash
STACK_NAME=gitlab-resources
aws cloudformation deploy --template-file cfn.yaml --stack-name "${STACK_NAME}" --capabilities CAPABILITY_IAM

echo "== output variables =="
outputs=$(aws cloudformation describe-stacks --stack-name "${STACK_NAME}" | jq .Stacks[].Outputs)
echo "-- GitLab server info --"
echo "GitLabServerIP=$(echo "${outputs}" | jq '.[] | select(.OutputKey == "GitLabServerPublicIP")' | jq -r .OutputValue)"
echo "GitLabServerInstanceID=$(echo "${outputs}" | jq '.[] | select(.OutputKey == "GitLabServerInstanceID")' | jq -r .OutputValue)"
echo "-- GitLab-CI [runners.machine] info --"
echo "amazonec2-access-key=$(echo "${outputs}" | jq '.[] | select(.OutputKey == "GitlabCiUserAccessKey")' | jq -r .OutputValue)"
echo "amazonec2-secret-key=$(echo "${outputs}" | jq '.[] | select(.OutputKey == "GitlabCiUserSecretAccessKey")' | jq -r .OutputValue)"

echo "amazonec2-region=$(echo "${outputs}" | jq '.[] | select(.OutputKey == "Region")' | jq -r .OutputValue)"
echo "amazonec2-vpc-id=$(echo "${outputs}" | jq '.[] | select(.OutputKey == "VPCID")' | jq -r .OutputValue)"
echo "amazonec2-subnet-id=$(echo "${outputs}" | jq '.[] | select(.OutputKey == "SubnetID")' | jq -r .OutputValue)"
echo "amazonec2-zone=$(echo "${outputs}" | jq '.[] | select(.OutputKey == "Zone")' | jq -r .OutputValue)"
echo "amazonec2-security-group=$(echo "${outputs}" | jq '.[] | select(.OutputKey == "SecurityGroupName")' | jq -r .OutputValue)"

