package prr.terminals;

public class OffState extends TerminalState {

    public OffState(Terminal terminal) {
        super(terminal);
    }

    public boolean isBusyState(){
        return false;
    }

    public boolean isIdleState(){
        return false;
    }

    public boolean isOffState(){
        return true;
    }

    public boolean isSilenceState(){
        return false;
    }

    @Override
    public String toString(){
        return "OFF";
    }
}
