package com.mmall.rabbitmq;

import com.rabbitmq.client.Channel;
import com.sun.tools.internal.xjc.reader.xmlschema.bindinfo.BIConversion;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.core.MessageListener;
import org.springframework.amqp.rabbit.listener.api.ChannelAwareMessageListener;
import org.springframework.stereotype.Service;
@Service
public class DirectConsumer implements ChannelAwareMessageListener {
    public DirectConsumer(){
    }

    @Override
    public void onMessage(Message message, Channel channel) throws Exception {
        // TODO Auto-generated method stub
        try {
            System.out.print("===endDat===="+ new String(message.getBody(),"UTF-8"));
            channel.basicAck(message.getMessageProperties().getDeliveryTag(),false);
            System.out.print("tag========"+ message.getMessageProperties().getDeliveryTag());
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

 /*   @Override
    public void onMessage(Message message) {
        // TODO Auto-generated method stub
        try {
            System.out.print("===endDat===="+ new String(message.getBody(),"UTF-8"));
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }*/
}