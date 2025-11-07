# Práctica FTP: Configuración de un servidor
> Mario Luna López 2ºDAW_B

**Repositorio:** [_github.com/mlunlop-iezv/configuracion-ftp_](https://github.com/mlunlop-iezv/configuracion-ftp)

Antes de comenzar vamos a corregir fallos de la practica anterior ya que nos baseremos en esta para hacer este trabajo.

En la practica anterior se me olvido poner en el bootstrap.sh una linea que lo que hace es cargar los ficheros de manera automatica, por lo tanto habia que hacerlo manualmente, para corregir este error podremos la siguiente linea de codigo al final:

<img src="doc/img/correcion.png">

> Esta linea significa que al copiar el ultimo fichero se reiniciara el servicio (_bind9_).
