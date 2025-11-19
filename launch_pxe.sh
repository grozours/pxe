#!/bin/bash
#
echo ""
read -p "Nom Ordi  ( magrotte ) : " NOM_MACHINE
echo "Mon Ordi: $NOM_MACHINE"
export NOM_MACHINE=$NOM_MACHINE

echo ""
read -p "Reseau ( format 192.168.1) : " NETWORK
echo "your network $NETWORK"
export NETWORK=$NETWORK
ip a
read -p "Mon ip  ( 192.168.1.2 ) : " MY_IP
echo "my ip address: $MY_IP"
export MY_IP=$MY_IP

echo ""
echo "Mot de passe root (masqué) :"
read -s PASSWORD_HASH1
echo "Verification Mot de passe root (masqué) :"
read -s PASSWORD_HASH2
while [ "$PASSWORD_HASH1" != "$PASSWORD_HASH2" ];
do
   echo "Mot de passe root (masqué) :"
   read -s PASSWORD_HASH1
   echo "Verification Mot de passe root (masqué):"
   read -s PASSWORD_HASH2
done
export PASSWORD_HASH=$(mkpasswd -m sha-512 $PASSWORD_HASH2)

echo ""
read -p "Utilisateur  ( mikael ) : " UTILISATEUR
echo "Mon Utilisateur: $UTILISATEUR"
export UTILISATEUR=$UTILISATEUR

echo ""
echo "Mot de passe utilisateur (masqué) :"
read -s PASSWORD1
echo "Vérification Mot de passe utilisateur (masqué) :"
read -s PASSWORD2
while [ "$PASSWORD1" != "$PASSWORD2" ];
do
   echo "Mot de passe utilisateur (masqué):"
   read -s PASSWORD1
   echo "Vérification Mot de passe utilisateur (masqué) :"
   read -s PASSWORD2
done
export PASSWORD=$PASSWORD2


export DEBIAN_BASE="http://ftp.fr.debian.org/debian/dists/Debian13.2"

envsubst < dnsmasq.tmpl > dnsmasq.conf
envsubst < public-html/boot.tmpl > public-html/boot.php
envsubst < public-html/debian/preseed.tmpl | sed -e 's/§/$/g' > public-html/debian/preseed.cfg

docker compose down
docker compose up -d --remove-orphans
