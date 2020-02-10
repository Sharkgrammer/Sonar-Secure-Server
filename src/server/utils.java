package server;

import org.apache.log4j.Logger;
import recieve.ServerHandler;
import util.DataHolder;

import java.io.File;
import java.util.Set;

public class utils {

    public static Logger logger;
    public static ServerHandler server;

    public static void daemonize()
    {
        mainThread = Thread.currentThread();

        getPidFile().deleteOnExit();
        System.out.close();
        System.err.close();
    }

    public static File getPidFile ()
    {
        return new File(System.getProperty("daemon.pidfile"));
    }

    static public void shutdown()
    {
        server.stop();

        try
        {
            getMainDaemonThread().join();
        }
        catch(InterruptedException e)
        {
            logger.error("Interrupted which waiting on main daemon thread to complete.");
        }
    }

    public static boolean isServerRunning()
    {
        return server.isServerRunning();
    }

    public static void addDaemonShutdownHook()
    {
        Runtime.getRuntime().addShutdownHook(new Thread(utils::shutdown));
    }

    static private Thread mainThread;

    static private Thread getMainDaemonThread()
    {
        return mainThread;
    }

}


