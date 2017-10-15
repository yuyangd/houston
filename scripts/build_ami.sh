#!/usr/bin/env bash

set -ouex pipefail

while getopts "c:d:s:i:u:v:r:n:?" OPTION; do case ${OPTION} in
    c)
      PACKER_JSON="${OPTARG}"
      ;;
    d)
      DESCRIPTION="${OPTARG}"
      ;;
    s)
      SOURCE_AMI="${OPTARG}"
      ;;
    i)
      INSTANCE_PROFILE=$(echo "${OPTARG}" | tr '[:upper:]' '[:lower:]')
      ;;
    u)
      SUBNET_ID="${OPTARG}"
      ;;
    v)
      VPC_ID=$(echo "${OPTARG}" | tr '[:upper:]' '[:lower:]')
      ;;
    r)
      REGION=$(echo "${OPTARG}" | tr '[:upper:]' '[:lower:]')
      ;;
    n)
      AMI_NAME=$(echo "${OPTARG}" | tr '[:upper:]' '[:lower:]')
      ;;
    ?)
      usage
      ;;
  esac
done

function usage() {
    cat << EOF

usage: $0 options

  OPTIONS:
     -c    [required] Path to packer json file
     -d    [required] Description of new AMI
     -s    [required] Source AMI used as a base image
     -i    [optional] IAM Instance Profile to use during image creation
     -u    [required] Subnet ID where AMI build will be performed
     -v    [required] VPC ID where AMI build will be performed
     -r    [required] Region where AMI build will be performed
     -n    [required] Name of new AMI
     -?    [optional] Print the script usage.
EOF
  exit 1
}

function check_arguments() {
  declare -a Missing=()

  set +u
  if [[ -z ${DESCRIPTION} ]]; then
    Missing=("${Missing[@]}" "Description")
  fi
  if [[ -z ${SOURCE_AMI} ]]; then
    Missing=("${Missing[@]}" "Source AMI")
  fi
  if [[ -z ${SUBNET_ID} ]]; then
    Missing=("${Missing[@]}" "Subnet ID")
  fi
  if [[ -z ${VPC_ID} ]]; then
    Missing=("${Missing[@]}" "VPC ID")
  fi
  if [[ -z ${REGION} ]]; then
    Missing=("${Missing[@]}" "Region")
  fi
  if [[ -z ${AMI_NAME} ]]; then
    Missing=("${Missing[@]}" "AMI name")
  fi
  if [[ ${#Missing[@]} -ne 0 ]]; then
    echo ""
    echo "Please provide the following parameters: "
    for i in "${Missing[@]}"; do
      echo - ${i}
    done
    usage
  fi
  set -u
}

function setup_ami_name(){
  DATE=`date +%Y%m%d-%H%M%S`
  AMI_TAG="${AMI_NAME}-${DATE}"
}


function validate() {
  ./packer validate -var "description=${DESCRIPTION}-${DATE}" \
    -var "source_ami=${SOURCE_AMI}" \
    -var "iam_instance_profile=${INSTANCE_PROFILE}" \
    -var "subnet_id=${SUBNET_ID}" \
    -var "vpc_id=${VPC_ID}" \
    -var "region=${REGION}" \
    -var "ami_name=${AMI_TAG}" \
    ${PACKER_JSON}

  if [[ $? -ne 0 ]]; then
    echo "ERROR: Packer validation failed!"
    exit 1
  fi
}

function build() {
  ./packer build \
    -var "description=${DESCRIPTION}-${DATE}" \
    -var "source_ami=${SOURCE_AMI}" \
    -var "iam_instance_profile=${INSTANCE_PROFILE}" \
    -var "subnet_id=${SUBNET_ID}" \
    -var "vpc_id=${VPC_ID}" \
    -var "region=${REGION}" \
    -var "ami_name=${AMI_TAG}" \
    ${PACKER_JSON}
}

check_arguments
setup_ami_name
validate
build
