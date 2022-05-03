#!/bin/bash

set -e

ruby -run -e httpd -- -p 0 . | while read -r line; do
  echo "$line"
  if [[ $line =~ port=([0-9]+)$ ]]; then
    port="${BASH_REMATCH[1]}"
    echo "$port"
  fi
done
