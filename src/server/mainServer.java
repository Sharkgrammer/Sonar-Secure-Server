package server;

import crypto.CryptManager;
import recieve.ServerHandler;
import util.Base64Handler;
import util.DataHolder;
import util.temp;

import java.util.Arrays;

import static server.utils.*;

public class mainServer {

    public void run(DataHolder s){

        temp tempkey = new temp();

        CryptManager manager = new CryptManager();
        manager.setKeys(tempkey.pukey1, tempkey.prkey1);
        s.setManager(manager);
        s.setServer(true);
        Base64Handler base64 = s.getBase64();

        System.out.println();
        System.out.println(" ~~~ SERVER INFO START ~~~ ");
        System.out.println();

        System.out.println();
        System.out.println("My IP address is " + s.getIP());
        System.out.println("My port is " + s.getPort());
        System.out.println("Full: " + s.getIP() + ":" + s.getPort());
        System.out.println();

        System.out.println();
        System.out.println("My public key, its raw data and encoded in base64");
        System.out.println(s.getManager().getPublicKey());
        System.out.println(Arrays.toString(s.getManager().getPublicKey().getEncoded()));
        System.out.println(new String(base64.toBase64(s.getManager().getPublicKey().getEncoded())));
        System.out.println();

        System.out.println();
        System.out.println(" ~~~ SERVER INFO END ~~~ ");
        System.out.println();

        server = new ServerHandler(s, null);
        server.start();
    }

}