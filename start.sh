#! /bin/sh
echo "Starting Sonar"

current_path=$(pwd)
current_IP=$(curl ifconfig.me)
jsvc_location="/usr/bin/jsvc"
java_home="/usr/lib/jvm/default-java"
jar_paths="$current_path/Sonar-Secure-Server.jar:$current_path/libs/commons-daemon-1.2.2.jar:$current_path/libs/log4j-1.2.17.jar:$current_path/libs/shark-protocol.jar"

name="SonarDaemon"
desc="Sonar Daemon"
class="server.serverDaemon"

args="start"
user=$(whoami)
pid="/var/run/$name.pid"
out="$current_path/log/$name.out"
err="$current_path/log/$name.err"

script="$jsvc_location -home $java_home -cp $jar_paths -user $user -outfile $out -errfile $err -pidfile $pid $1 $class $args"

echo $script

jsvc_exec()
{
$script
}

echo "Starting the $desc..."

# Start the service
jsvc_exec

echo "The $desc has started, running on $current_IP:6000"