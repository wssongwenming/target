package com.mmall.rabbitmq;


import com.google.gson.Gson;
import entity.User;
import org.springframework.amqp.core.AmqpTemplate;
import org.springframework.amqp.rabbit.connection.CorrelationData;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.UUID;
import java.util.logging.Logger;

@Service
public class MessageProducer {
    @Resource
    private AmqpTemplate amqpTemplate;

    public void sendDirectMessage(String exchange,String routingkey,Object message) {

        amqpTemplate.convertAndSend(exchange,routingkey,message);//第一个参数是exchange名，第二个参数是exchange绑定queue时的key
    }
    public void sendTopicMessage(String exchange,String routingkey,Object message)
    {
        CorrelationData correlationData=new CorrelationData();
        correlationData.setId(UUID.randomUUID().toString());
        amqpTemplate.convertAndSend(exchange,routingkey, message);

    }
}