package prr.notifications;

import prr.clients.Client;
import prr.terminals.Terminal;
import prr.terminals.TerminalState;

public class OffToSilent extends Notification {

    public OffToSilent(Terminal terminal, Client client, String state, String commType) {
        super("O2S", terminal, client, state, commType);
    }

}
