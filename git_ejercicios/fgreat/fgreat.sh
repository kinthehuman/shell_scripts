#!/usr/bin/sh

if [ $1 -eq "-r" ]
then
fichero=`find -type f -exec du -Sh {} + | sort -rh | head -1 | cut -f2` #RECURSIVO
else
fichero=`find -maxdepth 1 -type f -exec du -Sh {} + | sort -rh | head -1 | cut -f2`  #NO RECURSIVO
fi
echo "mv $fichero $fichero.old"

