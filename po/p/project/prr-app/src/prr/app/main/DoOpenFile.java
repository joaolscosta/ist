package prr.app.main;

import prr.NetworkManager;
import prr.app.exceptions.FileOpenFailedException;
import prr.exceptions.UnavailableFileException;
//Add more imports if needed------------------------------------------------------
import pt.tecnico.uilib.forms.Form;
import pt.tecnico.uilib.menus.Command;
import pt.tecnico.uilib.menus.CommandException;

/**
 * Command to open a file.
 */
class DoOpenFile extends Command<NetworkManager> {

	DoOpenFile(NetworkManager receiver) {
		super(Label.OPEN_FILE, receiver);
                
                //FIXME add command fields----------------------------------------------
	}

	@Override
	protected final void execute() throws CommandException {
                
                try {
                        if(_receiver.changed() && Form.confirm(Prompt.saveBeforeExit())){
                                DoOpenFile cmd = new DoOpenFile(_receiver);
                                cmd.execute();
                        }
                        _receiver.load(Form.requestString(Prompt.openFile()));
                        //FIXME implement command------------------------------------------
                } catch (UnavailableFileException e) {
                        throw new FileOpenFailedException(e);
                }

	}
}
