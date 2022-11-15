package prr.app.terminal;

import prr.Network;
import prr.terminals.Terminal;
import pt.tecnico.uilib.menus.CommandException;

/**
 * Show balance.
 */
class DoShowTerminalBalance extends TerminalCommand {

	DoShowTerminalBalance(Network context, Terminal terminal) {
		super(Label.SHOW_BALANCE, context, terminal);
	}

	@Override
	protected final void execute() throws CommandException {
		String id = _network.getTerminalId(_receiver);
		_display.popup(Message.terminalPaymentsAndDebts(id, _network.getTerminalPayments(id), _network.getTerminalDebts(id)));
	}
}
