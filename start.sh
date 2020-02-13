#! /bin/sh
echo "Starting Sonar"

jsvc_location="/usr/bin/jsvc"
java_home="/usr/lib/jvm/default-java"
jar_paths="$current_path/Sonar-Secure-Server.jar:$current_path/lib/commons-daemon-1.2.2.jar"
current_path=$(pwd)

name="SonarDaemon"
desc="Sonar Daemon Service"
class="server.serverDaemon"

args="start"
user="root"
pid="/var/run/$name.pid"
out="$current_path/log/$name.out"
err="$current_path/log/$name.err"

script="$jsvc_location -home $java_home -cp $jar_paths -user $user -outfile $out -errfile $err -pidfile $pid $1 $class $args"

jsvc_exec()
{
sudo $jsvc_location -home $java_home -cp $jar_paths -user $user -outfile $out -errfile $err -pidfile $pid $1 $class $args
}

echo "Starting the $desc..."

# Start the service
jsvc_exec

echo "The $desc has started, apparently"