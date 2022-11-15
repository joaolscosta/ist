package prr.clients;

import java.io.Serializable;

public abstract class SelectStatute implements Serializable {
    private Client _client;

    public abstract boolean isNormalClient();
    public abstract boolean isPlatinumClient();
    public abstract boolean isGoldClient();
    public abstract boolean isVipClient();
    
    public SelectStatute(Client client){
        this._client = client;
    }

    protected Client getClient(){
        return _client;
    }
    
}
