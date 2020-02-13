package server;

import com.sun.org.slf4j.internal.LoggerFactory;
import org.apache.commons.daemon.Daemon;
import org.apache.commons.daemon.DaemonContext;
import org.apache.commons.daemon.DaemonInitException;
import util.DataHolder;

import java.util.Arrays;

import static server.utils.logger;
import static server.utils.server;

public class serverDaemon implements Daemon {

    private Thread main;

    @Override
    public void init(DaemonContext daemonContext) throws DaemonInitException, Exception {
        String[] args = daemonContext.getArguments();

        System.out.println(Arrays.toString(args));

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
    public void start() throws Exception {
        logger = LoggerFactory.getLogger(utils.class);
        try
        {
            DataHolder data = new DataHolder(null, null);
            data.setPort(6000);

            mainServer tempServer = new mainServer();
            tempServer.run(data);

            main.start();
        }
        catch (Exception e)
        {
            logger.error("Terminating due to Exception: ", e);
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