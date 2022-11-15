package prr.app.terminals;

import prr.Network;
import prr.app.exceptions.DuplicateTerminalKeyException;
import prr.app.exceptions.InvalidTerminalKeyException;
import prr.app.exceptions.UnknownClientKeyException;
import prr.exceptions.ClientDontExistException;
import prr.exceptions.TerminalAlreadyExistException;
import prr.exceptions.TerminalDontExistException;
import pt.tecnico.uilib.forms.Form;
import pt.tecnico.uilib.menus.Command;
import pt.tecnico.uilib.menus.CommandException;

/**
 * Register terminal.
 */
class DoRegisterTerminal extends Command<Network> {

	DoRegisterTerminal(Network receiver) {
		super(Label.REGISTER_TERMINAL, receiver);
	}

	@Override
	protected final void execute() throws CommandException, UnknownClientKeyException, InvalidTerminalKeyException, DuplicateTerminalKeyException {
		Form request = new Form();
		request.addStringField("terminalKey", Prompt.terminalKey());
		request.addOptionField("terminalType", Prompt.terminalType(), "BASIC", "FANCY");
		request.addStringField("clientKey", Prompt.clientKey());
		request.parse();

		try{
			_receiver.clientExists(request.stringField("clientKey"));
		} catch (ClientDontExistException e){
			throw new UnknownClientKeyException(request.stringField("clientKey"));
		}
		
		if(!((request.stringField("terminalKey")).matches("\\d{6}")))
			throw new InvalidTerminalKeyException(request.stringField("terminalKey"));
			
		try{
			_receiver.registerTerminal(request.stringField("terminalType"), request.stringField("terminalKey"),
			request.stringField("clientKey"), "ON");
		} catch (TerminalAlreadyExistException e){	
			throw new DuplicateTerminalKeyException(request.stringField("terminalKey"));
		}
		

	}
}
