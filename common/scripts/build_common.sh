#!/usr/bin/env bash

THIS_ANSIBLE_DIRNAME="ansible"
THIS_CCE_DIRNAME="cce"
THIS_SCRIPTS_DIRNAME="scripts"

COMMON_DIRNAME="common"
COMMON_ANSIBLE_DIRNAME="webmethods-ansible"
COMMON_SAGCCE_DIRNAME="webmethods-cce"

BUILD_DIRNAME="build"
BUILD_ANSIBLE_DIRNAME=$COMMON_ANSIBLE_DIRNAME
BUILD_CCE_DIRNAME=$COMMON_SAGCCE_DIRNAME

## stack token for replacement
STACK_TOKEN="@stack_name@"

function copyfiles { 
    local sourcedir=$1;
    local targetdir=$2;
    local targetfileprefix=$3; 
    local sedreplace="s/$STACK_TOKEN/$targetfileprefix/g"; 

    ### build the sub stacks
    for filepath in $sourcedir/*; do
        if [ -f "$filepath" ]; then
            filename=`basename $filepath`
            if [ "x" != "x$sedreplace" ]; then
                echo "sed '$sedreplace' $filepath > $targetdir/$targetfileprefix-$filename"
                sed $sedreplace $filepath > $targetdir/$targetfileprefix-$filename
            else
                cp $filepath $targetdir/$targetfileprefix-$filename
            fi
        fi
    done
}