package prr.notifications;

import prr.clients.Client;
import prr.terminals.Terminal;

public class Notification {
    private String _type = "";
    private Terminal _terminal;
    private Client _client;
    private String _commType;
    private String _state;
    private boolean _received = false;

    public Notification(){
        //do nothing
    }

    public Notification(String type, Terminal terminal, Client client, String state, String commType) {
        _type = type;
        _terminal = terminal;
        _client = client;
        _state = state;
        _commType = commType;
    }

    public String getType() {
        return this._type;
    }

    public Terminal getTerminal() {
        return this._terminal;
    }

    public Client getClient() {
        return this._client;
    }

    public String getState() {
        return this._state;
    }

    public String getCommType() {
        return this._commType;
    }

    public void setType(String type) {
        _type = type;
    }

    public void setTerminal(Terminal terminal) {
        _terminal = terminal;
    }

    public void setClient(Client client) {
        _client = client;
    }

    public void setState(String state) {
        _state = state;
    }

    public void setCommType(String commType) {
        _commType = commType;
    }

    public void allowsNotification() {
        _received = true;
    }

    public boolean canSendNotification() {
        return _received;
    }

    @Override
    public String toString() {
        return this._type + "|" + this._terminal.getId();
    }
}