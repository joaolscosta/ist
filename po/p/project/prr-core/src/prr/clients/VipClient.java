package prr.clients;

public class VipClient extends SelectStatute {
    /**
     * @param client
     */
    public VipClient(Client client){
        super(client);
    }

    public boolean isNormalClient(){
        return false;
    }
    public boolean isPlatinumClient(){
        return false;
    }
    public boolean isGoldClient(){
        return false;
    }
    public boolean isVipClient(){
        return true;
    }

    /* (non-Javadoc)
     * @see java.lang.Object#toString()
     */

    @Override
    public String toString(){
        return "VIP";
    }

}
