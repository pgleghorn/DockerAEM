README

Adobe Experience Manager (AEM) on Docker, this approach uses a "base" Dockerfile which unpacks the AEM kit, and an "install" Dockerfile that is used to generate both author and publish images. A dispatcher image is generated, using apache httpd.

Configuration (install dir, user, port, etc) are done in the buildDockerImages.sh script.

These "install" images are generated such that the image is finished and tagged once the AEM install is fully finished complete, which is checked by means of querying JMX for FrameworkStartLevel==30. In this way, the subsequent containers are quicker to run, as the lengthy AEM installation has already been done.

A docker-compose.yml is used to bring up author, publish and dispatcher.

USAGE

* edit buildDockerImages.sh and configure
 - AEM_USER
 - AEM_DIR
 - AEM_JAR
 - AEM_LICENSE
 - CQ_RUNMODE for author and publish, if desired
 - CQ_PORT for author and publish
 - AEM_JMXPORT for author and publish
* place AEM jar and license.properties into "base" directory
* "./buildDockerImages.sh" to generate the images
* "docker-compose up" to run the containers 

TODO

* enhance tools/startup.sh, JMX should be an option
* optional service pack install
* optional package/bundle install
* optional AEM configuration
* possible to make even faster startup? (non-essential bundles)
* repository compaction
* get java from .rpm, not yum
