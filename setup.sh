. config

mkdir -p $save_dir/$course/$hw/score
mkdir -p $save_dir/$course/$hw/output
mkdir -p $save_dir/$course/$hw/git_list
mkdir -p $save_dir/$course/$hw/code
mkdir -p $save_dir/$course/$hw/kaggle
mkdir -p $save_dir/$course/$hw/data
mkdir -p $save_dir/$course/$hw/program
mkdir -p $save_dir/$course/$hw/log
mkdir -p $save_dir/$course/$hw/log2
mkdir -p $save_dir/$course/$hw/err
mkdir -p $save_dir/$course/$hw/err2

[ -f ./$course ] && rm -f ./$course

[ -f ./$course ] || ln -s $save_dir/$course
