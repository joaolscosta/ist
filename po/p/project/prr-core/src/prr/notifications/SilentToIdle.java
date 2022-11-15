package prr.notifications;

import prr.clients.Client;
import prr.terminals.Terminal;
import prr.terminals.TerminalState;

public class SilentToIdle extends Notification {

    public SilentToIdle(Terminal terminal, Client client, String state, String commType) {
        super("S2I", terminal, client, state, commType);
    }

}
