#!/bin/bash

set -euo pipefail

db=$1

IFS=$'\n\t'

./taskman-query.sh $1 | fzf --preview $'echo {} | awk -F\' \' \'{print $1}\' | xargs ./taskman-desc.sh taskman.db'