package server;

import org.apache.commons.daemon.Daemon;
import org.apache.commons.daemon.DaemonContext;
import org.apache.commons.daemon.DaemonInitException;
import util.DataHolder;

import java.util.Arrays;

import static server.utils.server;

//REF http://www.neilson.co.za/creating-a-java-daemon-system-service-for-debian-using-apache-commons-jsvc/
public class serverDaemon implements Daemon {

    private Thread main;
    private String IP;

    @Override
    public void init(DaemonContext daemonContext) throws DaemonInitException, Exception {
        String[] args = daemonContext.getArguments();

        IP = args[0];

        main = new Thread(){

            @Override
            public synchronized void start() {
                super.start();
            }

            @Override
            public void run() {
                while(server.isServerRunning()){
                   //do nothing, keep it alive
                }
            }

        };
    }

    @Override
    public void start() {

        try
        {
            DataHolder data = new DataHolder(null, null);
            data.setIP(IP);
            data.setPort(6000);

            mainServer tempServer = new mainServer();
            tempServer.run(data);

            main.start();
        }
        catch (Exception e)
        {
            System.out.println(e.toString());
            System.out.println(Arrays.toString(e.getStackTrace()));
        }

    }

    @Override
    public void stop() throws Exception {
        server.stop();
    }

    @Override
    public void destroy() {
        main = null;
    }
}