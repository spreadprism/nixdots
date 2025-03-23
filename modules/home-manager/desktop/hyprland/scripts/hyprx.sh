#! /usr/bin/sh

set -e # exit on error


function main
{
  hyprctl_check
}

function hyprctl_check
{
  # check if hyprctl exists
  if ! command -v hyprctl &> /dev/null
  then
    echo "hyprctl could not be found"
    exit 1
  fi
}


main "$@";
