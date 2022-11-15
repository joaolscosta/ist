package prr.app.clients;

import prr.Network;
import prr.app.exceptions.UnknownClientKeyException;
import prr.exceptions.ClientDontExistException;
import prr.exceptions.NotificationAlreadyDisabledException;
import pt.tecnico.uilib.menus.Command;
import pt.tecnico.uilib.menus.CommandException;

/**
 * Disable client notifications.
 */
class DoDisableClientNotifications extends Command<Network> {

	DoDisableClientNotifications(Network receiver) {
		super(Label.DISABLE_CLIENT_NOTIFICATIONS, receiver);
		addStringField("key", Prompt.key());
		
	}

	@Override
	protected final void execute() throws CommandException, UnknownClientKeyException {
		try{
			_receiver.disableClientNotifications(stringField("key"));
		} catch (ClientDontExistException e) {
			throw new UnknownClientKeyException(stringField("key"));
		} catch (NotificationAlreadyDisabledException e){
			_display.popup(Message.clientNotificationsAlreadyDisabled());
		}

	}
}
