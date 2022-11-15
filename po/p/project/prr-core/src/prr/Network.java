package prr;

import java.io.Serializable;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.FileReader;

import java.util.Map;
import java.util.TreeMap;
import java.util.Map.Entry;

import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.ArrayList;
import java.util.stream.Collectors;

import prr.clients.Client;
import prr.clients.NormalClient;
import prr.clients.NormalPlan;
import prr.clients.PlatinumClient;
import prr.clients.PlatinumPlan;
import prr.clients.GoldClient;
import prr.clients.SelectStatute;
import prr.clients.GoldPlan;
import prr.communications.Communication;
import prr.exceptions.CommunicationDoesNotExistException;
import prr.exceptions.DestinationTerminalBusyException;
import prr.exceptions.DestinationTerminalOffException;
import prr.terminals.BasicTerminal;
import prr.terminals.IdleState;
import prr.terminals.OffState;
import prr.terminals.SilenceState;
import prr.terminals.BusyState;
import prr.terminals.TerminalState;
import prr.terminals.Terminal;
import prr.terminals.BasicTerminal;
import prr.terminals.FancyTerminal;
import prr.exceptions.ClientDontExistException;
import prr.exceptions.ClientAlreadyExistException;
import prr.exceptions.TerminalAlreadyExistException;
import prr.exceptions.TerminalDontExistException;
import prr.exceptions.ImportFileException;
import prr.exceptions.MissingFileAssociationException;
import prr.exceptions.NoOnGoingCommunicationException;
import prr.exceptions.NotificationAlreadyDisabledException;
import prr.exceptions.NotificationAlreadyEnabledException;
import prr.exceptions.UnavailableFileException;
import prr.exceptions.UnrecognizedEntryException;
import prr.exceptions.UnsupportedAtDestinationException;
import prr.exceptions.UnsupportedAtOriginException;
import prr.notifications.Notification;
import prr.exceptions.DestinationTerminalOnException;
import prr.exceptions.DestinationTerminalSilentException;

/**
 * Class Store implements a store.
 */
public class Network implements Serializable {

	/** Serial number for serialization. */
	private static final long serialVersionUID = 202208091753L;
	private boolean _changed = false;
	private Map<String, Client> _clients = new TreeMap<>(String.CASE_INSENSITIVE_ORDER);
	private Map<String, Terminal> _terminals = new TreeMap<>();
	private Map<Integer, Communication> _communications = new TreeMap<>();
	private Map<String, Terminal> _inactiveTerminals = new TreeMap<>();

	/**
	 * changes _changed to true
	 */
	public void changed() {
		setChanged(true);
	}

	/**
	 * @return variable _changed
	 */
	public boolean hasChanged() {
		return _changed;
	}

	/**
	 * @param changed
	 */
	public void setChanged(boolean changed) {
		_changed = changed;
	}

	/**
	 * Read text input file and create corresponding domain entities.
	 * 
	 * @param filename name of the text input file
	 * @throws UnrecognizedEntryException if some entry is not correct
	 * @throws IOException                if there is an IO erro while processing
	 *                                    the text file
	 * @throws ImportFileException        if the file cant be imported
	 */
	public void importFile(String filename) throws UnrecognizedEntryException, IOException, ImportFileException {

		try (BufferedReader reader = new BufferedReader(new FileReader(filename))) {
			String line;
			while ((line = reader.readLine()) != null) {
				String[] fields = line.split("\\|");
				try {
					registerEntry(fields);
				} catch (UnrecognizedEntryException | ClientAlreadyExistException | TerminalAlreadyExistException
						| TerminalDontExistException | UnsupportedAtOriginException e) {
					e.printStackTrace();
				}
			}
		} catch (IOException e1) {
			throw new ImportFileException(filename);
		}
	}

	/**
	 * @param fields fields introduced by the user
	 * @throws UnrecognizedEntryException if some entry is not correct
	 */
	public void registerEntry(String[] fields) throws UnrecognizedEntryException, ClientAlreadyExistException,
			TerminalAlreadyExistException, TerminalDontExistException, UnsupportedAtOriginException {

		switch (fields[0]) {
			case "CLIENT" -> registerClient(fields[1], fields[2], fields[3]);
			case "BASIC", "FANCY" -> registerTerminal(fields[0], fields[1], fields[2], fields[3]);
			case "FRIENDS" -> registerFriends(fields[1], fields[2]);
			default -> throw new UnrecognizedEntryException(fields[0]);
		}

	}

