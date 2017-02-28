README

Adobe Experience Manager (AEM) on Docker, this approach uses a "base" Dockerfile which unpacks the AEM kit, and an "install" Dockerfile that is used to generate both author and publish images. A dispatcher image is generated, using apache httpd.

Configuration (install dir, user, port, etc) are done in the buildDockerImages.sh script.

These "install" images are generated such that the image is finished and tagged once the AEM install is fully finished complete, which is checked by means of querying JMX for FrameworkStartLevel==30. In this way, the subsequent containers are quicker to run, as the lengthy AEM installation has already been done.

A docker-compose.yml is used to bring up author, publish and dispatcher.

USAGE

* edit buildDockerImages.sh and configure
 - AEM_USER - unix user to install with
 - AEM_DIR - directory to install into
 - AEM_JAR - filename of AEM jar
 - AEM_LICENSE - filename of AEM license
 - CQ_RUNMODE - for author and publish, if desired
 - CQ_PORT - http por for author and publish
 - AEM_JMXPORT - JMX port for author and publish
* place the AEM jar and license.properties into "base" directory
* Run "./buildDockerImages.sh" to generate the images
* Run "docker-compose up" to run the containers 

TODO

* enhance tools/startup.sh, JMX should be an option
* optional service pack install
* optional package/bundle install
* optional AEM configuration, eg PyAEM
* possible to make even faster startup? (non-essential bundles)
* repository compaction
* get java from .rpm, not yum
* convert to proper configuration management eg puppet, ansible
* fix graceful shutdown (stop script)
* make clusterable from docker-compose
* mongodb backend
* test with 6.2 / 6.3beta
