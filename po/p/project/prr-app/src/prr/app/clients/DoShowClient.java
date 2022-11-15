package prr.app.clients;

import prr.Network;
import prr.app.exceptions.UnknownClientKeyException;
import prr.exceptions.ClientAlreadyExistException;
import prr.exceptions.ClientDontExistException;
import pt.tecnico.uilib.menus.Command;
import pt.tecnico.uilib.menus.CommandException;

/**
 * Show specific client: also show previous notifications.
 */
class DoShowClient extends Command<Network> {

	DoShowClient(Network receiver) {
		super(Label.SHOW_CLIENT, receiver);
		addStringField("key", Prompt.key());
	}

	@Override
	protected final void execute() throws CommandException, UnknownClientKeyException{
        try{
			_display.popup(_receiver.getClient(stringField("key")));
			_display.popup(_receiver.getClientNotifications(stringField("key")));
		} catch (ClientDontExistException e1){
			throw new UnknownClientKeyException(stringField("key"));
		}

	}
}
