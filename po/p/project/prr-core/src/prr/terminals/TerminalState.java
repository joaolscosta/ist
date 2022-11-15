package prr.terminals;

import java.io.Serializable;

public abstract class TerminalState implements Serializable{
    private Terminal _terminal;

    public TerminalState(Terminal terminal) {
        this._terminal = terminal;
    }

    public abstract boolean isBusyState();
    
    public abstract boolean isIdleState();

    public abstract boolean isOffState();

    public abstract boolean isSilenceState();

}
