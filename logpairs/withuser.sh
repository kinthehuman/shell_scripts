#!/usr/bin/sh

#revision de parametros
if [ ! $# -eq 1 ]
then
echo "ESTE PROGRAMA SOLO ACEPTA 1 PARAMETRO" 0>&1
fi

ubicacion=`pwd`

#por cada posible usuario se comprueba si es una pareja, en cuyo caso se prepara e imprime una salida
for usuario in `cat /etc/passwd | cut -d ":" -f1 | grep -v $1`
do
cat $ubicacion/userpairs.txt | grep $1 | grep $usuario > /dev/null 2>&1
if [ $? -eq 0 ]
then
salida=`echo "$usuario"`
	#todas las fechas en las que han sido pareja se añaden detras del nombre de usuario con el que ha sido pareja
	for fecha in `cat $ubicacion/userpairs.txt | grep $1 | grep $usuario | cut -d " " -f3`
	do
	salida=`echo "$salida" "$fecha"`
	done

echo "$salida"
fi
done
