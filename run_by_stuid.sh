#! /bin/bash 

if [ $# -lt 1 ]; then
    echo "Usage:"
    echo "$0 [student id] [delay deadline (optional)]"
    echo ""
    echo "./run_by_stuid.sh b01999001"
    echo "or    ./run_by_stuid.sh b01999001 \"2016-01-01 00:00:00\""
    echo ""
    echo "Description:"
    echo "    Run by student id"
    echo "    If you don't give the delay deadline, it will NOT pull anything from github."
    echo "    On the other hand, if you give the delay deadline, it will remove the original student's code, pull it again and checkout to the latest commit before delay deadline."
    echo ""
    exit
fi

stu_id=$1 # stu_id must be above config

. config
. program_config

if [ "$2" != "" ]; then
    git_pull=true
    delay_time="$2"
else
    git_pull=false
    delay_time=""
fi

repo_name=`grep ${stu_id,,} $course/$hw/git_list/all_list | cut -d',' -f 2,2`

echo "student id: $stu_id"
echo "repo name: $repo_name"
echo "============================================================================="

echo
echo

./grade.sh ${stu_id,,} $repo_name $git_pull "$delay_time"

cd $save_dir/$course/$hw/code/${stu_id,,}
[ -d $hw ] && cd $hw 
[ -d ${hw,,} ] && cd ${hw,,}

echo "=============================Error for run.sh============================="
cat $save_dir/$course/$hw/err/${stu_id,,}

echo
echo

echo "=============================Error for eval.sh============================="
cat $save_dir/$course/$hw/err2/${stu_id,,}

echo
echo
