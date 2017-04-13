#! /bin/bash

. config

if [ $# -ne 2 ]; then
    echo "Usage:"
    echo "$0 [list] [leaderboard score list]"
    echo ""
    echo "Description:"
    echo "    The program will give you a list to announce the final result of this homework."
    echo "    It will check the student's score in the score directory, respectively."
    echo "    Remember to design your own check_kaggle.py"
    echo ""
    exit 1;
fi

# TODO
# You can edit this header.
header = "student_id,reproduced,pub_sim_bl,pub_str_bl,pri_sim_bl,pri_str_bl,error_message"

stu_git_list=$1
leaderboard_score_list=$2

err_mesg=`mktemp`
trap "rm -f $err_mesg" EXIT

./get_err_mesg.sh > $err_mesg

announcement=$course/$hw/announcement.csv
[ -f  $announcement ] || rm -f $announcement

echo $header > $announcement

while read line
do
    stu_id=`echo $line | cut -d ',' -f 1`
    repo_name=`echo $line | cut -d ',' -f 2`

    mesg="`grep $stu_id $err_mesg | cut -d ':' -f 2,3 | tr -d '\n'`"
    
    score=$(python check_kaggle.py "`grep $stu_id $leaderboard_score_list`" $course/$hw/score/$stu_id)

    echo "$stu_id,$score,\"$mesg\"" >> $announcement

done < $stu_git_list
