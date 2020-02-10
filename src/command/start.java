package command;

import org.apache.log4j.Appender;
import org.apache.log4j.ConsoleAppender;
import org.apache.log4j.SimpleLayout;
import server.mainServer;
import util.DataHolder;

import static server.utils.*;

public class start {

    public static void main(String[] args){
        Appender startupAppender = new ConsoleAppender(new SimpleLayout(), "System.err");
        try
        {
            logger.addAppender(startupAppender);

            DataHolder data = new DataHolder(null, null);
            data.setPort(6000);

            mainServer tempServer = new mainServer();
            tempServer.run(data);

            addDaemonShutdownHook();
            daemonize();
        }
        catch (Throwable e)
        {
            logger.fatal("Startup failed.", e);
        }
        finally
        {
            logger.removeAppender(startupAppender);
        }

        while(!isServerRunning())
        {
          //do nothing, just keep the server alive
        }
    }

}
