package prr.app.terminal;

import prr.Network;
import prr.app.exceptions.UnknownTerminalKeyException;
import prr.exceptions.TerminalDontExistException;
import prr.exceptions.UnsupportedAtOriginException;
import prr.terminals.Terminal;
import pt.tecnico.uilib.menus.CommandException;

/**
 * Add a friend.
 */
class DoAddFriend extends TerminalCommand {

	DoAddFriend(Network context, Terminal terminal) {
		super(Label.ADD_FRIEND, context, terminal);
		addStringField("terminalKey", Prompt.terminalKey());
	}

	@Override
	protected final void execute() throws CommandException {
		try{
			_network.addFriendToTerminal(_receiver, stringField("terminalKey"));
		} catch (TerminalDontExistException e){
			throw new UnknownTerminalKeyException(stringField("terminalKey"));
		} catch (UnsupportedAtOriginException e){
		}
	}
}
