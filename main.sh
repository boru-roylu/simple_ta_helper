#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage:"
    echo "$0 [git repo list] [git_pull_or_not]"
    echo ""
    echo "Description:"
    echo "    Run by git repo list."
    echo "    If you want to remove old directories and re-clone, [git_pull_or_not] is true."
    exit
fi

. config

stu_git_list=$1
git_pull_bool=$2

cat $stu_git_list | awk -F"," '{ print $1,$2 }' | parallel --gnu --progress -j $threads bash grade.sh \{\} $git_pull_bool

