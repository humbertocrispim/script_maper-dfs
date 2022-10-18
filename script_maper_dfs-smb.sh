#!/bin/bash

RESET='\033[0m'
YELLOW='\033[1;33m'
#GRAY='\033[0;37m'
WHITE='\033[1;37m'
GRAY_R='\033[39m'
WHITE_R='\033[39m'
RED='\033[1;31m'   # Light Red.
GREEN='\033[1;32m' # Light Green.
#BOLD='\e[1m'

###################################################################################################################################################################################################
#                                                                                                                                                                                                 #
#                                                                                           Start Checks                                                                                          #
#                                                                                                                                                                                                 #
###################################################################################################################################################################################################
#echo -e "${GREEN}# Para que o script fucione e necessario irformar sua distribuição Linux ...\\n\\n${RESET}"
#read -p 'Para distros baseadas em .deb ubuntu/debian digite: apt, distros baseadas em .rpm fedora/RHEL digite yum : ' dist

echo -e "${RED}Para o funcionamento deste script e necessario a instalação do utilitario: cifs-utils e keyutils \\n
Caso esteja instalado iguinone este aviso!!!${RESET}"
sleep 3
clear

header() {
    clear
    clear
    echo -e "${GREEN}#########################################################################${RESET}\\n"
}

header_red() {
    clear
    clear
    echo -e "${RED}#########################################################################${RESET}\\n"
}

# Check for root (SUDO).
if [[ "$EUID" -ne 0 ]]; then
    header_red
    echo -e "${WHITE_R}#${RESET} O script precisa ser executado como root...\\n\\n"
    echo -e "${WHITE_R}#${RESET} Execute o comando abaixo para fazer login como root"
    echo -e "${GREEN}#${RESET} sudo -i\\n"
    exit 1
fi

#

mkdir /mnt/maper

read -p 'Coloque aqui o caminho do mapeamento que deseja montar : ' maper
read -p 'Usuario de dominio: ' uservar
read -sp 'Senha de dominio: ' passvar
read -p 'Coloque aqui seu dominio de AD: ' domain

sleep 2
{
    echo username=$uservar
    echo password=$passvar
    echo domain=$domain
} >/$USER/.credsmb.txt

sleep 3
clear

# Mapeamento

mount -t cifs $maper /mnt/maper -o uid=$UID,credentials=/$USER/.credsmb.txt
sleep 2
clear
echo -e "${GREEN}Sucesso !\\n\\n${RESET}"
echo -e "${GREEN}Seu mapeamento foi montado no diretorio /mnt/maper !\\n\\n${RESET}"
