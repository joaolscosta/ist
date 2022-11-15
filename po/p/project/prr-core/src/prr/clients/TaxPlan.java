package prr.clients;

import prr.communications.Communication;
import prr.clients.Client;
import prr.exceptions.UnrecognizedEntryException;
import prr.terminals.Terminal;
import prr.Network;

public abstract class TaxPlan {

    public abstract double textCost(Terminal terminalSender, String message);

    public abstract double interactiveCost(Terminal terminalSender, Terminal terminalReceiver, String type, double duration);

    public abstract int getTextSize(String text);

    public abstract double calculateTextPrice(Terminal terminalSender, String text);

    public abstract double calculateUnder50(Terminal terminalSender);

    public abstract double calculateBetween(Terminal terminalSender);

    public abstract double calculateOver100(Terminal terminalSender, int units);

    public abstract double calculateVoice(Terminal terminalSender, Terminal terminalReceiver, double duration);

    public abstract double calculateVideo(Terminal terminalSender, Terminal terminalReceiver, double duration);

}
