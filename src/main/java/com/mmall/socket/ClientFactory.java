package com.mmall.socket;

public  class ClientFactory {
    public Client createClient(String host,int port) throws Exception{
        return new Client(host,port);
    }
}
