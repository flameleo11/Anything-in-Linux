#!/bin/bash

function sound() {
  local dir="/drive_d/me/Music/effect/notifications"
  local wav="$1"

  # set $1 default
  if [ -z "$1" ]; then
    # 'Soft delay.ogg'
    # Amsterdam.ogg
    # Blip.ogg
    # Mallet.ogg
    # Positive.ogg
    # Rhodes.ogg
    # Slick.ogg
    # Xylo.ogg
    wav="Positive.ogg"
  fi

  # echo paplay $dir/$wav
  paplay $dir/$wav
}


function msgbox() {
  gxmessage "args:
  1 "$1"
  2 "$2"
  3 $3
  4 $4
  5 $5
  6 $6
  7 $7";
}


# msgbox "$@"
sudo updatedb