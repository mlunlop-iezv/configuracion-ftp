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

- ### 1.1 Configuracion DNS 

Ahora vamos a hacer que el DNS sepa quien es ftp.mluna.test. La practica pide que ftp.example.com sea un alias. Nosotros haremos lo mismo: ftp.mluna.test será un alias de nuestro servidor debian.mluna.test

 - **Actualizacion del Fichero de Zona Directa**

 Editamos nuestro fichero config/mluna.test.dns y le añadimos una sola línea al final para el CNAME

 <img src="doc/img/dns-cname.png">

 Validamos que no hemos roto nada, apagando y encendiendo la maquina para que se apliquen los cambios:

 <img src="doc/img/validacion-dns.png">

 > Como vemos nos da el OK por lo que funciona

 - **Actualización del bootstrap.sh**

 Ahora tenemos que decirle al bootstrap.sh que instale el programa del servidor FTP (vsftpd).

 Editamos el bootstrap.sh y en la línea donde instalamos BIND9, añadimos vsftpd:

 <img src="doc/img/instalacion-vsftpd.png">

 - **Comprobacion del DNS**

 Para aplicar todos estos cambios, lanzamos el provision desde nuestra terminal:

 ```
 vagrant provision
 ```

 Una vez echo el provision comprobamos que funcione desde nuestro anfitrion:

 <img src="doc/img/comprobacion-nslookup.png">

## 2. Uso del cliente FTP gráfico

 - **1. Instalacion cliente _(FileZilla)_**

 Vamos a usar FileZilla, que es el más famoso, gratis y fácil de usar

 1. Entramos en la web oficial (filezilla-project.org)

 2. Descargamos el instalador para Windows e instalamos (Dale a "Siguiente" a todo)

 Ahora que tenemos el FileZilla lo abrimos y empezamos con los siguientes pasos

 <img src="doc/img/instalacion-filezilla.png">

 - **2. Preparamos los archivos del PC**

 La practica nos pide crear una carpeta _pruebasFTP_ con un fichero llamado _datos1.txt_

 <img src="doc/img/creacion-documentos-anfitrion.png>

 Ahora escribimos lo que sea en el documento de texto

 <img src="doc/img/code-datos1.png">

 - **3. Nos conectamos a ftp.cica.es**

 En FileZilla nos vamos a conexion rapida y lo rellenamos con lo siguiente:

 <img src="doc/img/conexion-fica.png">

 > Usuario y contraseña los dejamos en blanco para que sea conexion anonima

 Ahora al darle al boton de conexion rapido veremos que estamos conectados a cica 

 <img src="doc/img/fica-conectado.png">

 - **4. Descargar el fichero**

 En el panel de la derecha ("Sitio remoto"), buscamos la carpeta pub y hacemos doble clic en ella.

 <img src="doc/img/pub.png">

 Dentro de pub buscamos el fichero que se llama check

 <img src="doc/img/check.png">

 Hacemos doble clic sobre el fichero check.

 Ahora veremos que se descarga y aparece en tu panel izquierdo _(carpeta pruebasFTP)_

 <img src="doc/img/tranferencia.png">

 - **5. Intentar subir un fichero**

 Pinchamos en _datos1.txt_ y lo arrastramos al panel de la derecha _(servidor)_ y veremos el siguiente fallo

 <img src="doc/img/error.png">

 > Este fallo se debe a que no tenemos permisos al habernos conectado de manera anonima

 Una vez comprobado nos desconactamod del servidro cica (En la barra de herramientas buscamos _Servidor_ le damos y se despliege un menu y le clickamos a _Desconectar_)

## 3. Instalación y configuración del servidor vsftpd sobre Linux

Como en el primer paso ya lo hemos echo (instalacion de vsftpd) en el primer paso vamos por lo siguiente

- ### 3.1 Creacion de Usuario y Ficheros en _bootstrap.sh_

Vamos a añadir al _bootstrap.sh_ los comandos para que cree automáticamente los usuarios (luis, maria, miguel) y sus ficheros de prueba

<img src="doc/img/creacion-usuarios.png">

