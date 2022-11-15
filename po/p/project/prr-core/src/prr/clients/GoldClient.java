package prr.clients;

public class GoldClient extends SelectStatute {
    /**
     * @param client
     */
    public GoldClient(Client client){
        super(client);
    }

    public boolean isNormalClient(){
        return false;
    }
    public boolean isPlatinumClient(){
        return false;
    }
    public boolean isGoldClient(){
        return true;
    }
    public boolean isVipClient(){
        return false;
    }

    /* (non-Javadoc)
     * @see java.lang.Object#toString()
     */

    @Override
    public String toString(){
        return "GOLD";
    }

}
