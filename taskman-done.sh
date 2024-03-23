#!/bin/bash

set -euo pipefail

db=$1
task_id=$2

if [[ -z $(sqlite3 $db "select id from tasks where id = $task_id;") ]]; then
  echo "Bad task"
  exit 1
fi

sqlite3 $db "update tasks set done_at=datetime() where id=$task_id;"

IFS=$'\n\t'