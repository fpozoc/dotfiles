# UNIX utils
pdate (){
  date +"%Y%m%dT%H%M"
}

## count over files content
alias wcf='for i in $(ls *); do echo "$i -> $(zcat $i wc)"; done'

## Make and change directory at once
alias mkcd='_(){ mkdir -p $1; cd $1; }; _'

## Fast find
alias ff='find . -name $1'

# bioinformatics utils
gtf2bed () {
  awk '{if($3 != "gene") print $0}' $1 | grep -v "^#" | gtfToGenePred /dev/stdin /dev/stdout | genePredToBed stdin $2
}

# general utils
## as suggested by Mendel Cooper in "Advanced Bash Scripting Guide"
extract () {
   if [ -f $1 ] ; then
       case $1 in
        *.tar.bz2)      tar xvjf $1 ;;
        *.tar.gz)       tar xvzf $1 ;;
        *.tar.xz)       tar Jxvf $1 ;;
        *.bz2)          bunzip2 $1 ;;
        *.rar)          unrar x $1 ;;
        *.gz)           gunzip $1 ;;
        *.tar)          tar xvf $1 ;;
        *.tbz2)         tar xvjf $1 ;;
        *.tgz)          tar xvzf $1 ;;
        *.zip)          unzip $1 ;;
        *.Z)            uncompress $1 ;;
        *.7z)           7z x $1 ;;
        *)              echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
}


# cheatsheet
cht() {•
curl "http://cht.sh/$1";•
}

# python utils
alias ver="pip list | grep -i $1"

# lsd https://github.com/Peltoche/lsd
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

# nf-core
alias nf-core="docker run -itv `pwd`:`pwd` -w `pwd` -u $(id -u):$(id -g) nfcore/tools"

# visidata https://github.com/saulpw/visidata
vg (){
  zmore $1 | { head -1; grep $2;} | vd
}

# SLURM functions and aliases
alias si="sinfo -o '%8P %10n %.11T %.4c %.8z %.6m %12G %10l %10L %10O %20E' -S '-P'"
alias sq="squeue -Su -o '%8i %10u %20j %4t %5D %20R %15b %3C %7m %11l %11L'"
alias squ="sq -u `id -un`"
alias sst='sstat --format=JobID,NTasks,AveCPU,AveCPUFreq,AveRSS,MaxRSS -j'

function summarize-user {
    check_time=$(date +%Y-%m-%d -d "7 days ago")
    sacct -S $check_time -u $1 --format=User,Account,Jobname,elapsed,ncpus,AllocTRES
}

function my-jobs {
    squeue -u $USER;
}

function view-out {
  less -S $HOME/slurm/out/*_${1}.out;
}

function view-err {
    less -S $HOME/slurm/out/*_${1}.err;
}


function get-research {
  srun -p main -n 1 --mem 64G  --time 4-00:00:00 --pty /bin/zsh
}

# function jupyter-launch {
    # ssh -N -f -R 0.0.0.0:1617:localhost:8887 USER@SERVER
    # jupyter-lab --no-browser --ip localhost --port 1618 &> /tmp/error.log &
    # mkdir /tmp/$USER;
# }