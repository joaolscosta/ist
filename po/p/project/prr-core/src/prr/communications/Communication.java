package prr.communications;

public abstract class Communication {
    private int _id;
    private String _type;
    private String _idSender;
    private String _idReceiver;
    private int _units;
    private double _price;
    private String _status;
    private boolean paid = false;

    public Communication(String type, int id, String idSender, String idReceiver, int units, double price,
            String status) {
        _type = type;
        _id = id;
        _idSender = idSender;
        _idReceiver = idReceiver;
        _units = units;
        _price = price;
        _status = status;
    }

    public int getId() {
        return this._id;
    }

    public String getType() {
        return _type;
    }

    public String getIdSender() {
        return _idSender;
    }

    public String getIdReceiver() {
        return _idReceiver;
    }

    public int getUnits() {
        return this._units;
    }

    public double getPrice() {
        return this._price;
    }

    public String getStatus() {
        return _status;
    }

    public void setPrice(double price){
        this._price = price;
    }

    public void setDuration(double duration){
        this._units = doubleToInt(duration);
    }

    public boolean isPaid(){
        return paid;
    }

    public int doubleToInt(double number) {
        int value = (int) number;
        return value;
    }

    public void finishCommunication(){
        this._status = "FINISHED";
    }

    public void payComm(){
        paid = true;
    } 

    public String toString() {
        return this.getType() + "|" + this.getId() + "|" + this.getIdSender() + "|" +
                this.getIdReceiver() + "|" + this.getUnits() + "|" + doubleToInt(this.getPrice()) + "|"
                + this.getStatus();

    }

}
