import util.DataHolder;

public class mainClass {

    public static void main(String[] args){
        DataHolder data = new DataHolder(null, null);
        data.setPort(6000);

        server server = new server();
        server.run(data);
    }

}
