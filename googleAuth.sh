#!/bin/bash
#created by Santanu Chakrabarti
#created on 17/11/2011
#Start script code ----
#default google service
service='calendar'
case $# in
2|3) #username, password and [service] as commandline arguments
for arg in "$@"
do
case $arg in
--user=*) #get the username
user=`echo $arg | sed 's/--user=//'`
;;
--passwd=*) #get the password
passwd=`echo $arg | sed 's/--passwd=//'`
;;
--service=*) #get the password
service=`echo $arg | sed 's/--service=//'`
;;
*) #Unknown commandline arguments
echo "googleAuth: Improper commandline arguments..."
echo "Usage: googleAuth --user=<username> --passwd=<password> [--service=<service>]"
exit 0
;;
esac
done
;;
*) #no proper commandline arguments
echo "googleAuth: Improper commandline arguments..."
echo "Usage: googleAuth --user=<username> --passwd=<password> [--service=<service>]"
exit 0
;;
esac

gsrvc=`cat "$HOME/shellSrc/.config/gservices.list" | sed 's/#.*//' | grep $service | sed "s/$service=//"`
httpbody="accountType=GOOGLE&Email=$user&Passwd=$passwd&service=$gsrvc&source=gcalendar_curl_client"
command="curl -d '$httpbody' https://www.google.com/accounts/ClientLogin --silent"
#echo $command ##-- for test purpose
exec $command | grep Auth | sed 's/Auth=//'
#----End script code