	/*************************************************************************
	 * 
	 * CLIENTS
	 * 
	 ************************************************************************/

	/**
	 * @param id
	 * @param name
	 * @param taxId
	 */
	public void registerClient(String id, String name, String taxId) throws ClientAlreadyExistException {
		duplicateClient(id);
		int _taxId = Integer.parseInt(taxId);
		Client client = new Client(id, name, _taxId);
		addClient(id, client);
	}

	/**
	 * @param id
	 * @param client
	 */
	public void addClient(String id, Client client) {
		_clients.put(id, client);
	}

	/**
	 * @param id client id
	 * @throws ClientAlreadyExistException if there is already a client registered
	 *                                     with that id
	 */
	public void duplicateClient(String id) throws ClientAlreadyExistException {
		if (_clients.get(id) != null) {
			throw new ClientAlreadyExistException();
		}
	}

	/**
	 * @param id client id
	 * @throws ClientDontExistException if there is not a client registered with
	 *                                  that id
	 */
	public void clientExists(String id) throws ClientDontExistException {
		if (_clients.get(id) == null) {
			throw new ClientDontExistException();
		}
	}

	/**
	 * @param clientId
	 * @throws ClientDontExistException
	 * @return the client with the given id
	 */
	public Client getClient(String clientId) throws ClientDontExistException {
		clientExists(clientId);
		return _clients.get(clientId);
	}

	/**
	 * @return all the clients registered
	 */
	public Collection<Client> getAllClients() {
		return _clients.values();
	}

	/**
	 * @return client with positive debts
	 */
	public Collection<Client> getClientsWithDebts() {
		return getAllClients().stream().collect(Collectors.toList());
	}

	/**
	 * @return client with positive debts
	 */
	public Collection<Client> clientsWithDebts() {
		return getAllClients().stream().filter(client -> client.withDebts()).collect(Collectors.toList());
	}

	/**
	 * @return client with no debts
	 */
	public Collection<Client> clientsWithoutDebts() {
		return getAllClients().stream().filter(client -> client.withoutDebts()).collect(Collectors.toList());
	}

	/**
	 * @param id client id
	 * @throws ClientDontExistException
	 * @return the client debts
	 */
	public int getDebts(String id) throws ClientDontExistException {
		clientExists(id);
		return doubleToInt(_clients.get(id).getDebts());
	}

	/**
	 * @param id client id
	 * @throws ClientDontExistException
	 * @return the client payments
	 */
	public int getPayments(String id) throws ClientDontExistException {
		clientExists(id);
		return doubleToInt(_clients.get(id).getPayments());
	}

	/**
	 * @param client
	 * @return check if client is a normal client
	 */
	public boolean isNormalClient(Client client) {
		if (client.getType().isNormalClient())
			return true;
		return false;
	}

	/**
	 * @param client
	 * @return check if client is a gold client
	 */
	public boolean isGoldClient(Client client) {
		if (client.getType().isGoldClient())
			return true;
		return false;
	}

	/**
	 * @param client
	 * @return check if client is a platinum client
	 */
	public boolean isPlatinumClient(Client client) {
		if (client.getType().isPlatinumClient())
			return true;
		return false;
	}

	public boolean isVipClient(Client client) {
		if (client.getType().isVipClient())
			return true;
		return false;
	}

	/**
	 * @param client
	 * @param debt   debt of the client
	 */
	public void updateDebtsClient(Client client, double debt) {
		double debts = client.getDebts();
		debts += debt;
		client.setDebts(debts);
	}

	/**
	 * @param client
	 */
	public void normalToGold(Client client) {
		if (isNormalClient(client) && client.getBalance() > 500)
			client.NowGold();
	}

	/**
	 * @param client
	 */
	public void goldToNormal(Client client) {
		if (isGoldClient(client) && client.getBalance() < 0)
			client.NowNormal();
	}

	/**
	 * @param client
	 */
	public void platinumToNormal(Client client) {
		if (isPlatinumClient(client) && client.getBalance() < 0)
			client.NowNormal();
	}

