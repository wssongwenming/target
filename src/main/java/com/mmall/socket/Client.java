package com.mmall.socket;

import com.mmall.util.SocketUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import java.net.Socket;

public class Client {
    private Logger LOGGER= LoggerFactory.getLogger(Client.class);
    public Client(String host,int port) throws Exception{
        this.client=new Socket(host,port);
        System.out.print("client[port:"+client.getLocalPort()+"]与服务器端建立连接");
    }
    /***
     * 发送消息
     * @param cmd
     */

    public String send(String cmd)throws Exception{
        try {
            OutputStream out = client.getOutputStream();
            byte[] hexStrToByteArrs = hexStrToByteArrs(cmd);
            if (hexStrToByteArrs == null) {
                return "error";
            }
            out.write(hexStrToByteArrs);

            InputStream in = client.getInputStream();

            byte[] buf = new byte[1024];
            int len = in.read(buf);

            stop();

            String msg=bytesToHexString(buf);
            return bytesToHexString(buf);
        } catch (IOException e) {
            LOGGER.error("sendCmd error", e);
            return "error";
        }
    }

    private Socket client;


    public void stop(){
        try{
            if(client!=null){
                client.close();
                client=null;
            }
        }catch (Exception e)
        {
            LOGGER.error("connection error",e);
        }
    }

    /**
     * 将十六进制的字符串转换成字节数组
     *
     * @param hexString
     * @return
     */
    public static byte[] hexStrToByteArrs(String hexString) {
        if (StringUtils.isEmpty(hexString)) {
            return null;
        }

        hexString = hexString.replaceAll(" ", "");
        int len = hexString.length();
        int index = 0;

        byte[] bytes = new byte[len / 2];

        while (index < len) {
            String sub = hexString.substring(index, index + 2);
            bytes[index / 2] = (byte) Integer.parseInt(sub, 16);
            index += 2;
        }

        return bytes;
    }

    /**
     * 数组转换成十六进制字符串
     *
     * @return HexString
     */
    public static final String bytesToHexString(byte[] bArray) {
        StringBuffer sb = new StringBuffer(bArray.length);
        String sTemp;
        for (int i = 0; i < bArray.length; i++) {
            sTemp = Integer.toHexString(0xFF & bArray[i]);
            if (sTemp.length() < 2)
                sb.append(0);
            sb.append(sTemp.toUpperCase());
            // 在这里故意追加一个逗号便于最后的区分
            sb.append(" ");
        }
        return sb.toString();
    }
}
