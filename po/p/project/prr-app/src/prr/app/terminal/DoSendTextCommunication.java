package prr.app.terminal;

import prr.Network;
import prr.terminals.Terminal;
import prr.app.exceptions.UnknownTerminalKeyException;
import prr.exceptions.DestinationTerminalOffException;
import prr.exceptions.TerminalDontExistException;
import pt.tecnico.uilib.forms.Form;
import pt.tecnico.uilib.menus.CommandException;
//FIXME add more imports if needed

/**
 * Command for sending a text communication.
 */
class DoSendTextCommunication extends TerminalCommand {

        DoSendTextCommunication(Network context, Terminal terminal) {
                super(Label.SEND_TEXT_COMMUNICATION, context, terminal, receiver -> receiver.canStartCommunication());
        }

        @Override
        protected final void execute() throws CommandException, UnknownTerminalKeyException {
                Form request = new Form();
                request.addStringField("terminalKey", Prompt.terminalKey());
                request.addStringField("text", Prompt.textMessage());
                request.parse();

                try{
                        _network.sendTextCommunication(request.stringField("terminalKey"), _network.getTerminalId(_receiver), request.stringField("text"));
                } catch(DestinationTerminalOffException e){
                        _display.popup(Message.destinationIsOff(request.stringField("terminalKey")));
                } catch(TerminalDontExistException e){
                        throw new UnknownTerminalKeyException(request.stringField("terminalKey"));
                }
        }
} 
