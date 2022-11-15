package prr.app.lookups;

import prr.Network;
import pt.tecnico.uilib.menus.Command;
import pt.tecnico.uilib.menus.CommandException;
//FIXME more imports if needed

/**
 * Show clients with negative balance.
 */
class DoGetLowestPayment extends Command<Network> {

	DoGetLowestPayment(Network receiver) {
		super(Label.SHOW_LOWEST_CLIENT_PAYMENT, receiver);
	}

	@Override
	protected final void execute() throws CommandException {
		_display.popup(_receiver.getLowestPayment());
	}
}