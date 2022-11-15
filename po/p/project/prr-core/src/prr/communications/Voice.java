package prr.communications;

public class Voice extends Communication {

    public Voice(int id, String idSender, String idReceiver, int units, int price, String status) {
        super("VOICE", id, idSender, idReceiver, units, price, status);
    }
}
