#!/usr/bin/sh

if [ ! $# -eq 2 ] && [ ! $# -eq 3 ]
then
echo "INTRODUZCA 2 O 3 PARAMETROS" 0>&1
exit 1
fi

if [ ! -d $1 ]
then
echo "EL DIRECTORIO $1 NO EXISTE" 0>&1
exit 1
fi

while true
do

if [ $# -eq 3 ]
then
ls $1 | grep "$3" > /dev/null 2>&1
if [ $? -eq 0 ]
then
exit 0
fi
fi

if [ $# -eq 2 ]
then
ls $1 | grep "FINISH" > /dev/null 2>&1
if [ $? -eq 0 ]
then
exit 0
fi
fi

borrar=`mktemp`
for i in `find $1 -maxdepth 1 -type f -mmin +60 | grep ".done"`
do
echo $i >> $borrar
done

while IFS= read -r line
do
rm -f $line
done < $borrar


archivos=`mktemp`
for i in `find $1 -maxdepth 1 -type f | grep -v ".done"`
do
echo $i >> $archivos
done

while IFS= read -r line
do
$2 $line
mv $line $line.done
done < $archivos

rm -f $archivos
rm -f $borrar

sleep 10
done

