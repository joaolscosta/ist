package prr.app.terminal;

import prr.Network;
import prr.app.exceptions.UnknownTerminalKeyException;
import prr.exceptions.DestinationTerminalBusyException;
import prr.exceptions.DestinationTerminalOffException;
import prr.exceptions.DestinationTerminalSilentException;
import prr.exceptions.TerminalDontExistException;
import prr.exceptions.UnsupportedAtDestinationException;
import prr.exceptions.UnsupportedAtOriginException;
import prr.terminals.Terminal;
import pt.tecnico.uilib.forms.Form;
import pt.tecnico.uilib.menus.CommandException;
//FIXME add more imports if needed

/**
 * Command for starting communication.
 */
class DoStartInteractiveCommunication extends TerminalCommand {

	DoStartInteractiveCommunication(Network context, Terminal terminal) {
		super(Label.START_INTERACTIVE_COMMUNICATION, context, terminal, receiver -> receiver.canStartCommunication());
	}

	@Override
	protected final void execute() throws CommandException, UnknownTerminalKeyException {
		Form request = new Form();
		request.addStringField("terminalKey", Prompt.terminalKey());
		request.addOptionField("commType", Prompt.commType(), "VOICE", "VIDEO");
		request.parse();
		try{
			_network.startInteractiveCommunication(request.stringField("terminalKey"),_network.getTerminalId(_receiver) , request.optionField("commType"));
		} catch(DestinationTerminalOffException e){
			_display.popup(Message.destinationIsOff(request.stringField("terminalKey")));
		} catch(DestinationTerminalBusyException e){ //when its busy and when tries to do it with himself
			_display.popup(Message.destinationIsBusy(request.stringField("terminalKey")));
		} catch(DestinationTerminalSilentException e){
			_display.popup(Message.destinationIsSilent(request.stringField("terminalKey")));
		} catch(UnsupportedAtDestinationException e){
			_display.popup(Message.unsupportedAtDestination(request.stringField("terminalKey"), request.optionField("commType")));
		} catch(UnsupportedAtOriginException e){
			_display.popup(Message.unsupportedAtOrigin(_network.getTerminalId(_receiver), request.optionField("commType")));
		} catch(TerminalDontExistException e){
			throw new UnknownTerminalKeyException(request.stringField("terminalKey"));
		}
	}
}
