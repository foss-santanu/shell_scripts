#!/bin/bash
#created by Santanu Chakrabarti
#created on 07/04/2015
#Start script code ----

## function to run nrepl/repl
run_gradle () {
    tasks=`gradle tasks`
    ## lookup for the gradle task
    if [ "${tasks/$1}" != "$tasks" ]; then
    gradle $1
    else
    echo "No task to run REPL found"
    exit 1
    fi
}

cwd=`pwd`
rundir=$cwd
until [ -e "$rundir/build.gradle" ]
## find the directory containing build.gradle file
do
if [ $rundir == "/" ]; then
## reached root directory, take .cljrepl.d as rundir
rundir="$HOME/.cljrepl.d"
break
fi
## go to the parent directory
cd ..
rundir=`pwd`
done

if [ ! -e $rundir ]; then
echo "cljrepl not properly installed: .cljrepl.d missing"
exit 1
else
cd $rundir
run_gradle $1
fi
cd $cwd
#----End script code
