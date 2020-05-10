#!/usr/bin/env bash

set -e

THISDIR=`dirname $0`; THISDIR=`cd $THISDIR;pwd`
THISDIRNAME=`basename $THISDIR`
BASEDIR="$THISDIR/../.."

## load common vars
. $BASEDIR/common/scripts/build_common.sh

### current dir vars
THIS_ANSIBLE=$THISDIR/$THIS_ANSIBLE_DIRNAME
THIS_CCE=$THISDIR/$THIS_CCE_DIRNAME

### common build vars
BUILD_DIR="$BASEDIR/$BUILD_DIRNAME"
BUILD_ANSIBLE="$BUILD_DIR/$BUILD_ANSIBLE_DIRNAME"
BUILD_CCE="$BUILD_DIR/$BUILD_CCE_DIRNAME"

## project name defaults to current dirname
PROJECT_NAME="$THISDIRNAME"

##copy ansible playbooks
if [ -d $THIS_ANSIBLE ]; then
    if [ ! -d $BUILD_ANSIBLE ]; then
        mkdir -p $BUILD_ANSIBLE
    fi
    copyfiles $THIS_ANSIBLE $BUILD_ANSIBLE $PROJECT_NAME
fi

##copy ansible vars
if [ -d $THIS_ANSIBLE/vars ]; then
    if [ ! -d $BUILD_ANSIBLE/vars ]; then
        mkdir -p $BUILD_ANSIBLE/vars
    fi 
    copyfiles $THIS_ANSIBLE/vars $BUILD_ANSIBLE/vars $PROJECT_NAME
fi

##copy ansible inventories
if [ -d $THIS_ANSIBLE/inventory ]; then
    if [ ! -d $BUILD_ANSIBLE/inventory ]; then
        mkdir -p $BUILD_ANSIBLE/inventory
    fi 
    
    ##copy + replace tokens in the inventory file
    copyfiles $THIS_ANSIBLE/inventory $BUILD_ANSIBLE/inventory $PROJECT_NAME
fi

##copy webmethods CCE content
if [ -d $THIS_CCE/environments ]; then
    if [ ! -d $BUILD_CCE/environments ]; then
        mkdir -p $BUILD_CCE/environments
    fi 
    copyfiles $THIS_CCE/environments $BUILD_CCE/environments $PROJECT_NAME
fi

##copy webmethods templates
if [ -d $THIS_CCE/templates ]; then
    if [ ! -d $BUILD_CCE/templates/$PROJECT_NAME ]; then
        mkdir -p $BUILD_CCE/templates/$PROJECT_NAME
    fi 
    cp -r $THIS_CCE/templates/* $BUILD_CCE/templates/$PROJECT_NAME/
fi