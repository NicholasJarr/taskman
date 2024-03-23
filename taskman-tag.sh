#!/bin/bash

set -euo pipefail

db=$1
task_id=$2
args=("$@")

if [[ -z $(sqlite3 $db "select id from tasks where id = $task_id;") ]]; then
  echo "Bad task"
  exit 1
fi

tags=$(sqlite3 -list $db "select string_agg(tg.name,',') from tasks_tags tt inner join tags tg on tg.id = tt.tag_id where tt.task_id = $task_id;")

read -e -p "Tags: " -i "$tags" new_tags

IFS=$','
new_tag_values=()
for t in $new_tags
do
  tag_id=$(sqlite3 $db "select id from tags where name = '$t';")
  if [[ -z $tag_id ]]; then
    tag_id=$(sqlite3 $db "insert into tags (name) values ('$t') returning id;")
  fi
  new_tag_values=("${new_tag_values[@]}" "($task_id,$tag_id)")
done

sqlite3 $db "delete from tasks_tags where task_id=$task_id;"
sqlite3 $db "insert into tasks_tags (task_id,tag_id) values ${new_tag_values[*]};"

IFS=$'\n\t'