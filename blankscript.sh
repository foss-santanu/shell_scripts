#!/bin/bash
#bash script to create a blank script file with execution permission
#created by Santanu Chakrabarti
#default script src directory
srcdir="$HOME/shellSrc"
if [ -z $1 ]; then
echo "blankscript: Script file name not entered"
echo "Run blankscript <filename>"
exit 0
fi
#check for .sh extension in file name
if [ -n "`echo $1 | grep .sh`" ]; then
filename=$1
else
filename=$1.sh
fi
echo "blankscript: Creating bash script $filename..."
#save the script in src directory
if [ -d $srcdir ]; then
cd $srcdir
else
mkdir $srcdir
cd $srcdir
fi
#write the basic template to the script file
cat > $filename <<EOF
#!/bin/bash
#created by Santanu Chakrabarti
#created on `date +%d/%m/%Y`
#Start script code ----

#----End script code
EOF
#make the script file executable
chmod uga+x,g-w $filename
linkname=`echo $filename | sed 's/.sh//'`
cd $HOME   #workaround to avoid creating broken link
#create an executable link in $HOME/bin directory
if [ ! -d $HOME/bin ]; then
mkdir $HOME/bin
fi
ln -s $srcdir/$filename $HOME/bin/$linkname
#open the script file for edit
gedit $srcdir/$filename
exit 0
