package prr.clients;

public class NormalClient extends SelectStatute {
    /**
     * @param client
     */
    public NormalClient(Client client){
        super(client);
    }

    public boolean isNormalClient(){
        return true;
    }
    public boolean isPlatinumClient(){
        return false;
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
        return "NORMAL";
    }
}
