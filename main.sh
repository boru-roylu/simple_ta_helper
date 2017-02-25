#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage:"
    echo "$0 [git repo list]"
    echo ""
    echo "Description:"
    echo "    Run by git repo list."
    exit
fi

. config

stu_git_list=$1

cat $stu_git_list | awk -F"," '{ print $1,$2 }' | parallel --gnu --progress -j $threads bash grade.sh \{\} true
