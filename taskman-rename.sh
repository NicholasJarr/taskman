#!/bin/bash

set -euo pipefail

db=$1
task_id=$2
args=("$@")

if [[ -z $(sqlite3 $db "select id from tasks where id = $task_id;") ]]; then
  echo "Bad task"
  exit 1
fi

name=$(sqlite3 -list $db "select name from tasks where id = $task_id;")

read -e -p "Name: " -i "$name" new_name

sqlite3 $db "update tasks set name='$new_name' where id = $task_id;"

IFS=$'\n\t'