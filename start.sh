#! /bin/sh
echo "Starting Sonar"

jsvc_location="/usr/bin/jsvc"
java_home="/usr/lib/jvm/default-java"
jar_paths="Sonar-Secure-Server.jar:lib/commons-daemon-1.2.2.jar"

name="SonarDaemon"
desc="Sonar Daemon Service"
class="server.serverDaemon"

args="start"
user="root"
pid="/var/run/$name.pid"
out="log/$name.out"
err="err/$name.err"

jsvc_exec()
{
$jsvc_location -home $java_home -cp $jar_paths -user $user -outfile $out -errfile $err -pidfile $pid $1 $class $args
}

case "$1" in
start)
echo "Starting the $desc..."

# Start the service
jsvc_exec

echo "The $desc has started."
;;
stop)
echo "Stopping the $desc..."

# Stop the service
jsvc_exec "-stop"

echo "The $desc has stopped."
;;
restart)
if [ -f "$pid" ]; then

echo "Restarting the $desc..."

# Stop the service
jsvc_exec "-stop"

# Start the service
jsvc_exec

echo "The $desc has restarted."
else
echo "Daemon not running, no action taken"
exit 1
fi
;;
*)
echo "Usage: /etc/init.d/$name {start|stop|restart}" >&2
exit 3
;;
esac