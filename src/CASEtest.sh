#!/usr/bin/env bash
xD=""

if [ -z "$xD" ]; then
  echo "Error: xD is empty"
else
  case "$xD" in
    $1)
      echo "1"
      ;;
    $2)
      echo "2"
      ;;
    *)
      echo "3"
      ;;
  esac
fi

