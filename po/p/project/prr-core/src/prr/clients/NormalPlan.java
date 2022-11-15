package prr.clients;

import java.time.Duration;

import prr.terminals.Terminal;

public class NormalPlan extends TaxPlan {

    public double textCost(Terminal terminalSender, String message) {
        return calculateTextPrice(terminalSender, message);
    }

    public double interactiveCost(Terminal terminalSender, Terminal terminalReceiver, String type, double duration) {
        double price = 0;
        switch (type) {
            case "VOICE" -> price = calculateVoice(terminalSender, terminalReceiver, duration);
            case "VIDEO" -> price = calculateVideo(terminalSender, terminalReceiver, duration);
        }
        return price;
    }

    public int getTextSize(String text) {
        return text.length();
    }

    public double calculateTextPrice(Terminal terminalSender, String text) {
        int units = getTextSize(text);
        if (units < 50) {
            return calculateUnder50(terminalSender);
        } else if (units >= 50 && units < 100) {
            return calculateBetween(terminalSender);
        } else {
            return calculateOver100(terminalSender, units);
        }

    }

    public double calculateUnder50(Terminal terminalSender) {
        double price = 10;
        return price;

    }

    public double calculateBetween(Terminal terminalSender) {
        double price = 16;
        return price;
    }

    public double calculateOver100(Terminal terminalSender, int units) {
        double price = (2 * units);
        return price;
    }

    public double calculateVoice(Terminal terminalSender, Terminal terminalReceiver, double duration) {
        double price = 20;
        if (terminalSender.checkIfFriend(terminalReceiver.getId())) {
            price *= 0.5;
        }
        price *= duration;
        return price;
    }

    public double calculateVideo(Terminal terminalSender, Terminal terminalReceiver, double duration) {
        double price = 30;
        if (terminalSender.checkIfFriend(terminalReceiver.getId())) {
            price *= 0.5;
        }
        price *= duration;
        return price;
    }

}
