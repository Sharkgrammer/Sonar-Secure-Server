#!/bin/sh

launch_daemon()
{
  /bin/sh &lt;&lt;EOF
     java -Ddaemon.pidfile=mydaemon.pid -cp src\ command.start < & - &
     pid=\$!
     echo \${pid}
EOF
}

daemon_pid=`launch_daemon`
if ps -p "${daemon_pid}" >/dev/null 2>&1
then
  # daemon is running.
  echo ${daemon_pid} > mydaemon.pid
else
  echo "Daemon did not start."
fi