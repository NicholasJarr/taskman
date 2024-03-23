#!/bin/bash

set -euo pipefail

db=$1

IFS=$'\n\t'

sqlite3 $db 'create table tasks (id integer primary key, name, description, created_at, done_at);'
sqlite3 $db 'create table tags (id integer primary key, name);'
sqlite3 $db 'create table tasks_tags (task_id, tag_id);'
