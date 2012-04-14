#!/bin/sh

BASE=../../../vendor/google/prebuilt
rm -rf $BASE/*

for FILE in `egrep -v '(^#|^$)' gapps-files.txt`; do
  DIR=`dirname $FILE`
  if [ ! -d $BASE/$DIR ]; then
    mkdir -p $BASE/$DIR
  fi
  adb pull /system/$FILE $BASE/$FILE
done

./setup-gappsfiles.sh
