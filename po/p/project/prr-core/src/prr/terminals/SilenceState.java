package prr.terminals;

public class SilenceState extends TerminalState {

    public SilenceState(Terminal terminal) {
        super(terminal);
    }

    public boolean isBusyState(){
        return false;
    }

    public boolean isIdleState(){
        return false;
    }

    public boolean isOffState(){
        return false;
    }

    public boolean isSilenceState(){
        return true;
    }

    @Override
    public String toString(){
        return "SILENCE";
    }
}
