#!/bin/sh -x

BUILDARGS_BASE="\
--build-arg AEM_USER=aem \
--build-arg AEM_DIR=/opt/aem \
--build-arg AEM_JAR=AEM_6.1_Quickstart-author-p4502.jar \
--build-arg AEM_LICENSE=license.properties"

BUILDARGS_AUTHOR="\
--build-arg CQ_RUNMODE=author,nosamplecontent \
--build-arg CQ_PORT=4502 \
--build-arg AEM_JMXPORT=4602"

BUILDARGS_PUBLISH="\
--build-arg CQ_RUNMODE=publish,nosamplecontent \
--build-arg CQ_PORT=4503 \
--build-arg AEM_JMXPORT=4603"

docker build -t aem-base -f base/Dockerfile-AEM-base $BUILDARGS_BASE $@ base

docker build -t aem-author -f install/Dockerfile-AEM-install $BUILDARGS_AUTHOR $@ install

docker build -t aem-publish -f install/Dockerfile-AEM-install $BUILDARGS_PUBLISH $@ install

docker build -t aem-dispatch -f dispatch/Dockerfile-AEM-dispatcher $BUILDARGS_DISPATCH $@ dispatch
