#!/usr/bin/sh

if [ $# -gt 1 ]
then

	echo "ERROR(usage): newdown[N]" 1>&2
	exit 2
	
fi


if [ $# -eq 1 ]
then
	N=$1
else
	N=1
fi

find /home/$USER/Downloads -type f -ctime -$N -printf "%T@ %p\n" | sort -n -r | head -3 | cut -d ' ' -f2
