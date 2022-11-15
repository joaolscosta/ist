package prr.communications;

public class Video extends Communication {

    public Video(int id, String idSender, String idReceiver, int units, int price, String status) {
        super("VIDEO", id, idSender, idReceiver, units, price, status);
    }
}
