package prr.clients;

import java.io.Serializable;
import java.util.List;
import java.util.ArrayList;
import java.util.Collection;

import prr.exceptions.NotificationAlreadyDisabledException;
import prr.exceptions.NotificationAlreadyEnabledException;
import prr.notifications.Notification;
import prr.notifications.BusyToIdle;
import prr.notifications.SilentToIdle;
import prr.terminals.BusyState;
import prr.terminals.IdleState;
import prr.terminals.SilenceState;
import prr.terminals.Terminal;
import prr.communications.Communication;

public class Client implements Serializable {

    String CLIENT = "CLIENT";
    String YES = "YES";
    String NO = "NO";

    private String _id;
    private String _name;
    private int _taxId;
    private SelectStatute _type;
    private String _notOnOff = YES;
    private int _terminals = 0;
    private double _payments = 0;
    private double _debts = 0;
    private List<Notification> _notifications = new ArrayList<>();
    private List<Notification> _notificationsSent = new ArrayList<>();


    /**
     * @param id
     * @param name
     * @param taxId
     */

    public Client(String id, String name, int taxId) {
        _id = id;
        _name = name;
        _taxId = taxId;
        _type = new NormalClient(this);
    }

    public Client(){//do nothing
    }

    public String getId() {
        return this._id;
    }

    public String getName() {
        return this._name;
    }

    public int getTaxId() {
        return this._taxId;
    }

    public SelectStatute getType() {
        return this._type;
    }

    public String getNotifications() {
        return this._notOnOff;
    }

    public int getTerminals() {
        return this._terminals;
    }

    public double getPayments() {
        return this._payments;
    }

    public double getDebts() {
        return this._debts;
    }

    public void addTerminal() {
        this._terminals++;
    }

    public void setDebts(double debts){
        this._debts = debts;
    }

    public void setPayments(double payments){
        this._payments = payments;
    }

    public void NowNormal(){
        this._type = new NormalClient(this);
    }

    public void NowGold(){
        this._type = new GoldClient(this);
    }

    public void NowPlatinum(){
        this._type = new PlatinumClient(this);
    }

    public void NowVip(){
        this._type = new VipClient(this);
    }

    public boolean withDebts() {
        return getDebts() != 0;
    }

    public boolean withoutDebts() {
        return getDebts() == 0;
    }

    public boolean notificationsOn() {
        return _notOnOff.equals("YES");
    }

    public double getBalance(){
        return getPayments() - getDebts();
    }

    public void disableNotifications() throws NotificationAlreadyDisabledException {
        if (_notOnOff.equals(NO))
            throw new NotificationAlreadyDisabledException();
        this._notOnOff = NO;
    }

    public void enableNotifications() throws NotificationAlreadyEnabledException {
        if (_notOnOff.equals(YES))
            throw new NotificationAlreadyEnabledException();
        this._notOnOff = YES;
    }

    public void receiveNotification(Notification not){
        boolean repeated = false;
        for(int i = 0; i < _notifications.size(); i++){
            if(_notifications.get(i).getType().equals(not.getType()) && 
            _notifications.get(i).getTerminal().getId().equals(not.getTerminal().getId()))
                repeated = true;
        }
        if (!repeated)
            _notifications.add(not);
    }

    public void perfomPaymentClient(int commId, Communication comm) {
        double debt = getDebts();
        double payment = getPayments();
        debt -= comm.getPrice();
        payment += comm.getPrice();
        setDebts(debt);
        setPayments(payment);
    }

    public int doubleToInt(double number) {
        int value = (int) number;
        return value;
    }

    public Collection<Notification> getClientNotifications(){
        _notificationsSent.clear();
        for(int i = 0; i < _notifications.size(); i++){
            _notificationsSent.add(_notifications.get(i));
        }
        this._notifications.clear();
        return _notificationsSent;
    }

    public int getAveragePayments(){
        return doubleToInt((this.getPayments() / this._terminals));
    }

    @Override

    public String toString() {
        return CLIENT + "|" + this.getId() + "|" + this.getName() + "|" + this.getTaxId() + "|" + this.getType() + "|"
                + this.getNotifications() +
                "|" + this.getTerminals() + "|" + doubleToInt(this.getPayments()) + "|" + doubleToInt(this.getDebts()) + "|"
                 + getAveragePayments(); 
        
    }

}
