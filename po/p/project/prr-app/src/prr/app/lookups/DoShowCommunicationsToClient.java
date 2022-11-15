package prr.app.lookups;

import prr.Network;
import prr.app.exceptions.UnknownClientKeyException;
import prr.exceptions.ClientDontExistException;
import pt.tecnico.uilib.menus.Command;
import pt.tecnico.uilib.menus.CommandException;
//FIXME add more imports if needed

/**
 * Show communications to a client.
 */
class DoShowCommunicationsToClient extends Command<Network> {

	DoShowCommunicationsToClient(Network receiver) {
		super(Label.SHOW_COMMUNICATIONS_TO_CLIENT, receiver);
		addStringField("key", Prompt.clientKey());
	}

	@Override
	protected final void execute() throws CommandException, UnknownClientKeyException {
		try{
			_display.popup(_receiver.communicationsToClient(stringField("key")));
		} catch (ClientDontExistException e){
			throw new UnknownClientKeyException(stringField("key"));
		}	}
}
