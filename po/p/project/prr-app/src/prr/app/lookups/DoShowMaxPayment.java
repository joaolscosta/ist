package prr.app.lookups;

import prr.Network;
import pt.tecnico.uilib.menus.Command;
import pt.tecnico.uilib.menus.CommandException;
//FIXME more imports if needed

/**
 * Show clients with negative balance.
 */
class DoShowMaxPayment extends Command<Network> {

	DoShowMaxPayment(Network receiver) {
		super(Label.SHOW_MAX_TERMINAL_PAYMENT, receiver);
	}

	@Override
	protected final void execute() throws CommandException {
        _display.popup(_receiver.showMaxPayment());
	}
}