#!/bin/zsh

usage() {
  echo "Usage: s3_bucket_removal.zsh <--dry-run|--remove> <prefix>"
  exit 1
}

if [[ $# -ne 2 ]]; then
  usage
fi

mode="$1"
prefix="$2"

if [[ "$mode" != "--dry-run" && "$mode" != "--remove" ]]; then
  usage
fi

echo "Searching for S3 buckets with prefix '$prefix'...\n"

buckets=$(aws s3api list-buckets --query "Buckets[?starts_with(Name, '${prefix}')].Name" --output text)

if [[ -z "$buckets" ]]; then
  echo "(no matching buckets)"
  exit 0
fi

if [[ "$mode" == "--dry-run" ]]; then
  echo "Buckets that would be removed:"
  echo "$buckets" | tr '\t' '\n'
elif [[ "$mode" == "--remove" ]]; then
  echo "$buckets" | tr '\t' '\n' | while IFS= read -r bucket; do
    if [[ -n "$bucket" ]]; then
      echo "Emptying objects: s3://$bucket"
      aws s3 rm "s3://$bucket" --recursive 2>/dev/null

      echo "Removing versioned objects and delete markers: s3://$bucket"
      versions=$(aws s3api list-object-versions --bucket "$bucket" --output json 2>/dev/null)

      # Delete versioned objects
      objects=$(echo "$versions" | jq -c '{Objects: [.Versions[]? | {Key: .Key, VersionId: .VersionId}], Quiet: true}' 2>/dev/null)
      if [[ "$objects" != '{"Objects":[],"Quiet":true}' && -n "$objects" ]]; then
        aws s3api delete-objects --bucket "$bucket" --delete "$objects" >/dev/null 2>&1
      fi

      # Delete markers
      markers=$(echo "$versions" | jq -c '{Objects: [.DeleteMarkers[]? | {Key: .Key, VersionId: .VersionId}], Quiet: true}' 2>/dev/null)
      if [[ "$markers" != '{"Objects":[],"Quiet":true}' && -n "$markers" ]]; then
        aws s3api delete-objects --bucket "$bucket" --delete "$markers" >/dev/null 2>&1
      fi

      echo "Deleting bucket: s3://$bucket"
      aws s3api delete-bucket --bucket "$bucket" 2>/dev/null
      if [[ $? -eq 0 ]]; then
        echo "Removed: $bucket"
      else
        echo "Failed to remove: $bucket"
      fi
    fi
  done
fi
