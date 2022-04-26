#!/bin/bash

set -e

ruby -run -e httpd -- -p 0 . | while read -r line; do
  echo "$line"
done
