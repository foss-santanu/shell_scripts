#!/bin/bash
#bash script to create a blank script file with execution permission
#created by Santanu Chakrabarti
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
#save the script in bin directory of user's home
if [ -d ~/bin ]; then
cd ~/bin
else
mkdir ~/bin
cd ~/bin
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
ln -s $filename $linkname
gedit $filename
exit 0
