package prr.app.clients;

import prr.Network;
import prr.app.exceptions.UnknownClientKeyException;
import prr.exceptions.ClientDontExistException;
import prr.exceptions.NotificationAlreadyEnabledException;
import pt.tecnico.uilib.menus.Command;
import pt.tecnico.uilib.menus.CommandException;

/**
 * Enable client notifications.
 */
class DoEnableClientNotifications extends Command<Network> {

	DoEnableClientNotifications(Network receiver) {
		super(Label.ENABLE_CLIENT_NOTIFICATIONS, receiver);
		addStringField("key", Prompt.key());
	}

	@Override
	protected final void execute() throws CommandException, UnknownClientKeyException {
		try{
			_receiver.enableClientNotifications(stringField("key"));
		} catch (ClientDontExistException e) {
			throw new UnknownClientKeyException(stringField("key"));
		} catch (NotificationAlreadyEnabledException e){
			_display.popup(Message.clientNotificationsAlreadyEnabled());
		}
	}
}
