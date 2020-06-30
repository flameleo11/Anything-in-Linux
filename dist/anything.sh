#!/bin/bash

function main() {
  local path="/drive_d/work/Everthing/dist/Anything in Linux"
  local dir=`dirname "$path"`
  local fname=`basename "$path"`
  pushd "$dir"
  GTK_THEME=Arc "$path" -n "$@"
  popd
}

# msgbox "@*" &
# sound&

main "$@"

