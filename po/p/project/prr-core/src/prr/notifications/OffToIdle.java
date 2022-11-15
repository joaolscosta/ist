package prr.notifications;

import prr.clients.Client;
import prr.terminals.Terminal;
import prr.terminals.TerminalState;

public class OffToIdle extends Notification {

    public OffToIdle(Terminal terminal, Client client, String state, String commType) {
        super("O2I", terminal, client, state, commType);
    }

}