	/**
	 * @param client
	 */
	public void goldToPlatinum(Client client) {

		if (isGoldClient(client)) {

			int size = _communications.size();
			if (size > 5) {
				int count = 0;
				boolean goal = false;
				for (int i = size; i > 0; i--) {
					if (_terminals.get(_communications.get(i).getIdSender()).getClientId().equals(client.getId())) {
						if (_communications.get(i).getType().equals("VIDEO")) {
							count++;

							if (count == 5) {
								goal = true;
							}
						}
					} else {
						count = 0;
					}
				}
				if (goal && client.getBalance() > 0)
					client.NowPlatinum();
			}

		}

	}

	/**
	 * @param client
	 */
	public void platinumToGold(Client client) {
		if (isPlatinumClient(client)) {
			int size = _communications.size();
			if (size > 2) {
				int count = 0;
				boolean goal = false;
				for (int i = size; i > 0; i--) {
					if (_terminals.get(_communications.get(i).getIdSender()).getClientId().equals(client.getId())) {
						if (_communications.get(i).getType().equals("TEXT")) {
							count++;
							if (count == 2) {
								goal = true;
							}
						}
					} else {
						count = 0;
					}
				}
				if (goal && client.getBalance() > 0)
					client.NowGold();
			}
		}
	}

	public void platinumToVip(Client client) {
		if (isPlatinumClient(client)) {
			int videoCount = 0;
			for (int i = 0; i < _communications.size(); i++) {
				if (_communications.get(i).getType().equals("VIDEO")) {
					videoCount += 1;
				}
			}
			if ((videoCount >= 10) && (client.getBalance() >= 0)) {
				client.NowVip();
			}
		}
	}

	/********************************************************************************
	 * 
	 * TERMINALS
	 * 
	 * ******************************************************************************
	 * /*
	 * 
	 * @param type
	 * @param terminalId
	 * @param clientId
	 * @param state
	 * @throws TerminalAlreadyExistException
	 */

	/**
	 * @param type       type of the terminal: basic or fancy
	 * @param terminalId
	 * @param clientId
	 * @param state      can be idle/on, off, busy or silence
	 */
	public void registerTerminal(String type, String terminalId, String clientId, String state)
			throws TerminalAlreadyExistException {
		duplicateTerminal(terminalId);
		if (type.equals("BASIC")) {
			registerBasicTerminal(terminalId, clientId, state);
		} else {
			registerFancyTerminal(terminalId, clientId, state);
		}
	}

	/**
	 * @param idTerminal
	 * @param idClient
	 * @param state
	 */
	public void registerBasicTerminal(String idTerminal, String idClient, String state) {
		Terminal terminal = new BasicTerminal(idTerminal, idClient, state);
		addTerminal(idTerminal, terminal);

	}

	/**
	 * @param idTerminal
	 * @param idClient
	 * @param state
	 */
	public void registerFancyTerminal(String idTerminal, String idClient, String state) {
		Terminal terminal = new FancyTerminal(idTerminal, idClient, state);
		addTerminal(idTerminal, terminal);

	}

	/**
	 * @param id
	 * @param terminal
	 */
	public void addTerminal(String id, Terminal terminal) {
		_terminals.put(id, terminal);
		(_clients.get(terminal.getClientId())).addTerminal();
	}

	/**
	 * @param id terminal id
	 * @throws TerminalAlreadyExistException if there is already a terminal
	 *                                       registered with that id
	 */
	public void duplicateTerminal(String id) throws TerminalAlreadyExistException {
		if (_terminals.get(id) != null)
			throw new TerminalAlreadyExistException();
	}

	/**
	 * @param id terminal id
	 * @throws TerminalDontExistException if there is not a terminal registered with
	 *                                    that id
	 */
	public void terminalExists(String id) throws TerminalDontExistException {
		if (_terminals.get(id) == null)
			throw new TerminalDontExistException();
	}

	/**
	 * @param terminalId terminal that we will add friends
	 * @param friends    friends to add
	 */
	public void registerFriends(String terminalId, String friends)
			throws TerminalDontExistException, UnsupportedAtOriginException {
		String[] friendsList = friends.split(",");
		Terminal terminalAdding = getTerminal(terminalId);
		for (int i = 0; i < friendsList.length; i++) {
			String terminalIdAdded = friendsList[i];
			addFriendToTerminal(terminalAdding, terminalIdAdded);
		}
	}

	/**
	 * @param terminal      terminal that receive a friend
	 * @param terminalAdded terminal that will be added to terminal friend list
	 */
	public void addFriendToTerminal(Terminal terminal, String terminalIdAdded)
			throws TerminalDontExistException, UnsupportedAtOriginException {
		terminalExists(terminalIdAdded);
		if (terminal.getId().equals(terminalIdAdded))
			throw new UnsupportedAtOriginException();
		Terminal terminalAdded = getTerminal(terminalIdAdded);
		terminal.addFriend(terminalAdded);
	}

