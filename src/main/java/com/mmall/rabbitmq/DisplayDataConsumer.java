package com.mmall.rabbitmq;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.mmall.beans.DeviceType;
import com.mmall.beans.DisplayStatus;
import com.mmall.beans.TraineeStatus;
import com.mmall.config.SpringWebSocketHandler;
import com.mmall.model.Display;
import com.mmall.param.DisplayParam;
import com.mmall.param.TraineeParam;
import com.mmall.service.*;
import com.rabbitmq.client.Channel;
import org.springframework.amqp.core.AmqpTemplate;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.rabbit.listener.api.ChannelAwareMessageListener;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.TextMessage;

import javax.annotation.Resource;

@Service
public class DisplayDataConsumer implements ChannelAwareMessageListener {
    @Bean//这个注解会从Spring容器拿出Bean
    public SpringWebSocketHandler infoHandler() {
        return new SpringWebSocketHandler();
    }
    @Resource
    private AmqpTemplate amqpTemplate;
    @Resource
    private TraineeService traineeService;
    @Resource
    private ScoresService scoresService;
    @Resource
    private TraineeGroupService traineeGroupService;
    @Resource
    private DisplayService displayService;
    @Resource
    private DeviceGroupService deviceGroupService;
    @Resource
    private MessageProducer messageProducer;

    @Override
    public void onMessage(Message message, Channel channel) throws Exception {
        try {
            String messageStr = new String(message.getBody(), "UTF-8");
            JSONObject messageJson = JSONObject.parseObject(messageStr);
            int CODE=messageJson.getIntValue("code");
            //收到了app的消息code=0表示完成射击，现在到了server端需对该消息重新进行封装
            if(CODE==0)
            {
                int target_index=messageJson.getIntValue("target_index");//靶位编号
                int group_index=messageJson.getIntValue("group_index");
                int traineeId=Integer.parseInt(messageJson.getString("traineeId"));
                TraineeParam traineeParam=new TraineeParam();
                traineeParam.setId(traineeId);
                traineeParam.setStatus(TraineeStatus.FINISH_SHOOTING);
                traineeService.update(traineeParam);
                //更改服务器端的显示状态
                JSONObject traineeJson=new JSONObject();
                JSONObject data=new JSONObject();
                traineeJson.put("code",0);//code=0用户的状态数据（未登陆，已登陆．正在射击）,(code=1打靶数据),code=2：代表设备的状态
                data.put("targetIndex",target_index);//其实应该为deviceGroupIndex
                data.put("traineeStatus",TraineeStatus.FINISH_SHOOTING);
                traineeJson.put("data",data);
                infoHandler().sendMessageToUsers( new TextMessage(traineeJson.toJSONString())) ;
                long delieverTag=message.getMessageProperties().getDeliveryTag();
                channel.basicAck(delieverTag,false);//TODO:应该为false
            }else if(CODE==1){
                int displayId=messageJson.getIntValue("deviceId");
                int status=messageJson.getIntValue("device_status");
                int deviceGroupIndex=messageJson.getIntValue("target_index");
                //手动回复消息队列
                long delieverTag=message.getMessageProperties().getDeliveryTag();
                channel.basicAck(delieverTag,false);
                //更改服务器端的显示状态
                Display display=displayService.getDisplayById(displayId);
                DisplayParam displayParam=new DisplayParam();
                displayParam.setId(display.getId());
                displayParam.setDevice_index(display.getDevice_index());
                displayParam.setStatus(status);//先将设备设置为异常，然后消息队列返回信息后再设置为正常
                displayParam.setIp(display.getIp());
                displayParam.setMac(display.getMac());
                displayParam.setMemo(display.getMemo());
                displayParam.setName(display.getName());
                displayParam.setNumber(display.getNumber());
                displayService.update(displayParam);
                JSONObject displayJson=new JSONObject();
                JSONObject data=new JSONObject();
                displayJson.put("code",2);//code=0用户的状态数据（未登陆，已登陆．正在射击）,(code=1打靶数据),code=2：代表设备的状态
                data.put("targetIndex",deviceGroupIndex);
                data.put("deviceStatus", DisplayStatus.NORMAL);//这时返回的是0，所以正常
                data.put("deviceType", DeviceType.DISPLAY);
                displayJson.put("data",data);
                infoHandler().sendMessageToUsers( new TextMessage(displayJson.toJSONString())) ;
            }
        }catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}
