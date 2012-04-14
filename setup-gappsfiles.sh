VENDOR=google
OUTDIR=vendor/$VENDOR
MAKEFILE=../../../$OUTDIR/gapps.mk

(cat << EOF) > $MAKEFILE
# Copyright (C) 2012 The OpenSensation Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Gapps Versioning
PRODUCT_PROPERTY_OVERRIDES += \\
ro.addon.type=gapps \\
ro.addon.platform=ICS \\
ro.addon.version=gapps-ics-20120317

PRODUCT_COPY_FILES += \\
EOF

LINEEND=" \\"
COUNT=`wc -l gapps-files.txt | awk {'print $1'}`
DISM=`egrep -c '(^#|^$)' gapps-files.txt`
COUNT=`expr $COUNT - $DISM`
for FILE in `egrep -v '(^#|^$)' gapps-files.txt`; do
  COUNT=`expr $COUNT - 1`
  if [ $COUNT = "0" ]; then
    LINEEND=""
  fi
  echo "  $OUTDIR/prebuilt/$FILE:system/$FILE$LINEEND" >> $MAKEFILE
done