	/**
	 * @param terminal      terminal that will check witch friend to remove
	 * @param terminalAdded terminal that will be removed from terminal friend list
	 */
	public void removeFriendFromTerminal(Terminal terminal, String terminalToRemove) throws TerminalDontExistException {
		terminalExists(terminalToRemove);
		Terminal terminalRemoved = getTerminal(terminalToRemove);
		terminal.removeFriend(terminalRemoved);
	}

	/**
	 * @param terminalId
	 * @return the terminal with the giver id
	 */
	public Terminal getTerminal(String terminalId) throws TerminalDontExistException {
		terminalExists(terminalId);
		return _terminals.get(terminalId);
	}

	/**
	 * @param terminal
	 * @return the id of the terminal
	 */
	public String getTerminalId(Terminal terminal) {
		return terminal.getId();
	}

	/**
	 * @return all the terminals registered
	 */
	public Collection<Terminal> getAllTerminals() {
		return _terminals.values();
	}

	/**
	 * @return all the terminals that haven´t started a communication
	 */
	public Collection<Terminal> getInactiveTerminals() {
		for (String terminalId : _terminals.keySet()) {
			if (((_terminals.get(terminalId)).getAllCommunications()).isEmpty()) {
				_inactiveTerminals.put(terminalId, _terminals.get(terminalId));
			}
		}
		return Collections.unmodifiableCollection(_inactiveTerminals.values());
	}

	/**
	 * @return the terminals with positive balance
	 */
	public Collection<Terminal> terminalsPositiveBalance() {
		return getAllTerminals().stream().filter(terminal -> terminal.terminalBalance() > 0)
				.collect(Collectors.toList());
	}

	/**
	 * @return the debts of a terminals
	 */
	public int getTerminalDebts(String id) {
		return doubleToInt(_terminals.get(id).getDebts());
	}

	/**
	 * @return the payments of a terminals
	 */
	public int getTerminalPayments(String id) {
		return doubleToInt(_terminals.get(id).getPayments());
	}

	/**
	 * @param terminal terminal that will pay for the communication
	 * @param commKey  communication key
	 * @throws CommunicationDoesNotExistException before terminal pay the
	 *                                            communication we check if the
	 *                                            communication exists
	 */
	public void performPayment(Terminal terminal, String commKey) throws CommunicationDoesNotExistException {
		int commId = Integer.parseInt(commKey);
		Client client = _clients.get(terminal.getClientId());
		communicationExist(commId);
		Communication comm = _communications.get(commId);
		if (!comm.isPaid()) {
			terminal.perfomPaymentTerminal(commId, comm);
			client.perfomPaymentClient(commId, comm);
			normalToGold(client);
			comm.payComm();
		}

	}

	/**
	 * @param terminal terminal we want to silent
	 * @throws DestinationTerminalSilentException terminal is already silent
	 */
	public void silenceTerminal(Terminal terminal) throws DestinationTerminalSilentException {
		isSilence(terminal, "", "");
		terminal.silenceTerminal();
		terminal.updateNot();

	}

	/**
	 * @param terminal terminal we want to turn off
	 * @throws DestinationTerminalOffException terminal is already off
	 */
	public void turnOffTerminal(Terminal terminal) throws DestinationTerminalOffException {
		isOff(terminal, "", "");
		terminal.turnOffTerminal();
		terminal.updateNot();

	}

	/**
	 * @param terminal terminal we want to turn on
	 * @throws DestinationTerminalOffException terminal is already on
	 */
	public void turnOnTerminal(Terminal terminal) throws DestinationTerminalOnException {
		isIdle(terminal);
		terminal.turnOnTerminal();

	}

	/**
	 * @param terminal terminal we check if is idle
	 * @throws DestinationTerminalOffException terminal is already idle
	 */
	public void isIdle(Terminal terminal) throws DestinationTerminalOnException {
		if (terminal.getState().isIdleState())
			throw new DestinationTerminalOnException();
	}

