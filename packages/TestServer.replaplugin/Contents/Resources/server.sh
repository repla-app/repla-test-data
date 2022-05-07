#!/bin/bash

set -e

title="false"
while getopts ":p:th" option; do
  case "$option" in
    p)
      file_path="$OPTARG"
      ;;
    t)
      title="true"
      ;;
    h)
      echo "Usage: command [-hf] [-p <file_path>]"
      exit 0
      ;;
    :)
      echo "Option -OPTARG requires an argument" >&2
      exit 1
      ;;
    \?)
      echo "Invalid option: -OPTARG" >&2
      exit 1
      ;;
  esac
done

ruby -run -e httpd -- -p 0 . 2>&1 | while read -r line; do
  echo "$line"
  if [[ "$title" == "true" ]]; then
    if [[ $line =~ port=([0-9]+)$ ]]; then
      port="${BASH_REMATCH[1]}"
      osascript -e "tell application \"Repla\" to do JavaScript \"document.title = '$port'\" in window 1"
    fi
  fi
done
