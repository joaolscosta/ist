package prr.terminals;

public class BasicTerminal extends Terminal {
    private String _type = "BASIC";

    public BasicTerminal(String id, String clientId, String state) {
        super(id, clientId, state);
    }

    public String getType() {
        return this._type;
    }

    public void setType(String type) {
        _type = type;
    }

    public boolean isBasicTerminal(){
        return true;
    }

    public boolean isFancyTerminal(){
        return false;
    }

    @Override
    public String toString(){
        return "BASIC" + super.toString();
    }

}
