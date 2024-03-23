#!/bin/bash

set -euo pipefail

editor_pipe() {
  TMPFILE=`mktemp /tmp/editor_pipe.bashXXXXXXXX.md`
  cat > ${TMPFILE}
  ${EDITOR} ${TMPFILE} < /dev/tty > /dev/tty
  cat ${TMPFILE}
  rm ${TMPFILE}
}

db=$1
task_id=$2
args=("$@")

if [[ -z $(sqlite3 $db "select id from tasks where id = $task_id;") ]]; then
  echo "Bad task"
  exit 1
fi

description=$(sqlite3 -list $db "select description from tasks where id = $task_id;")

new_description=$(echo $description | editor_pipe)

sqlite3 $db "update tasks set description='$new_description' where id = $task_id;"

IFS=$'\n\t'