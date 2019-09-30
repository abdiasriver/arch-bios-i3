#!/bin/bash
set -e
##################################################################################################################
# Author 	: 	Abdiasriver
# Website 	: 	https://www.axeso.red
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################
# Necesitamos los paquetes   ( openssh,xclip,hugo,git) sudo pacman -S openssh xclip hugo
# change into your name and email.
#git init
git config --global user.name "abdiasriver"
git config --global user.email "abdias@alumnos.uaslp.edu.mx"
#sudo git config --system core.editor subl3
#git config --global credential.helper cache
#git config --global credential.helper 'cache --timeout=25000'
#git config --global push.default simple
#mkdir ~/.ssh
ls -al ~/.ssh
ssh-keygen -t rsa -b 4096 -C "abdias@alumnos.uaslp.edu.mx"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
xclip -sel clip < ~/.ssh/id_rsa.pub
echo "################################################################"
echo "###################    T H E   E N D      ######################"
echo "################################################################"