	/**
	 * @param terminal terminal we check if is off
	 * @throws DestinationTerminalOffException terminal is already off
	 */
	public void isOff(Terminal terminal, String commType, String clientId) throws DestinationTerminalOffException {
		if (terminal.getState().isOffState()) {
			Client client = _clients.get(clientId);
			if (!clientId.equals("") && client.notificationsOn()) {
				terminal.sendNotification(client, commType);
			}
			throw new DestinationTerminalOffException();
		}
	}

	/**
	 * @param terminal terminal we check if is silence
	 * @throws DestinationTerminalSilenceException terminal is already silence
	 */
	public void isSilence(Terminal terminal, String commType, String clientId)
			throws DestinationTerminalSilentException {
		if (terminal.getState().isSilenceState()) {
			Client client = _clients.get(clientId);
			if (!commType.equals("") && client.notificationsOn())
				terminal.sendNotification(client, commType);
			throw new DestinationTerminalSilentException();
		}
	}

	/**
	 * @param terminal terminal we check if is busy
	 * @throws DestinationTerminalBusyException terminal is already busy
	 */
	public void isBusy(Terminal terminal, String commType, String clientId) throws DestinationTerminalBusyException {
		if (terminal.getState().isBusyState()) {
			Client client = _clients.get(clientId);
			if (!commType.equals("") && client.notificationsOn())
				terminal.sendNotification(client, commType);
			throw new DestinationTerminalBusyException();
		}
	}

	/**
	 * @param terminal terminal we will update de debts
	 * @param debt     the amount we will add to terminal debts
	 */
	public void updateDebtsTerminal(Terminal terminal, double debt) {
		double debts = terminal.getDebts();
		debts += debt;
		terminal.setDebts(debts);
	}

	/*******************************************************************************
	 * 
	 * COMMUNICATIONS
	 * 
	 *******************************************************************************/

	/**
	 * @param communication
	 */
	public void addCommunication(Communication communication) {
		_communications.put(communication.getId(), communication);
	}

	/**
	 * @param idDest terminal who receive a communication
	 * @param idOrig terminal who sends the communication
	 * @param type   communication type
	 * @throws DestinationTerminalOffException    terminal is already off
	 * @throws DestinationTerminalSilentException terminal is already silent
	 * @throws DestinationTerminalBusyException   terminal is already busy
	 * @throws TerminalDontExistException         terminal dont exist
	 */
	public void startInteractiveCommunication(String idDest, String idOrig, String type)
			throws DestinationTerminalOffException,
			DestinationTerminalSilentException, DestinationTerminalBusyException, UnsupportedAtOriginException,
			UnsupportedAtDestinationException, TerminalDontExistException {
		terminalExists(idDest);
		isOff(_terminals.get(idDest), type, _terminals.get(idOrig).getClientId());
		isSilence(_terminals.get(idDest), type, _terminals.get(idOrig).getClientId());
		isBusy(_terminals.get(idDest), type, _terminals.get(idOrig).getClientId());
		if (idDest.equals(idOrig))
			throw new DestinationTerminalBusyException();
		if (type.equals("VIDEO")) {
			if (!supportsInteractiveComm(idDest))
				throw new UnsupportedAtDestinationException();
			if (!supportsInteractiveComm(idOrig))
				throw new UnsupportedAtOriginException();
		}
		addCommunication(_terminals.get(idOrig).startInteractiveCommunication(idDest, calculateCommId(), type));
		_terminals.get(idOrig).saveState();
		_terminals.get(idDest).saveState();
		_terminals.get(idOrig).setBusy();
		_terminals.get(idDest).setBusy();

	}

	/**
	 * @param terminal terminal to end communication
	 * @param duration duration of the interactive communication
	 * @return the price of the communication
	 */
	public int endInteractiveCommunication(Terminal terminal, double duration) {
		double price = 0;
		String idOrig = terminal.getId();
		String clientId = _terminals.get(idOrig).getClientId();
		int idComm = getCurrentComm(terminal);
		String idDest = _communications.get(idComm).getIdReceiver();
		String commType = _communications.get(idComm).getType();
		Client client = _clients.get(clientId);

		if (isNormalClient(client)) {
			NormalPlan plan = new NormalPlan();
			price = plan.interactiveCost(terminal, _terminals.get(idDest), commType, duration);
		} else if (isGoldClient(client)) {
			GoldPlan plan = new GoldPlan();
			price = plan.interactiveCost(terminal, _terminals.get(idDest), commType, duration);
		} else if (isPlatinumClient(client)) {
			PlatinumPlan plan = new PlatinumPlan();
			price = plan.interactiveCost(terminal, _terminals.get(idDest), commType, duration);
		}
		updateDebtsClient(client, price);
		updateDebtsTerminal(terminal, price);

		terminal.endInteractiveCommunication(idComm);
		finishCommunication(idComm);

		terminal.recoverState();

		_terminals.get(idDest).recoverState();

		upgradePriceDurationComm(idComm, price, duration);
		terminal.upgradePriceDurationComm(idComm, price, duration);
		if (isGoldClient(client)) {
			goldToNormal(client);
			goldToPlatinum(client);
		} else {
			platinumToNormal(client);
			platinumToGold(client);
		}

		return doubleToInt(price);
	}

