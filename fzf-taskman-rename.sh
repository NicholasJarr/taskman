#!/bin/bash

set -euo pipefail

db=$1

IFS=$'\n\t'

task_id=$(./fzf-taskman-query.sh $1 | awk -F' ' '{print $1}')

./taskman-rename.sh $1 $task_id