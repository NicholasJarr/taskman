#!/bin/bash

set -euo pipefail

db=$1

IFS=$'\n\t'

sqlite3 -list -separator ' - ' $db $'
  select t.id, t.name, string_agg(tg.name, \',\')
  from tasks t
  left join tasks_tags tt on tt.task_id = t.id
  left join tags tg on tg.id = tt.tag_id
  where done_at is null
  group by t.id, t.name
  order by created_at desc;'