#!/usr/bin/env bash

THISDIR=`dirname $0`; THISDIR=`cd $THISDIR;pwd`
THISDIRNAME=`basename $THISDIR`
BASEDIR="$THISDIR/.."

## load common vars
. $BASEDIR/common/scripts/build_common.sh

BUILD_DIR="$BASEDIR/$BUILD_DIRNAME"
SCRIPTS_DIR="$THISDIR/$THIS_SCRIPTS_DIRNAME"

##check if the build directory exists
if [ ! -d $BUILD_DIR ]; then
    echo "Directory $BUILD_DIR does not exist. Make sure you called the main build.sh script at the root of this project"
    exit 2
fi

### copy various helper scripts
if [ -d $SCRIPTS_DIR ]; then
    if [ ! -d $BUILD_DIR/scripts ]; then
        mkdir -p $BUILD_DIR/scripts
    fi
    rsync -arvz --delete $SCRIPTS_DIR/ $BUILD_DIR/scripts/
fi

### copy the sync-to-management script on the bastion
if [ -f $THISDIR/sync-to-management.sh ]; then
    cp $THISDIR/sync-to-management.sh $BUILD_DIR/
fi

### build the sub stacks
for f in $THISDIR/stacks/*; do
    if [ -d "$f" ]; then
        if [ -f $f/build.sh ]; then
            /bin/bash $f/build.sh
        fi
    fi
done