#!/bin/sh

if [ ! $# -eq 1 ]
then
	echo "usage: rename.sh [dir]" 1>&2
	exit 1
fi

if [ -d $1 ]
then
	#for doc in `ls $1 | sed 's/\s/_/g'`
	#$doc=`ls $1 | sed 's/_/\s/g'`
	#for file in `ls $1`
	#do
	#newname=`echo $file | sed 's/\s+/_/g'`
	#mv $file $newname
	#echo $newname
	#done
	for entry in "$1"/*
	do
		#loc=`pwd`
 		#echo "$entry"
 		route=`dirname "$entry"`
		oldname=`basename "$entry"`
 		newname=`echo $oldname | sed "s/\s/_/g"`
 		#cd $route
 		if [ "$oldname" != "$newname" ]
 		then
 			mv "$route/$oldname" $route/$newname
 		fi
 		#cd $loc
	done
else
	echo "$1 is not a directory" 1>&2
	exit 1
fi
