#!/bin/bash

# Colores
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

#---FUNCIONES---#

tableInfo(){
    firstOctet=$(echo $1 | cut -d '.' -f 1)
    secondOctet=$(echo $1 | cut -d '.' -f 2)
    thirdOctet=$(echo $1 | cut -d '.' -f 3)
    fourthOctet=$(echo $1 | cut -d '.' -f 4)

    if (( firstOctet >= 0 && firstOctet <= 127 )); then
        clase='A'
    elif(( firstOctet >= 128 && firstOctet <= 191 )); then
        clase='B'
    elif(( firstOctet >= 192 && firstOctet <= 223 )); then
        clase='C'
    elif(( firstOctet >= 224 && firstOctet <= 239 )); then
        clase='D'
    elif(( firstOctet >= 240 && firstOctet <= 255 )); then
        clase='E'
    else
        clase='Desconocida'
    fi

    echo -e "\n${redColour}[+]${endColour} Class: ${purpleColour}$clase${endColour}"

    if [ "$clase" = "A" ]; then
        bits=24
        echo -e "${redColour}[+]${endColour} Network Adress: ${blueColour}$firstOctet${endColour}.${greenColour}0${endColour}.${greenColour}0${endColour}.${greenColour}0${endColour}"
        echo -e "${redColour}[+]${endColour} First Host Adress: ${blueColour}$firstOctet${endColour}.${greenColour}0${endColour}.${greenColour}0${endColour}.${greenColour}1${endColour}"
        echo -e "${redColour}[+]${endColour} Last Host Adress: ${blueColour}$firstOctet${endColour}.${greenColour}255${endColour}.${greenColour}255${endColour}.${greenColour}254${endColour}" 
        echo -e "${redColour}[+]${endColour} Broadcast Adress: ${blueColour}$firstOctet${endColour}.${greenColour}255${endColour}.${greenColour}255${endColour}.${greenColour}255${endColour}" 
        echo -e "${redColour}[+]${endColour} Asignable Hosts: ${greenColour}$(((2**$bits) - 2))${endColour}"
    elif [ "$clase" = "B" ]; then
        bits=16
        echo -e "${redColour}[+]${endColour} Network Adress: ${blueColour}$firstOctet${endColour}.${blueColour}$secondOctet${endColour}.${greenColour}0${endColour}.${greenColour}0${endColour}"
        echo -e "${redColour}[+]${endColour} First Host Adress: ${blueColour}$firstOctet${endColour}.${blueColour}$secondOctet${endColour}.${greenColour}0${endColour}.${greenColour}1${endColour}"
        echo -e "${redColour}[+]${endColour} Last Host Adress: ${blueColour}$firstOctet${endColour}.${blueColour}$secondOctet${endColour}.${greenColour}255${endColour}.${greenColour}254${endColour}" 
        echo -e "${redColour}[+]${endColour} Broadcast Adress: ${blueColour}$firstOctet${endColour}.${blueColour}$secondOctet${endColour}.${greenColour}255${endColour}.${greenColour}255${endColour}" 
        echo -e "${redColour}[+]${endColour} Asignable Hosts: ${greenColour}$(((2**$bits) - 2))${endColour}"
    elif [ "$clase" = "C" ]; then
        bits=8
        echo -e "${redColour}[+]${endColour} Network Adress: ${blueColour}$firstOctet${endColour}.${blueColour}$secondOctet${endColour}.${blueColour}$thirdOctet${endColour}.${greenColour}0${endColour}"
        echo -e "${redColour}[+]${endColour} First Host Adress: ${blueColour}$firstOctet${endColour}.${blueColour}$secondOctet${endColour}.${blueColour}$thirdOctet${endColour}.${greenColour}1${endColour}"
        echo -e "${redColour}[+]${endColour} Last Host Adress: ${blueColour}$firstOctet${endColour}.${blueColour}$secondOctet${endColour}.${blueColour}$thirdOctet${endColour}.${greenColour}254${endColour}" 
        echo -e "${redColour}[+]${endColour} Broadcast Adress: ${blueColour}$firstOctet${endColour}.${blueColour}$secondOctet${endColour}.${blueColour}$thirdOctet${endColour}.${greenColour}255${endColour}" 
        echo -e "${redColour}[+]${endColour} Asginable Hosts: ${greenColour}$(((2**$bits) - 2))${endColour}"
    fi
}

scanHosts() {
    arp -a | while read -r line; do
        nameHost=$(echo $line | awk '{print $1}')
        ipAdress=$(echo $line | grep -oP '\(\K[^\)]*')
        macAdress=$(echo $line | awk '{print $4}')

        if [ $nameHost = '=' ]; then
            echo -e "\n${redColour}[+]${endColour} Host: Unknown"
        else
            echo -e "\n${redColour}[+]${endColour} Host: $nameHost"
        fi
        echo -e "     IP: $ipAdress"
        echo -e "     MAC: $macAdress"
    done
}

#--MAIN---#
echo -e "${yellowColour}-----------------------------------"
echo -e "|    🌐Network Informaction Menu   |"
echo -e "-----------------------------------${endColour}\n"
echo -e "${redColour}[1]${endColour} Local Network"
echo -e "${redColour}[2]${endColour} Enter Network manually"
read -p "$(echo -e "${redColour}>>>${endColour} Choose an option: ")" option

if [ $option = 1 ]; then
    echo -e "\n${yellowColour}---📡Local Network Information---${endColour}"

    subnet=$(ip a | grep wlp0s20f3 | tail -n 1 | awk '{print $2}')
    ipAdress=$(echo $subnet | cut -d '/' -f 1)
    tableInfo $ipAdress

    read -p "$(echo -e "\n${redColour}[?]${endColour} Want to discover all the hosts in LAN? (y/n) > ")" option2
    if [ $option2 = 'y' ]; then
        echo -e "\n${yellowColour}---📡Scanning all hosts---${endColour}"

        scanHosts $subnet
    fi
elif [ $option = 2 ]; then
    echo -e "\n${yellowColour}---📡Network Information---${endColour}"
    read -p "$(echo -e "${redColour}>>>${endColour} Enter the IPv4: ")" ipAdress

    tableInfo $ipAdress
fi
