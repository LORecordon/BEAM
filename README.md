__Nombres de integrantes:__ [Incorporar aquí]
# Proyecto 1.1: Travel Log - Aplicación de Backend

En el primer proyecto de este curso usarás la presente aplicación desarrollada con Ruby on Rails 7 como backend para la aplicación web móvil que se requiere desarrollar.

La aplicación móvil es una bitácora de viajes, en la cual un usuario genera viajes por varios destinos, y puede crear notas (_posts_) al recorrer los destinos. Los _posts_ pueden incluir texto, imágenes, vídeo y audio.

En las siguientes secciones revisamos las características de esta aplicación de backend, su configuración, y su ejecución.

Si lo deseas, puedes saltar a la sección "Requisitos de la entrega de proyecto 1.1" para ver los requisitos de esta primera entrega de proyecto.
## Requisitos para el trabajo con la aplicación de backend

### Requisitos de sistema operativo
Necesitas un ambiente de desarrollo preferentemente basado en Linux o macOS. Si usas Windows, es recomendable instalar WSL (Windows Subsystem for Linux), o usar una máquina virtual con Ubuntu o Debian. 

Las instrucciones para instalar WSL con Ubuntu Linux en Windows 11 [las encuentras aquí](https://learn.microsoft.com/en-us/windows/wsl/install).

### IDE preferida
Para el desarrollo, Visual Studio Code es la IDE que usaremos en el curso.

### Docker para ambiente de producción

Para ejecutar esta aplicación en modo producción, necesitarás [Docker](https://www.docker.com/products/docker-desktop/) instalado en tu ambiente de desarrollo. Para instalar Docker sigue estas instrucciones:

* Windows con WSL [https://docs.docker.com/desktop/wsl/]
* Ubuntu Desktop [https://docs.docker.com/desktop/install/ubuntu/]
* macOS [https://docs.docker.com/desktop/install/mac-install/]

### Ambiente de desarrollo

Necesitarás contar con ruby y RVM ([https://www.rvm.io]) para el ambiente de desarrollo. Ruby viene instalado en macOS de fábrica. Si instalas RVM, éste se encargará de mantener las versiones. Por otro lado, si usas Ubuntu Desktop, también ruby debería venir instalado. En caso que lo tengas que instalar manualmente:

```sh
sudo apt install ruby
```

En Windows con WSL y Ubuntu, el comando para instalar ruby es el mismo.

### Cliente de pruebas

Para probar la funcionalidad de esta aplicación de backend, necesitarás una aplicación cliente. Lo recomendable es usar [Postman](https://www.postman.com/downloads/), el cual se encuentra disponible para Windows, Linux y Mac.

## Ejecutar la Aplicación

### Ambiente de desarrollo

Para realizar cambios al backend, puedes utilizar el ambiente de desarrollo, a fin de contar con capacidad de depuración. Para esto, puedes ejecutar los siguientes comandos una vez clonado el repositorio en tu ambiente de trabajo:

Es conveniente contar con RVM para crear un gemset y allí instalar todas las dependencias de la aplicación. Si no has instalado RVM (www.rvm.io), hazlo. Si cuentas con RVM:

```sh
$rvm gemset create travel-log
$rvm use 3.1.1@travel-log
$RAILS_ENV=development db:setup
$RAILS_ENV=development db:populate_fake_data # llena la base de datos con datos de prueba
```

El directorio raíz tiene archivos `.ruby-version` y `.ruby-gemset` con información de la versión de ruby y gemset que se debe usar, por lo que cada vez que accedas al directorio raíz por el terminal RVM automáticamente seleccionará la versión de ruby y el gemset que se necesitan.

Para ejecutar la aplicación:

```sh
$rails s # Ctrl+c para detener
```

La aplicación en modo de desarrollo queda disponible en `localhost:3000`.

### Ambiente de producción

Esta aplicación está completamente contenerizada y disponible para ser ejecutada con Docker (Compose) en su ambiente de producción. El ambiente de producción es el que usarás normalmente en el desarrollo del proyecto.
 
El directorio `docker` contiene los archivos `Dockerfile` para un servidor web (nginx) que actúa como proxy reverso del servidor de aplicación (puma). En el directorio raíz se encuentra `docker-compose.yml` con toda la configuración de servicios necesaria.

Para lanzar la aplicación de backend, en la línea de comandos basta lo siguiente:

```sh
docker-compose up --build
```

Si se quiere correr docker desconectado de la consola, se puede añadir la opción `-d` (dettached).

Para detener la ejecución de los contenedores, usar el comando siguiente:

```sh
docker-compose down --remove-orphans
```

La opción `--remove-orphans` elimina contenedores creados en una ejecución anterior del comando `docker-compose up` que ya no se requieren.

En el ambiente de producción la aplicación queda mappeada al puerto `9090` de la máquina host. Es decir, la API expuesta por la aplicación de backend en producción siempre estará accesible por `http://localhost:9090``

## Modelo de datos y base de datos de la aplicación de backend

Como en toda aplicación desarrollada con Ruby on Rails y ActiveRecord, podrás encontrar los modelos de la aplicación en el directorio `app/models`. Los modelos básicos de esta aplicación son `User`, `Trip`, `Destination`, y `Post`. Además, existen otros modelos enfocados en contenido, como `Video`, `Photo`, y `Audio`. Las migraciones están en `db/migrate`.

En ambiente de producción (que será el utilizado normalmente), la base de datos es PostgreSQL. La inicialización de la base de datos es realizada por ActiveRecord utilizando una tarea de _rake_ ubicada en `lib/tasks/db.rake` cuyo nombre es `populate_fake_data`.

## Rutas de la aplicación

Como en toda aplicación Rails, podrás encontrar las rutas de la aplicación ejecutando en la consola:

```sh
rails routes
```

Además, puedes revisar el archivo de rutas en `config/routes.rb`.

## Generación de una API Key

En el proyecto tu trabajo estará enfocado en desarrollar una aplicación de frontend. Para que la aplicación de frontend pueda utilizar los servicios (endpoints REST) expuestos por el backend, el primer paso es la autenticación y generación de una API key utilizando un usuario válido. Puedes experimentar la obtención de una API key utilizando Postman, y una cuenta de usuario por defecto con que cuenta la base de datos al momento de correr el task `db:populate_fake_data`.

Con Postman te recomendamos crear un nuevo workspace para trabajar en el curso, p.ej., icc4203-202320, y dentro del workspace, crear las peticiones (requests). Para crear una API key los parámetros de request para Postman son los siguientes:

Método: POST
URL: http://localhost:3000/api/v1/api-keys
Pestaña Authorization: Username: admin@admin.com, Password: admin

Si ejecutas exitosamente esta petición, en el cuerpo de la respuesta (Body) verás un objeto JSON con un atributo llamado token, cuyo valor luego podrás usar para autenticar las peticiones próximas a esta aplicación de backend.

## Requisitos de la entrega de proyecto 1.1

Tu trabajo para esta entrega de proyecto consistirá en realizar una serie de consultas a la aplicación de backend utilizando Postman, y en aumentar las capacidades del backend agregando funciones a la API. En cada requisito se te dará un ejemplo de la URL que debe procesar la petición. Debes modificar los controladores en la aplicación de backend para que puedan realizar la acción requerida. 

Lo anterior te requerirá estudiar cómo están definidos los modelos, revisar los controladores y revisar las rutas en la aplicación. Te recomendamos partir por lograr esto. Puedes trabajar tus modificaciones a la aplicación de backend en modo desarrollo, pero al terminar, debes probar que todo funcione en modo producción (con docker compose).

1. [.5] Generen una API key con usuario `admin@admin.com` como aparece explicado arriba en la sección "Generación de una API Key". (No se requiere modificar código de backend, sólo request en Postman).
2. [.5] Modifiquen el usuario `admin@admin.com` con campos de `first_name`, `last_name`, `dob` (fecha de nacimiento), descripción y teléfono con los datos de alguno de los integrantes del grupo. (No se requiere modificar código de backend, sólo request en Postman).
3. [.5] Creen un `Post` con dos `Destinations`. (No se requiere modificar código de backend, sólo request en Postman).
4. [2.0] Listen todos los `Trips` que contengan la palabra "Chuck" en el nombre, en la descripción o en cualquier parte del título o cuerpo de un `Post` asociado al `Trip`. Aquí es necesario modificar la API en backend para que se puedan realizar búsquedas por palabras clave como lo requiere este enunciado. El "endpoint" al cual realizar la petición tiene la siguiente forma: `http://host:puerto/api/v1/trips?search=Chuck`. El controlador debe renderizar una estructura JSON que contenga un array con todos los trips que coinciden con lo buscado.
5. [2.0] Eliminen un `Destination` de un `Post`. Para implementar esta funcionalidad se requiere desarrollar una acción que responda al siguiente enrutamiento: `http://host:puerto/api/v1/posts/:post_id/destinations/:destination_id`. Recordar la configuración de rutas en Rails y el anidamiento de recursos en las rutas. Las declaraciones en `config/routes.rb` vienen configuradas con lo necesario.
6. [.5] Eliminen la `APIKey` creada inicialmente. (No se requiere modificar código de backend, sólo request en Postman).

Pueden agregar a continuación la URL de su colección de Postman con las peticiones para los requisitos en numerales 1, 2, 3 y 6:

__URL de la colección Postman:__ [insertar aquí]

## Entrega

Deben entregar su trabajo en este repositorio, con posibilidad de realizar push hasta el domingo 20/8 hasta las 23:59 hrs.

## Referencias

Para el desarrollo de la autenticación en esta aplicación se utilizó la siguiente guía: 
[https://keygen.sh/blog/how-to-implement-api-key-authentication-in-rails-without-devise/]

