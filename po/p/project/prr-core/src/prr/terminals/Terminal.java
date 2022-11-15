package prr.terminals;

import java.io.Serializable;
import java.util.Collection;
import java.util.Map;
import java.util.TreeMap;
import java.util.stream.Collectors;
import java.util.List;
import java.util.ArrayList;

import prr.clients.Client;
import prr.communications.Communication;
import prr.communications.Text;
import prr.communications.Video;
import prr.communications.Voice;
import prr.notifications.Notification;
import prr.notifications.OffToIdle;
import prr.notifications.OffToSilent;
import prr.exceptions.NoOnGoingCommunicationException;
import prr.notifications.SilentToIdle;
import prr.notifications.BusyToIdle;

/**
 * Abstract terminal.
 */
abstract public class Terminal implements Serializable {

        /** Serial number for serialization. */
        private static final long serialVersionUID = 202208091753L;
        private Map<String, Terminal> _friends = new TreeMap<>();
        private Map<Integer, Communication> _communications = new TreeMap<>();
        private List<Notification> _notifications = new ArrayList<>();
        private String _id;
        private String _clientId;
        private TerminalState _state;
        private TerminalState _oldState;
        private double _payments = 0;
        private double _debts = 0;

        public Terminal(String id, String clientId, String state) {
                this._id = id;
                this._clientId = clientId;
                switch (state) {
                        case "ON", "IDLE" -> _state = new IdleState(this);
                        case "OFF" -> _state = new OffState(this);
                        case "BUSY" -> _state = new BusyState(this);
                        case "SILENCE" -> _state = new SilenceState(this);
                }
        }

        public abstract boolean isBasicTerminal();
        
        public abstract boolean isFancyTerminal();

        public String getId() {
                return this._id;
        }

        public String getClientId() {
                return this._clientId;
        }

        public TerminalState getState() {
                return this._state;
        }

        public double getPayments() {
                return this._payments;
        }

        public double getDebts() {
                return this._debts;
        }

        public void setId(String id) {
                this._id = id;
        }

        public void setClientId(String clientId) {
                this._clientId = clientId;
        }

        public void setState(TerminalState state) {
                this._state = state;
        }

        public void setPayments(double payments) {
                _payments = payments;
        }

        public void setDebts(double debts) {
                _debts = debts;
        }

        public String printFriends() {
                String friends = "";
                if (!(_friends.isEmpty()))
                        friends += "|";
                for (String id : _friends.keySet()) {
                        if (!friends.equals("|"))
                                friends += ",";
                        friends += id;
                }
                return friends;
        }

        public void addFriend(Terminal terminal) {
                this._friends.put(terminal._id, terminal);
        }

        public void removeFriend(Terminal terminal) {
                this._friends.remove(terminal._id);
        }

        public boolean checkIfFriend(String terminalId) {
                if (_friends.get(terminalId) == null) {
                        return false;
                }
                return true;
        }

        public double terminalBalance() {
                return getPayments() - getDebts();
        }

        public void silenceTerminal() {
                this._state = new SilenceState(this);
                Notification notification = new Notification();
                Notification not = new Notification();
                Client client = new Client();
                for(int i = 0; i < _notifications.size(); i++){
                        if(_notifications.get(i).getState().equals("off") && _notifications.get(i).getCommType().equals("TEXT")){
                                notification = new OffToSilent(this, _notifications.get(i).getClient(), _notifications.get(i).getState(), _notifications.get(i).getCommType());
                                not = _notifications.get(i);
                                client =  _notifications.get(i).getClient();
                                client.receiveNotification(notification);

                        }
                }
                if(!not.getType().equals("")){
                        _notifications.remove(not);
                }
        }

        public void turnOffTerminal() {
                this._state = new OffState(this);
        }

        public void turnOnTerminal() {
                this._state = new IdleState(this);
                isToSendNotification();
        }

        public void setBusy(){
                this._state = new BusyState(this);
        }

        public void saveState(){
                this._oldState = this._state;
        }

        public void recoverState(){
                this._state = this._oldState;
                isToSendNotification();
        }

        public void isToSendNotification(){
                Notification notification = new Notification();
                Notification not = new Notification();
                Client client = new Client();
                for(int i = 0; i < _notifications.size(); i++){
                        if(_notifications.get(i).getState().equals("off")){
                                notification = new OffToIdle(this, _notifications.get(i).getClient(), _notifications.get(i).getState(), _notifications.get(i).getCommType());
                                not = _notifications.get(i);
                                client = not.getClient();
                                client.receiveNotification(notification);

                        } else if (_notifications.get(i).getState().equals("busy")){
                                notification = new BusyToIdle(this, _notifications.get(i).getClient(), _notifications.get(i).getState(), _notifications.get(i).getCommType());
                                not = _notifications.get(i);
                                client = not.getClient();
                                client.receiveNotification(notification);


                        } else if(_notifications.get(i).getState().equals("silence")){
                                notification = new SilentToIdle(this, _notifications.get(i).getClient(), _notifications.get(i).getState(), _notifications.get(i).getCommType());
                                not = _notifications.get(i);
                                client = not.getClient();
                                client.receiveNotification(notification);


                        }
                }
                if(!not.getType().equals("")){
                        _notifications.remove(not);
                }

        }

