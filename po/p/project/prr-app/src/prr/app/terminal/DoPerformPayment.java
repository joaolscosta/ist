package prr.app.terminal;

import prr.Network;
import prr.terminals.Terminal;
import pt.tecnico.uilib.menus.CommandException;
import prr.exceptions.CommunicationDoesNotExistException;
// Add more imports if needed

/**
 * Perform payment.
 */
class DoPerformPayment extends TerminalCommand {

	DoPerformPayment(Network context, Terminal terminal) {
		super(Label.PERFORM_PAYMENT, context, terminal);
		addStringField("commKey", Prompt.commKey());
	}

	@Override
	protected final void execute() throws CommandException {
		try {
			_network.performPayment(_receiver, stringField("commKey"));
		} catch (CommunicationDoesNotExistException e) {
			_display.popup(Message.invalidCommunication());
		}
	}
}
