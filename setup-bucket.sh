#!/bin/bash
#
# setup-bucket.sh
#	Ensures that the account S3 bucket is in place and correctly configured.
#
# Usage:
#	setup-bucket.sh
#
# Environment Variables:
#	AWS_ACCESS_KEY_ID		The ID of the Access Key to use to make AWS API calls.
#	AWS_SECRET_ACCESS_KEY	The secret Access Key to use to make AWS API calls.
#   BUCKET_NAME				The name of the bucket to setup correctly.
#

set -eu

bucket_name=${BUCKET_NAME}

# Check if the bucket exists
if ! aws s3api head-bucket --bucket $bucket_name 2> /dev/null; then
	# Create the bucket
	if ! aws s3api create-bucket --acl private --bucket $bucket_name > /dev/null; then
		exit 1
	fi
fi

# Make sure the right ACL is set
aws s3api put-bucket-acl \
		--bucket $bucket_name \
		--acl private

# Make sure bucket versioning is enabled
aws s3api put-bucket-versioning \
		--bucket $bucket_name \
		--versioning-configuration Status=Enabled
