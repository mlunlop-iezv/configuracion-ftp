#!/bin/bash
#Actualizamos la lista de paquetes
echo "Actualizando el sistema ------------------------------------------------ "
apt-get update

#Instalamos BIND9
echo "Instalando bind9 ------------------------------------------------ "
apt-get install -y bind9 bind9utils bind9-doc vsftpd

#Aplicar la configuracion para siempre usar el iPv4
echo "Aplicando configuracion para siempre usar iPv4 ------------------------------------------------ "
cp /vagrant/config/named /etc/default/named

#Configurar la opciones de BIND9
echo "Configurando opciones de BIND9 ------------------------------------------------ "
cp /vagrant/config/named.conf.options /etc/bind/

#Configurar las zonas locales
echo "Configurando zonas locales ------------------------------------------------ "
cp /vagrant/config/named.conf.local /etc/bind/

#Creadno el fichero de la zona directa
echo "Creando el fichero de zona directa ------------------------------------------------ "
cp /vagrant/config/mluna.test.dns /var/lib/bind/

#Creacion del fichera de la zona inversa
echo "Copiando fichero de zona inversa ------------------------------------------------ "
cp /vagrant/config/mluna.test.rev /var/lib/bind/

#Creacion de usuarios para FTP 
echo "Creando usuarios FTP (luis, maria, miguel) ------------------------------------------------"
useradd -m luis
useradd -m maria
useradd -m miguel

#Asignamos contraseñas (igual que el nombre de usuario)
echo "luis:luis" | chpasswd
echo "maria:maria" | chpasswd
echo "miguel:miguel" | chpasswd

#Creamos ficheros de prueba para los usuarios
echo "Creando ficheros de prueba para luis y maria ------------------------------------------------"
touch /home/luis/luis{1,2}.txt
chown luis:luis /home/luis/luis*.txt

touch /home/maria/maria{1,2}.txt
chown maria:maria /home/maria/maria*.txt

# Reiniciamos BIND9 para que cargue todos los nuevos ficheros de configuración
echo "Reiniciando BIND9 para aplicar la configuración------------------------------------------------"
systemctl restart bind9