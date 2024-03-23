#!/bin/bash

set -euo pipefail

db=$1
task_id=$2
args=("$@")

if [[ -z $(sqlite3 $db "select id from tasks where id = $task_id;") ]]; then
  echo "Bad task"
  exit 1
fi

echo $(sqlite3 -list $db "select description from tasks where id = $task_id;")

IFS=$'\n\t'