	/**
	 * @param idComm   communication id
	 * @param price    price of the communication
	 * @param duration communication duration
	 */
	public void upgradePriceDurationComm(int idComm, double price, double duration) {
		_communications.get(idComm).setPrice(price);
		_communications.get(idComm).setDuration(duration);
	}

	/**
	 * @param terminal
	 * @return the ongoing communication
	 */
	public int getCurrentComm(Terminal terminal) {
		int currentComm = 0;
		for (int idComm : _communications.keySet())
			if (terminal.getId().equals(_communications.get(idComm).getIdSender()))
				currentComm = idComm;

		return currentComm;
	}

	/**
	 * @param idComm communication id
	 */
	public void finishCommunication(int idComm) {
		for (int commId : _communications.keySet())
			if (idComm == commId)
				_communications.get(idComm).finishCommunication();
	}

	/**
	 * @return calculate de new communication id
	 */
	public int calculateCommId() {
		return _communications.size() + 1;
	}

	/**
	 * @param idDest terminal who receive a communication
	 * @param idOrig terminal who sends the communication
	 * @param text   communication text message
	 * @throws DestinationTerminalOffException terminal is already off
	 * @throws TerminalDontExistException      terminal dont exist
	 */
	public void sendTextCommunication(String idDest, String idOrig, String text)
			throws DestinationTerminalOffException, TerminalDontExistException {
		int units = 0;
		double price = 0;
		Client client = _clients.get(_terminals.get(idOrig).getClientId());

		terminalExists(idDest);
		isOff(_terminals.get(idDest), "TEXT", _terminals.get(idOrig).getClientId());
		if (isNormalClient(client)) {
			NormalPlan plan = new NormalPlan();
			units = plan.getTextSize(text);
			price = plan.textCost(_terminals.get(idOrig), text);
		} else if (isGoldClient(client)) {
			GoldPlan plan = new GoldPlan();
			units = plan.getTextSize(text);
			price = plan.textCost(_terminals.get(idOrig), text);
		}

		else if (isPlatinumClient(client)) {
			PlatinumPlan plan = new PlatinumPlan();
			units = plan.getTextSize(text);
			price = plan.textCost(_terminals.get(idOrig), text);
		}
		updateDebtsTerminal(_terminals.get(idOrig), price);
		updateDebtsClient(client, price);
		addCommunication(_terminals.get(idOrig).sendTextCommunication(idDest, text, units, price, calculateCommId()));
		if (isGoldClient(client)) {
			goldToNormal(client);
			goldToPlatinum(client);
		} else {
			platinumToNormal(client);
			platinumToGold(client);
		}
	}

	/**
	 * @return all the clients registered
	 */
	public Collection<Communication> getAllCommunications() {
		return _communications.values();
	}

	/**
	 * @param id client id
	 * @throws ClientDontExistException client with the id dont exist
	 * @return communications from a client
	 * 
	 */
	public Collection<Communication> communicationsFromClient(String id) throws ClientDontExistException {
		clientExists(id);
		return getAllCommunications().stream()
				.filter(communication -> _terminals.get(communication.getIdSender()).getClientId().equals(id))
				.collect(Collectors.toList());
	}

	/**
	 * @param id client id
	 * @throws ClientDontExistException client with the id dont exist
	 * @return communications to a client
	 */
	public Collection<Communication> communicationsToClient(String id) throws ClientDontExistException {
		clientExists(id);
		return getAllCommunications().stream()
				.filter(communication -> _terminals.get(communication.getIdReceiver()).getClientId().equals(id))
				.collect(Collectors.toList());
	}

