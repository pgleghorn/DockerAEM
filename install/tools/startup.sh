#!/bin/sh

# TODO switches
# -jmx check for startup via FrameworkStartLevel 30
# -curl check for startup via response on port
# -tail tail logs during startup
#   which logs, optional?

# TODO quit if required vars are missing

$AEM_DIR/crx-quickstart/bin/start

toolsdir=`dirname $0`
LOGS="$AEM_DIR/crx-quickstart/logs/error.log $AEM_DIR/crx-quickstart/logs/stdout.log"
touch $LOGS

# exiting when startup finished?
if [ "$1" = "-exit" ]; then
	tail -n0 -f $LOGS &
	tailpid=$!
	while true; do
		r=`java -jar $toolsdir/cmdline-jmxclient-0.10.3.jar  - localhost:$AEM_JMXPORT "osgi.core:framework=org.apache.felix.framework,type=framework,uuid=*,version=*" FrameworkStartLevel 2>&1 | grep FrameworkStartLevel`
		echo $r
		startlevel=`echo $r | awk '{print $6}'`
		if [ "$startlevel" = 30 ]; then echo "FINISHED"; break; fi
		sleep 1
	done
	kill $tailpid
# tail forever
else
	tail -n0 -f $LOGS
fi
