package prr.notifications;

import prr.clients.Client;
import prr.terminals.Terminal;
import prr.terminals.TerminalState;

public class BusyToIdle extends Notification {

    public BusyToIdle(Terminal terminal, Client client, String state, String commType) {
        super("B2I", terminal, client, state, commType);
    }

}
