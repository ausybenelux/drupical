#!/bin/sh
SRC=/vagrant/drupal/sites/all
DST=/vagrant_nfs/drupal/sites/

inotifywait -mrq --timefmt '%d/%m/%y %H:%M' --format  '%T %w%f' -e create,move,delete,modify ${SRC} | while read file
do
  rsync -av --no-o --no-g --delete --progress ${SRC} ${DST}
done
