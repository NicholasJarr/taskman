#!/bin/bash

set -euo pipefail

taskman_dir=${TASKMAN_HOME:-.}
db=$1

IFS=$'\n\t'

$taskman_dir/taskman-query.sh $1 | fzf --preview $'echo {} | awk -F\' \' \'{print $1}\' | xargs $taskman_dir/taskman-desc.sh taskman.db'
