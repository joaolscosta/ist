package prr.app.terminals;

import prr.Network;
import prr.app.exceptions.UnknownTerminalKeyException;
import prr.exceptions.TerminalDontExistException;
import pt.tecnico.uilib.menus.Command;
import pt.tecnico.uilib.menus.CommandException;

/**
 * Open a specific terminal's menu.
 */
class DoOpenMenuTerminalConsole extends Command<Network> {

	DoOpenMenuTerminalConsole(Network receiver) {
		super(Label.OPEN_MENU_TERMINAL, receiver);
		addStringField("terminalKey", Prompt.terminalKey());
	}

	@Override
	protected final void execute() throws CommandException, UnknownTerminalKeyException {
	 	try{
			(new prr.app.terminal.Menu(_receiver, _receiver.getTerminal(stringField("terminalKey")))).open();         
		} catch (TerminalDontExistException e){
			throw new UnknownTerminalKeyException(stringField("terminalKey"));
		}
		
		
	}
}