	/**
	 * @param id communication id
	 * @throws CommunicationDoesNotExistException communication with this id dont
	 *                                            exist
	 */
	public void communicationExist(int id) throws CommunicationDoesNotExistException {
		if (_communications.get(id) == null)
			throw new CommunicationDoesNotExistException();
	}

	/**
	 * @param terminal
	 * @throws NoOnGoingCommunicationException
	 * @return get the ongoing communication
	 */
	public Collection<Communication> showOngoingCommunication(Terminal terminal)
			throws NoOnGoingCommunicationException {
		return terminal.showOngoingCommunication();
	}

	/**
	 * @param terminalId
	 * @return check if is a fancy terminal so can support an interactive
	 *         communication
	 */
	public boolean supportsInteractiveComm(String terminalId) {
		if (_terminals.get(terminalId).isFancyTerminal())
			return true;
		return false;
	}

	/*******************************************************************************
	 * 
	 * NOTIFICATIONS
	 * 
	 *******************************************************************************/
	/*
	 * @param id
	 * 
	 * @throws ClientDontExistException
	 * 
	 * @throws NotificationAlreadyDisabledException
	 */

	/**
	 * @param id id of the client that wants to disable notifications
	 */
	public void disableClientNotifications(String id)
			throws ClientDontExistException, NotificationAlreadyDisabledException {
		clientExists(id);
		_clients.get(id).disableNotifications();
	}

	/**
	 * @param id id of the client that wants to enable notifications
	 */
	public void enableClientNotifications(String id)
			throws ClientDontExistException, NotificationAlreadyEnabledException {
		clientExists(id);
		_clients.get(id).enableNotifications();
	}

	/**
	 * @param clientId
	 * @return client notifications
	 */
	public Collection<Notification> getClientNotifications(String clientId) {
		return _clients.get(clientId).getClientNotifications();
	}

	/********************************************************************************
	 * 
	 * ADDITIONAL METHODS
	 * 
	 *******************************************************************************/

	/**
	 * @return global payments from all clients
	 */
	public int getGlobalPayments() {
		double payments = 0;
		for (String clientId : _clients.keySet()) {
			Client client = _clients.get(clientId);
			payments += client.getPayments();
		}
		return doubleToInt(payments);
	}

	/**
	 * @return global debts from all clients
	 */
	public int getGlobalDebts() {
		double debts = 0;
		for (String clientId : _clients.keySet()) {
			Client client = _clients.get(clientId);
			debts += client.getDebts();
		}
		return doubleToInt(debts);
	}

	/**
	 * @param number a number of type double
	 * @return the number as an integer
	 */
	public int doubleToInt(double number) {
		int value = (int) number;
		return value;
	}

	public Client getLowestPayment() {
		String clientId = "";
		double lowest = -1;
		for (String id : _clients.keySet()) {
			double payment = _clients.get(id).getPayments();
			if (lowest == -1) {
				lowest = payment;
				clientId = id;
			} else if (payment < lowest) {
				clientId = id;
			}
		}
		Client lowestClient = _clients.get(clientId);
		return lowestClient;
	}

	public Terminal showMaxPayment() {
		String terminalId = "";
		double max = 0;
		for (String id : _terminals.keySet()) {
			double payment = _terminals.get(id).getPayments();
			if (payment > max) {
				terminalId = id;
			}
		}
		Terminal lowestTerminal = _terminals.get(terminalId);
		return lowestTerminal;
	}

	public Collection<Client> showClientsOfType(String type) {
		return getAllClients().stream().filter(client -> client.getType().equals(type)).collect(Collectors.toList());
	}

	public Collection<Client> showClientsOrdered() {
		List<Client> _clientsList = _clients.values().stream().toList();
		_clientsList.stream().sorted((c1, c2) -> c1.getId().toLowerCase().compareTo(c2.getId().toLowerCase()));

		List<Client> _sortedList = new ArrayList<Client>();

		for (int i = 0; i < _clientsList.size(); i++) {
			if (_clientsList.get(i).getType().equals("NORMAL")) {
				_sortedList.add(_clientsList.get(i));
			}
		}
		for (int i = 0; i < _clientsList.size(); i++) {
			if (_clientsList.get(i).getType().equals("GOLD")) {
				_sortedList.add(_clientsList.get(i));
			}
		}
		for (int i = 0; i < _clientsList.size(); i++) {
			if (_clientsList.get(i).getType().equals("PLATINUM")) {
				_sortedList.add(_clientsList.get(i));
			}
		}

		return _sortedList;

	}
}
