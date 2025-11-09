# Práctica FTP: Configuración de un servidor
> Mario Luna López 2ºDAW_B

**Repositorio:** [_github.com/mlunlop-iezv/configuracion-ftp_](https://github.com/mlunlop-iezv/configuracion-ftp)

Antes de comenzar vamos a corregir fallos de la practica anterior ya que nos baseremos en esta para hacer este trabajo.

En la practica anterior se me olvido poner en el bootstrap.sh una linea que lo que hace es cargar los ficheros de manera automatica, por lo tanto habia que hacerlo manualmente, para corregir este error podremos la siguiente linea de codigo al final:

<img src="doc/img/correcion.png">

> Esta linea significa que al copiar el ultimo fichero se reiniciara el servicio (_bind9_).

Ahora si comenzamos la explicacion de la configuracion de un servidor FTP.

## 1. Configuracion inicial

Como estamos reutilizando la maquina DNS de la practica anterior la ip ya esta configurada _(192.168.56.8)_ y el nombre de dominio tambien _(mluna.test)_ a si que vamos a pasar a configurar el DNS

- ### Configuracion DNS 

Ahora vamos a hacer que el DNS sepa quien es ftp.mluna.test. La practica pide que ftp.example.com sea un alias. Nosotros haremos lo mismo: ftp.mluna.test será un alias de nuestro servidor debian.mluna.test

 - **Actualizacion del Fichero de Zona Directa**

 Editamos nuestro fichero config/mluna.test.dns y le añadimos una sola línea al final para el CNAME

 <img src="doc/img/dns-cname.png">

 Validamos que no hemos roto nada, apagando y encendiendo la maquina para que se apliquen los cambios:

 <img src="doc/img/validacion-dns.png">

 > Como vemos nos da el OK por lo que funciona

 
