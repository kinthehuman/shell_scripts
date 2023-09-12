#!/usr/bin/sh

if [ $# -lt 1 ] || [ $# -gt 2 ]
then

	echo "ERROR(usage): findbig.sh N [user]" 1>&2
	exit 2
	
fi


if [ $# -eq 2 ]
then
	user=$2
else
	user=`whoami`
fi


for input in `find /home/$user -type f -printf '%s %p\n' | sort -nr | head -$1 | cut -d ' ' -f2`
do

	echo "${input##*/}"

done
exit 1
