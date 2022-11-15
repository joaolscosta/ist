package prr.terminals;

public class IdleState extends TerminalState {

    public IdleState(Terminal terminal) {
        super(terminal);
    }

    public boolean isBusyState(){
        return false;
    }

    public boolean isIdleState(){
        return true;
    }

    public boolean isOffState(){
        return false;
    }

    public boolean isSilenceState(){
        return false;
    }

    @Override
    public String toString(){
        return "IDLE";
    }

}
