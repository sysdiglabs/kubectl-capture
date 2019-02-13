#!/bin/bash

set -eo

echo "* Setting up /usr/src links from host"

for i in $(ls $SYSDIG_HOST_ROOT/usr/src)
do
        ln -s $SYSDIG_HOST_ROOT/usr/src/$i /usr/src/$i
done

/usr/bin/sysdig-probe-loader

echo "* Capturing system calls"
sysdig -S -M $CAPTURE_DURATION -pk -z -w /captures/$CAPTURE_FILE_NAME.scap.gz

touch /captures/.finished

trap 'exit 0' TERM
sleep infinity & wait $!
