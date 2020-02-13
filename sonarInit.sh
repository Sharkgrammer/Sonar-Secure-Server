#! /bin/sh
# /etc/init.d/Sonar-Secure-Server

### BEGIN INIT INFO
# Provides: Sonar-Secure-Server
# Required-Start: $remote_fs $syslog
# Required-Stop: $remote_fs $syslog
# Short-Description: Starts the Sonar-Secure-Server service
# Description: This file is used to start the daemon
# and should be placed in /etc/init.d
### END INIT INFO

### Original Author Info
# Author: Sheldon Neilson &lt;sheldon[AT]neilson.co.za&gt;
# Url: www.neilson.co.za
# Date: 25/04/2013
### 

NAME="Sonar-Secure-Server"
DESC="Sonar-Secure-Server service"

# The path to Jsvc
EXEC="/usr/bin/jsvc"

# The path to the folder containing Sonar-Secure-Server.jar
FILE_PATH="/usr/local/$NAME"
FILE_PATH_FULL = $FILE_PATH_FULL + "/linux"

# The path to the folder containing the java runtime
JAVA_HOME="/usr/lib/jvm/default-java"

# Our classpath including our jar file and the Apache Commons Daemon library
CLASS_PATH="$FILE_PATH/Sonar-Secure-Server.jar:$FILE_PATH/lib/commons-daemon-1.2.2.jar"

# The fully qualified name of the class to execute
CLASS="server.serverDaemon"

# Any command line arguments to be passed to the our Java Daemon implementations init() method
ARGS=""

#The user to run the daemon as
USER="root"

# The file that will contain our process identification number (pid) for other scripts/programs that need to access it.
PID="/var/run/$NAME.pid"

# System.out writes to this file...
LOG_OUT="$FILE_PATH/log/$NAME.out"

# System.err writes to this file...
LOG_ERR="$FILE_PATH/err/$NAME.err"

jsvc_exec()
{
cd $FILE_PATH_FULL
$EXEC -home $JAVA_HOME -cp $CLASS_PATH -user $USER -outfile $LOG_OUT -errfile $LOG_ERR -pidfile $PID $1 $CLASS $ARGS
}

case "$1" in
start)
echo "Starting the $DESC..."

# Start the service
jsvc_exec

echo "The $DESC has started."
;;
stop)
echo "Stopping the $DESC..."

# Stop the service
jsvc_exec "-stop"

echo "The $DESC has stopped."
;;
restart)
if [ -f "$PID" ]; then

echo "Restarting the $DESC..."

# Stop the service
jsvc_exec "-stop"

# Start the service
jsvc_exec

echo "The $DESC has restarted."
else
echo "Daemon not running, no action taken"
exit 1
fi
;;
*)
echo "Usage: /etc/init.d/$NAME {start|stop|restart}" >&2
exit 3
;;
esac