#! /bin/sh

current_path=$(pwd)
current_IP=$(curl ifconfig.me)
jsvc_location="/usr/bin/jsvc"
java_home="/usr/lib/jvm/default-java"
jar_paths="$current_path/Sonar-Secure-Server.jar:$current_path/libs/commons-daemon-1.2.2.jar:$current_path/libs/log4j-1.2.17.jar:$current_path/libs/shark-protocol.jar"

name="SonarDaemon"
desc="Sonar Daemon"
class="server.serverDaemon"

args="$current_IP"
user=$(whoami)
pid="/var/run/$name.pid"
out="$current_path/log/$name.out"
err="$current_path/log/$name.err"

script="$jsvc_location -home $java_home -cp $jar_paths -user $user -outfile $out -errfile $err -pidfile $pid $1 $class $args"

jsvc_exec()
{
	sudo $script
}


case $1 in
	start)
		echo "Starting the $desc..."

		jsvc_exec

		echo "The $desc has started, running on $current_IP:6000"
	;;
	stop)
		echo "Stopping the $desc..."

		jsvc_exec "-stop"

		echo "The $desc has stopped"
	;;
	restart)
		if [ -f $PID ]; then
	
			echo "Restarting the $desc..."

			jsvc_exec "-stop"
			jsvc_exec

			echo "The $desc has been restarted, running on $current_IP:6000"
		else
			echo "$desc is not running, starting..."
			
			jsvc_exec
			
			echo "The $desc has started, running on $current_IP:6000"
		fi
	;;
	data)
		echo "Outputting Sonar Server Data"

		jsvc_exec "-data"

		echo "Complete, please check the logs located at $out"
	;;
	network)
		echo "Outputting Sonar Server Data"

		jsvc_exec "-network"

		echo "Complete, please check the logs located at $out"
	;;
	

esac