package prr.app.lookups;

import prr.Network;
import pt.tecnico.uilib.menus.Command;
import pt.tecnico.uilib.menus.CommandException;
import prr.app.exceptions.UnknownClientKeyException;
import prr.exceptions.ClientDontExistException;

/**
 * Show communications from a client.
 */
class DoShowCommunicationsFromClient extends Command<Network> {

	DoShowCommunicationsFromClient(Network receiver) {
		super(Label.SHOW_COMMUNICATIONS_FROM_CLIENT, receiver);
		addStringField("key", Prompt.clientKey());
	}

	@Override
	protected final void execute() throws CommandException, UnknownClientKeyException{
		try{
			_display.popup(_receiver.communicationsFromClient(stringField("key")));
		} catch (ClientDontExistException e){
			throw new UnknownClientKeyException(stringField("key"));
		}
	}
}
