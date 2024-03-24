#!/bin/bash

set -euo pipefail

taskman_dir=${TASKMAN_HOME:-.}
db=$1

IFS=$'\n\t'

task_id=$($taskman_dir/fzf-taskman-query.sh $1 | awk -F' ' '{print $1}')

$taskman_dir/taskman-done.sh $1 $task_id
