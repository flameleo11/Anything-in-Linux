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

function print() {
  # echo $*
  return 0
}

# vala  "-v svg$" for gn grep
function fs_multi() {
  local args="$@"
  # msgbox total: "$@"  len: ${#text}

  if [ -z "$2" ]; then
    # msgbox 111 $1 $2 $3
    fs_main $1
  elif [ -z "$3" ]; then
    # msgbox 222 "$1" "$2" "$3"
    fs_main $1 |g $2
  elif [ -z "$4" ]; then
    fs_main $1 |g $2 |g $3
  elif [ -z "$5" ]; then
    fs_main $1 |g $2 |g $3 |g $4
  elif [ -z "$6" ]; then
    fs_main $1 |g $2 |g $3 |g $4 |g $5
  elif [ -z "$7" ]; then
    fs_main $1 |g $2 |g $3 |g $4 |g $5 |g $6
  elif [ -z "$8" ]; then
    fs_main $1 |g $2 |g $3 |g $4 |g $5 |g $6 |g $7
  elif [ -z "$9" ]; then
    fs_main $1 |g $2 |g $3 |g $4 |g $5 |g $6 |g $7 |g $8
  fi
}

function main() {
  local text="$*"
  # msgbox total: "$@"  len: ${#text}
  # msgbox "$@" "$1" "$2" "$3" "$*"
  
  if [ -z "$1" ]; then
    sudo updatedb
    return 0
  fi

  # if [ ${#text} -le 2 ]; then
  #   fs_multi "$@" | uniq | head -n 30
  # else
  #   fs_multi "$@" | uniq | head -n 60
  # fi

  if [ ${#text} -le 2 ]; then
    fs_multi "$@" | head -n 100
  else
    fs_multi "$@" | head -n 200
  fi


  # if [ ${#text} -le 2 ]; then
  #   fs_multi "$@" | uniq | head -n 1000
  # else
  #   fs_multi "$@" | uniq | head -n 2000
  # fi


  return 0
}

function fs_main() {
  locate -i -e "$*"
}

function g() {
  grep -i --null --color=never $*
}

# msgbox "$@"
# main $*
main "$@"
