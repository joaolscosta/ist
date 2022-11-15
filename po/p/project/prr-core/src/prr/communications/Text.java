package prr.communications;

public class Text extends Communication {

    public Text(int id, String idSender, String idReceiver, int units, double price, String status) {
        super("TEXT", id, idSender, idReceiver, units, price, status);
    }

}
