#! /bin/bash

. config
IFS="\n"
echo "`grep "Error" $course/$hw/err/* | sort -u`"