- ### 3.2 Creacion del Fichero _config/vsftpd.conf_

Vamos a la carpeta config y creamos un nuevo fichero llamado _vsftpd.conf_ y dentro de este escribmos lo siguiente:

<img src="doc/img/creacio-vsftpd.conf.png">

- ### 3.3: Crear Ficheros Auxiliares
En el fichero de arriba, hemos hecho referencia a dos ficheros nuevos (vsftpd.banner_anon y vsftpd.chroot_list) por lo que hay que crearlos

 - **1. Fichero de Banner Anónimo:**

 Creamos un fichero en config/ llamado vsftpd.banner-anon y escribimos:

 <img src="doc/img/banner-anon.png">

 - **2. Fichero Chroot**

 Creamos un fichero en config/ llamado vsftpd.chroot_list y escribimos:

 <img src="doc/img/maria.png">

 > Escribimos el nombre del usuario que no queremos enjaular

- ### 3.4 Actualizar _bootstrap.sh_

Ahora tenemos que modificar el _bootstrap.sh_ para que que copue los archivos nuevos y reinicie el servicio FTP:

<img src="doc/img/actualizacion-bootstrapsh.png">

- ## 3.5 Comprobaciones

Ahora vamos a comrpobar que lo hemos echo bien, primeros intalamos todo haceindo un 

```
vagrant provision
```

Ahora cuando termine entramos a la maquina y hacemos las comprobaciones

<img src="doc/img/comprobacion-activacion.png">

> Como se puede comprobar en la captura esta activo el FTP server

Ahora en este captura podemos comprobar el directori _/srv/ftp_, comprobamos el usuario _ftp_ y comprobamos que escuche el puerto 21

<img src="doc/img/otras-comprobaciones.png">

- ## 3.6 Comprobacion FileZilla

Abrimos FileZilla y hacemos varias pruebas

 - **1. Prueba anonima**

 <img src="doc/img/conexion-anon.png">

 > Como se puede ver se puede conectar y al intentar subir un archivo da erro puesto que somos anonimos

 - **2. Prueba _maria_ (No enjaulada)**

 <img src="doc/img/conexion-maria.png">

 > Al hacer click a los dos puntos (..) deja ver todos los archivos por lo que no esta enjaulada

 - **3. Prueba _luis_ (esnjauladO)**

 <img src="doc/img/conexion-luis.png">

 > Al hacer click a los dos puntos (..) no nos deja ver todos los archivos por lo que esta enjaulado

## 4. Configuración del servidor VSFTPD Seguro (FTPS)

- ## 4.1 Crear certificado SSL

Vamos a crear uno autofirmado usando openssl asi que modificaremos el _bootstrap.sh_ inserteremo el siguiente codigo antes de la liena _cp /vagrant/config/vsftpd.conf ..._ porque queremos tener el certificado antes de que el servicio lo intente leer:

<img src="doc/img/bootstrap-ssh.png">

- ## 4.2 Modificar config/vsftpd.conf para SSL

Ahora le tenemos que decir a VSFTPD que active el modo seguro y para que use el certificado que acabamos de crear

Abrimos el fichero vsftpd.conf y al final del todo escribimos:

<img src="doc/img/ssh-vsftpd-config.png">

- ## 4.3 Comprobaciones

Primero antes de nada hacemos un:

```
vagrant provision
```

Ahora hacemos una conexion ssh y comprobamos el estado del ftp:

<img src="doc/img/comprobacion-ssh.png">

> Como podemos ver el servicio esta activo

- ##  4.4 Comprobacion con FileZilla

En FileZilla vamos a "Archivo" > "Gestor de Sitios...". Le damos a crear un "Nuevo Sitio" y lo llamamos "FTP Seguro (mluna.test)". Rellenamos  la pestaña "General" con estos datos:

<img src="doc/img/gestor-de-sitios.png">

Le damos a conectar y nos saldra la siguiente ventana:

<img src="doc/img/aviso-certificado.png">

> Aqui marcamos la casilla "Confiar siempre en este certificado en futuras sesiones" y aceptamos

Ahora podemos ver que estamos conectados por lo que ha funcionado perfectamente



