#!/bin/bash
#created by Santanu Chakrabarti
#created on 07/04/2015
#Start script code ----
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
tasks=`gradle tasks`
## check if task clojureRepl exists then run it
if [ "${tasks/clojureRepl}" != "$tasks" ]; then
gradle clojureRepl
else
echo "No task to run REPL found"
fi
fi
cd $cwd
#----End script code
