import crypto.CryptManager;
import recieve.ServerHandler;
import util.DataHolder;

class server {

    private ServerHandler server ;

    public void run(DataHolder s){

        temp tempkey = new temp();

        CryptManager manager = new CryptManager();
        manager.setKeys(tempkey.pukey1, tempkey.prkey1);
        s.setManager(manager);
        s.setServer(true);

        System.out.println("I am " + s.getIP() + ":" + s.getPort());

        server = new ServerHandler(s, null);
        server.start();

    }

}