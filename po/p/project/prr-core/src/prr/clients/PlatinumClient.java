package prr.clients;

public class PlatinumClient extends SelectStatute {
    /**
     * @param client
     */
    public PlatinumClient(Client client){
        super(client);
    }

    public boolean isNormalClient(){
        return false;
    }
    public boolean isPlatinumClient(){
        return true;
    }
    public boolean isGoldClient(){
        return false;
    }
    public boolean isVipClient(){
        return false;
    }
    /* (non-Javadoc)
     * @see java.lang.Object#toString()
     */

    @Override
    public String toString(){
        return "PLATINUM";
    }
}

