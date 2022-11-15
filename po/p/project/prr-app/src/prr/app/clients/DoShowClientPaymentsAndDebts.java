package prr.app.clients;

import prr.Network;
import prr.app.exceptions.UnknownClientKeyException;
import prr.app.exceptions.UnknownTerminalKeyException;
import prr.exceptions.ClientDontExistException;
import prr.exceptions.*;
import pt.tecnico.uilib.menus.Command;
import pt.tecnico.uilib.menus.CommandException;

/**
 * Show the payments and debts of a client.
 */
class DoShowClientPaymentsAndDebts extends Command<Network> {

	DoShowClientPaymentsAndDebts(Network receiver) {
		super(Label.SHOW_CLIENT_BALANCE, receiver);
		addStringField("key", Prompt.key());
	}

	@Override
	protected final void execute() throws CommandException {
        try{
			_display.popup(Message.clientPaymentsAndDebts(stringField("key"), 
			_receiver.getPayments(stringField("key")), _receiver.getDebts(stringField("key"))));
		} catch (ClientDontExistException e){
			throw new UnknownClientKeyException(stringField("key"));
		}
	}
}
