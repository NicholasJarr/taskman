#!/bin/bash

set -euo pipefail

db=$1
args=("$@")
name="${args[@]:1}"

IFS=$'\n\t'

if [[ -z $(sqlite3 $db "select id from tags where name = '#inbox';") ]]; then
  sqlite3 $db "insert into tags (name) values ('#inbox');"
fi

tag_id=$(sqlite3 $db "select id from tags where name = '#inbox';")
task_id=$(sqlite3 $db "insert into tasks (name,created_at) values ('$name', datetime()) returning id;")
sqlite3 $db "insert into tasks_tags (task_id,tag_id) values ($task_id, $tag_id);"

echo $task_id
