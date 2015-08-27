## Apache Karaf {{= fp.config.version.version}}

A simple docker build for installing a vanilla Karaf {{= fp.config.version.version}} below
*/opt/karaf*. It comes out of the box and is intended for use for
integration testing.

{{= fp.block('appServer-instructions') }}

Features:

* Karaf Version: **{{= fp.config.version.version}}**
* Base image: *{{= fp.config.version.from.jre8 }}:{{= fp.config.version.from.version }}*)
* Port: **8080**
* User **admin** (Password: **admin**) has been added to access the admin
  applications */host-manager* and */manager*)
* Documentation and examples have been removed
* Command: `/opt/karaf/bin/deploy-and-run.sh` which links .kar files from */maven* to 
  */opt/karaf/deploy* and then calls `karaf run`
* Sets `-Djava.security.egd=file:/dev/./urandom` for faster startup times
  (though a bit less secure)
  
