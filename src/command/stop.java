package command;

import server.utils;

import static server.utils.*;

public class stop {

    public void run()
    {

        synchronized (utils.class)
        {
            if (server != null)
            {
                server.stop();
            }
        }
    }

}