        public void updateNot(){
                for(int i = 0; i < _notifications.size(); i++){
                        _notifications.get(i).setState(stateToString());;
                }
        }

        public void perfomPaymentTerminal(int commId, Communication comm) {
                double debt = getDebts();
                double payment = getPayments();
                debt -= comm.getPrice();
                payment += comm.getPrice();
                setDebts(debt);
                setPayments(payment);
        }

        public void upgradePriceDurationComm(int idComm, double price, double duration){
		_communications.get(idComm).setPrice(price);
		_communications.get(idComm).setDuration(duration);
	}

        public Communication startInteractiveCommunication(String idDest, int idComm, String type) {
                if(type.equals("VOICE")){
                        Communication comm = startVoice(idComm, this.getId(), idDest, 0, 0, "ONGOING");
                        return comm;
                }
                else{
                        Communication comm = startVideo(idComm, this.getId(), idDest, 0, 0, "ONGOING");
                        return comm;
                }
        }

        public Communication startVideo(int idComm, String idOrig, String idDest, int units, double price, String status){
                Communication comm = new Video(idComm, this.getId(), idDest, 0, 0, "ONGOING");
                addCommunication(comm);
                return comm;
        }

        public Communication startVoice(int idComm, String idOrig, String idDest, int units, double price, String status){
                Communication comm = new Voice(idComm, this.getId(), idDest, 0, 0, "ONGOING");
                addCommunication(comm);
                return comm;
        }


        public void endInteractiveCommunication(int idComm) {
                for (int commId : _communications.keySet())
                        if (idComm == commId){
                                _communications.get(idComm).finishCommunication();
                        }
        }

        public Collection<Communication> showOngoingCommunication() throws NoOnGoingCommunicationException {
                boolean ongoing = false;
                for (int commId : _communications.keySet())
                        if (_communications.get(commId).getStatus().equals("ONGOING"))
                                ongoing = true;
                if (ongoing == false)
                        throw new NoOnGoingCommunicationException();
                return getAllCommunications().stream().filter(comm -> comm.getStatus().equals("ONGOING"))
                                .collect(Collectors.toList());

        }

        public Communication sendTextCommunication(String idDest, String text, int units, double price, int idComm) {
                Communication comm = new Text(idComm, this.getId(), idDest, units, price, "FINISHED");
                addCommunication(comm);
                return comm;

        }

        public void addCommunication(Communication communication) {
                _communications.put(communication.getId(), communication);
        }

        public Collection<Communication> getAllCommunications() {
                return _communications.values();
        }

        /**
         * Checks if this terminal can end the current interactive communication.
         *
         * @return true if this terminal is busy (i.e., it has an active interactive
         *         communication) and
         *         it was the originator of this communication.
         **/
        public boolean canEndCurrentCommunication() {
                boolean ongoing = false;
                for (int commId : _communications.keySet())
                        if (_communications.get(commId).getStatus().equals("ONGOING"))
                                ongoing = true;
                return ongoing;
        }

        /**
         * Checks if this terminal can start a new communication.
         *
         * @return true if this terminal is neither off neither busy, false otherwise.
         **/
        public boolean canStartCommunication() {
                if (this.getState().isOffState())
                        return false;
                else if(this.getState().isBusyState())
                        return false;
                try {
                        showOngoingCommunication();
                } catch (NoOnGoingCommunicationException e) {
                        return true;
                }
                return false;

        }


        public String stateToString(){
                if(getState().isBusyState()){
                        return "busy";
                }
                else if(getState().isIdleState()){
                        return "idle";
                }
                else if(getState().isOffState()){
                        return "off";
                }
                else {
                        return "silence";
                }

        }

        public void sendNotification(Client client, String commType){
                Notification not = new Notification("unknown", this, client, stateToString(), commType);
                _notifications.add(not);
        }

        public int doubleToInt(double number) {
                int value = (int) number;
                return value;
        }

        @Override

        public String toString() {
                return "|" + this.getId() + "|" + this.getClientId() + "|" + (this.getState()).toString() +
                                "|" + doubleToInt(this.getPayments()) + "|" + doubleToInt(this.getDebts())
                                + this.printFriends();
        }
}
