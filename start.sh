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

script="$jsvc_location -home $java_home -cp $jar_paths -user $user -outfile $out -errfile $err -pidfile $pid $1 $class $args"
jsvc_exec()
{
$jsvc_location -home $java_home -cp $jar_paths -user $user -outfile $out -errfile $err -pidfile $pid $1 $class $args
}

echo "Starting the $desc..."

# Start the service
jsvc_exec

echo "The $desc has started"
echo $pid
echo $script

