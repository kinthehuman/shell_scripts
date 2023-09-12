#!/usr/bin/sh

if [ $# !-eq 1 ]
then
echo "INTRODUZCA 1 PARAMETRO" 0>&1
exit 1
fi

for fichero in `ls $1|grep ".txt"|sort`
do
l1=`echo $fichero|cut -c1|tr '[A-Z]' '[a-z]'`
	if [ -f "$l1.output" ]
	then
	rm -f "$1/$l1.output"
	fi
touch "$1/$l1.output"
done

for fichero in `ls $1|grep ".txt"|sort`
do
l1=`echo $fichero|cut -c1|tr '[A-Z]' '[a-z]'`
cat "$1/$fichero" >> "$1/$l1.output"
done
