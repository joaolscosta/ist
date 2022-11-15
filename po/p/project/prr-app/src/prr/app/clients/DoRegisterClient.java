package prr.app.clients;

import prr.Network;
import prr.app.exceptions.DuplicateClientKeyException;
import prr.exceptions.ClientAlreadyExistException;
import prr.exceptions.ClientDontExistException;
import pt.tecnico.uilib.forms.Form;
import pt.tecnico.uilib.menus.Command;
import pt.tecnico.uilib.menus.CommandException;
//FIXME add more imports if needed

/**
 * Register new client.
 */
class DoRegisterClient extends Command<Network> {

	DoRegisterClient(Network receiver) {
		super(Label.REGISTER_CLIENT, receiver);
	}

	@Override
	protected final void execute() throws CommandException {
		
		Form request = new Form();
		request.addStringField("key", Prompt.key());
		request.addStringField("name", Prompt.name());
		request.addStringField("taxId", Prompt.taxId());
		request.parse();
		
		try{
			_receiver.registerClient(request.stringField("key"),
			request.stringField("name"), request.stringField("taxId"));
		} catch (ClientAlreadyExistException e){	
			throw new DuplicateClientKeyException(request.stringField("key"));
		}
		
		
			
	}

}
