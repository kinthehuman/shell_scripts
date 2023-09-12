#!/usr/bin/sh

renombrar()
{
nombre=`echo $1|cut -d'.' -f1`
if [ $1 != $nombre ]
then
mv $1 $nombre
fi
mv $nombre $nombre.$2
}

if [ $# -lt 1 ] || [ $# -gt 2 ] #Revisión de parámetros
then
echo "NUMERO DE PARAMETROS INCORRECTO, NUMEROS DE PARAMETROS ACEPTABLES: 1 O 2" 0>&1
exit 1
fi

directorios=`find $1 -type "d"` #Listado de direcctorios y subdirectorios
for i in $directorios
do
for j in `ls $i`
do
if [ ! -d $i/$j ] && [ -x $i/$j ] #Selección de ficheros ejecutables
then
cd $i
if [ $# -eq 2 ]
then
renombrar "$j" "$2"
else
renombrar "$j" "exec"
fi
fi
done
done




