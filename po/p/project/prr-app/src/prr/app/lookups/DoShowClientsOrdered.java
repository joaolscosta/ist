package prr.app.lookups;

import prr.Network;
import pt.tecnico.uilib.menus.Command;
import pt.tecnico.uilib.menus.CommandException;

/**
 * Command for showing all communications.
 */
class DoShowClientsOrdered extends Command<Network> {

	DoShowClientsOfType(Network receiver) {
		super(Label.SHOW_CLIENTS_OF_TYPE, receiver);
	}

	@Override
	protected final void execute() throws CommandException {
		_display.popup(_receiver.showClientsOrdered());
	}
}
