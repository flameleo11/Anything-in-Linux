#!/bin/bash

# todo copy res folder to dist
# cp res


# --pkg lua
valac --disable-warnings --fatal-warnings \
 --pkg gtk+-3.0 --pkg gee-0.8 \
 --pkg posix \
 util.vala \
 child_process.vala \
 EventEmitter.vala \
 MainWindow.vala \
 MainHeaderBar.vala \
 MainMenu.vala \
 SearchGrid.vala \
 ViewGrid.vala \
 ListView.vala \
 ListViewColumn.vala \
 StatusGrid.vala \
 SearchEngine.vala \
 FileProps.vala \
 main.vala \
 -o "../dist/anything" && "../dist/anything"

 # Application.vala \
 # util.vala app.vala main.vala \
# --pkg glib-2.0
# util.vala main.vala \
