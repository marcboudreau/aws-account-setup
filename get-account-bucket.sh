#!/bin/bash
#
# get-account-bucket.sh
#   This script retrieves the name of the S3 bucket from the
#   terraform/backend.tf.json file.  Since that file is the authoritative source
#   of the name of the s3 bucket, we need an easy way for other processes to
#   extract that value.
#
set -e

backend_file=terraform/backend.tf.json

jq -r '.terraform.backend.s3.bucket' $backend_file
