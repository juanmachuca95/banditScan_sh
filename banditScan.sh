#!/bin/bash

function ctrl_c(){
    echo -e "\n\n[!] Saliendo . . . \n"
    exit 1 
}

trap ctrl_c INT

# Variables 
HOSTNAME=""
MINP=0
MAXP=65535
OPENPORTS=()

while getopts ":h:m:t:p:" opt; do 
    case $opt in 
        h) 
            echo -e "\n[+] El hostname es: $OPTARG\n"
            HOSTNAME=${OPTARG}
        ;;
        m) 
            MINP=${OPTARG}
        ;;
        t) 
            MAXP=${OPTARG}
        ;; 
        \?) 
            echo -e "\n[-] Opción inválida -$OPTARG\n"
            exit 1 
        ;;
        :)
            echo -e "\n[-] El argumento en -$OPTARG es requerido\n"
            exit 1
        ;; 
    esac 
done 

echo -e "[*] Inicialización el Scaneo - ${MINP} - ${MAXP}\n"
for port in $(seq ${MINP} ${MAXP}) # Desde el puerto 31000 a 32000 
do 
    (timeout 1 echo '' > /dev/tcp/$HOSTNAME/$port) 2>/dev/null && echo -e "[+] $port \t- OPEN" && OPENPORTS+=($port) 
done
echo -e "\n[+] Escaneo terminado! 🚀\n"

