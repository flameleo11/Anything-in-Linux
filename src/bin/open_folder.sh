#!/bin/bash

function msgbox() {
  gxmessage "args:
  1 $1
  2 $2
  3 $3
  4 $4
  5 $5
  6 $6
  7 $7";
}

function open_folder() {
  # msgbox "$*"
  local dir=`dirname "$*"`
  xdg-open "$dir"
  # msgbox "$*" "$dir"
}


open_folder "$*"