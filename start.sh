#! /bin/sh
echo "Starting Sonar"

current_path=$(pwd)
jsvc_location="/usr/bin/jsvc"
java_home="/usr/lib/jvm/default-java"
jar_paths="$current_path/Sonar-Secure-Server.jar:$current_path/libs/commons-daemon-1.2.2.jar:$current_path/libs/log4j-1.2.17.jar:$current_path/libs/shark-protocol.jar"

name="SonarDaemon"
desc="Sonar Daemon Service"
class="server.test"

args="start"
user="root"
pid="/var/run/$name.pid"
out="$current_path/log/$name.out"
err="$current_path/log/$name.err"

script="$jsvc_location -home $java_home -cp $jar_paths -user $user -outfile $out -errfile $err -pidfile $pid $1 $class $args"

echo $script

jsvc_exec()
{
sudo $script
}

echo "Starting the $desc..."

# Start the service
jsvc_exec

echo "The $desc has started, apparently"