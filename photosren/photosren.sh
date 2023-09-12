#!/usr/bin/sh

if [ $# -lt 1 ]
then
echo "PARAMETROS INSUFICIENTES" 0>&1
exit 1
fi

day=`date|cut -d' ' -f3`
month=`date|cut -d' ' -f2`
year=`date|cut -d' ' -f6`
nombre_dir=`echo "$day"_"$month"_"$year"`

mkdir $1/$nombre_dir

max_char=`find $1 -name '*' -exec file {} \; | grep -o -P '^.+: \w+ image'|wc -l|wc -c`

num=1

for image in `find $1 -name '*' -exec file {} \; | grep -o -P '^.+: \w+ image'|cut -d ':' -f1`
do
nombre=`echo "$num"`
num_char=`echo $nombre|wc -c`
dif_char=`expr $max_char - $num_char`
	for n in $(seq 1 $dif_char)
	do
	nombre="0$nombre"
	done
num=`expr $num + 1`
extension=`echo $image|cut -d'.' -f2`	#no funciona si hay caracteres especiales en los nombres de los directorios o archivos
nombre="$nombre.$extension"
mv $image $1/$nombre_dir/$nombre
done
