package prr.terminals;

public class BusyState extends TerminalState {

    public BusyState(Terminal terminal) {
        super(terminal);
    }
    public boolean isBusyState(){
        return true;
    }

    public boolean isIdleState(){
        return false;
    }

    public boolean isOffState(){
        return false;
    }

    public boolean isSilenceState(){
        return false;
    }

    @Override
    public String toString(){
        return "BUSY";
    }
}
