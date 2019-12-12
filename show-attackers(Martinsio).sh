#!/bin/bash
usage() {
    echo "Mensaje de prueba"
    exit 1
}
if [ $# -eq 0]; then
    echo "Debes establecer un fichero como argumento."
    usage
fi
if [ $# -gt 1]; then
    echo "Debes introducir un único argumento."
    usage
fi

file "$1" >> /dev/null
if [ $? -eq 1 ]; then
    echo "No se ha podido abrir el log $1."
    exit 1
else
    log=$(cat "$1" | grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}" | sort | uniq -c)
    for line in $log
    do
        count=$(cat "$1" | awk '{print $1}')
        if [ $count -gt 10 ]; then
                ip=$(cat "$1" | awk '{print $2}')
                ubi=$(geoiplookup $ip)
                echo "IP: $ip. Ubicación: $ubi"
        fi
    done
fi