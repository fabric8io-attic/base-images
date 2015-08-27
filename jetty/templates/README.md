## Jetty {{= fp.config.version.version}}

A simple docker build for installing a vanilla Jetty {{= fp.config.version.version}} below
*/opt/jetty*. It comes out of the box and is intended for use in 
integration tests

{{= fp.block('appServer-instructions') }}

Features:

* Jetty Version: **{{= fp.config.version.version}}**
* Port: **8080**
* Command: `/opt/jetty/bin/deploy-and-run.sh` which links .war files from */maven* to 
  */opt/jetty/webapps* and then calls `/opt/jetty/bin/jetty.sh run`
* Sets `-Djava.security.egd=file:/dev/./urandom` for faster startup times
  (though a bit less secure)
  