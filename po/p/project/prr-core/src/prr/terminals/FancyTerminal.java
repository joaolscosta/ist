package prr.terminals;

public class FancyTerminal extends Terminal {
    private String _type = "FANCY";

    public FancyTerminal(String id, String clientId, String state) {
        super(id, clientId, state);
    }

    public String getType() {
        return this._type;
    }

    public void setType(String type) {
        _type = type;
    }
    public boolean isBasicTerminal(){
        return false;
    }

    public boolean isFancyTerminal(){
        return true;
    }
    @Override
    public String toString(){
        return "FANCY" + super.toString();
    }
}
