#!/usr/bin/env bash

set -e

THISDIR=`dirname $0`; THISDIR=`cd $THISDIR;pwd`
THISDIRNAME=`basename $THISDIR`
BASEDIR="$THISDIR"

## load common vars
. $BASEDIR/common/scripts/build_common.sh

### current dir vars
THIS_ANSIBLE=$THISDIR/$THIS_ANSIBLE_DIRNAME
THIS_CCE=$THISDIR/$THIS_CCE_DIRNAME

### common build vars
BUILD_DIR="$BASEDIR/$BUILD_DIRNAME"
BUILD_ANSIBLE="$BUILD_DIR/$BUILD_ANSIBLE_DIRNAME/"
BUILD_CCE="$BUILD_DIR/$BUILD_CCE_DIRNAME/"

COMMON_DIR="$BASEDIR/$COMMON_DIRNAME"
COMMON_ANSIBLE="$COMMON_DIR/$COMMON_ANSIBLE_DIRNAME/"
COMMON_SAGCCE="$COMMON_DIR/$COMMON_SAGCCE_DIRNAME/"

##create build directory if does not exist
if [ ! -d $BUILD_DIR ]; then
    mkdir -p $BUILD_DIR
fi

##First, cleanup + assemble build template
if [ -d $BUILD_DIR ]; then
    rm -Rf $BUILD_DIR/*
fi

rsync -arvz --exclude static_* --delete $COMMON_ANSIBLE $BUILD_ANSIBLE
rsync -arvz --exclude static_* --delete $COMMON_SAGCCE $BUILD_CCE

### copy the sync-to-management script on the bastion
if [ -f $THISDIR/sync-to-management.sh ]; then
    cp $THISDIR/sync-to-management.sh $BUILD_DIR/
fi

## then build sub projects
/bin/bash $BASEDIR/management/build.sh
/bin/bash $BASEDIR/stacks/build.sh