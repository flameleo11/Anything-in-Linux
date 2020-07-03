#!/bin/bash

function main() {
  local path="/drive_d/work/Everthing/dist/anything-1.30"
  local dir=`dirname "$path"`
  local fname=`basename "$path"`
  pushd "$dir"
  GTK_THEME=Arc "$path" -n "$@"
  popd
}

# msgbox "@*" &
# sound&

main "$@"

