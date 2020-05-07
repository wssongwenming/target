//package com.mmall.rabbitmq;
//
//import com.alibaba.fastjson.JSONArray;
//import com.alibaba.fastjson.JSONObject;
//import com.mmall.beans.Hole;
//import com.mmall.beans.MarkData;
//import com.mmall.beans.ServerCommand;
//import com.mmall.config.SpringWebSocketHandler;
//import com.mmall.model.*;
//import com.mmall.param.ScoresParam;
//import com.mmall.service.*;
//import com.rabbitmq.client.Channel;
//import org.springframework.amqp.core.AmqpTemplate;
//import org.springframework.amqp.core.Message;
//import org.springframework.amqp.rabbit.listener.api.ChannelAwareMessageListener;
//import org.springframework.context.annotation.Bean;
//import org.springframework.stereotype.Service;
//import org.springframework.web.socket.TextMessage;
//
//import javax.annotation.Resource;
//import java.text.SimpleDateFormat;
//import java.util.ArrayList;
//import java.util.List;
//
//@Service
//public class CameraMarkDataConsumer1 implements ChannelAwareMessageListener {
//    @Bean//这个注解会从Spring容器拿出Bean
//    public SpringWebSocketHandler infoHandler() {
//        return new SpringWebSocketHandler();
//    }
//    @Resource
//    private AmqpTemplate amqpTemplate;
//    @Resource
//    private CameraService cameraService;
//    @Resource
//    private ScoresService scoresService;
//    @Resource
//    private TraineeGroupService traineeGroupService;
//    @Resource
//    private DisplayService displayService;
//    @Resource
//    private DeviceGroupService deviceGroupService;
//    @Resource
//    private MessageProducer messageProducer;
//    public CameraMarkDataConsumer1(){
//    }
//
//    @Override
//    public void onMessage(Message message, Channel channel) throws Exception {
//        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//        // 数据是从camera过来的，需要从数据中提取出mac->找到设备编号->靶位编组编号-〉靶位编组中的display的MAC-〉
//        // 同时提取射击组中对应的traineeid，把成绩归到该人名下
//        try {
//            String messageStr=new String(message.getBody(),"UTF-8");
//            JSONObject messageJson = JSONObject.parseObject(messageStr);
//            String camerMac=messageJson.getString("mac");
//            String radius=messageJson.getString("radius");
//            String mmOfRadius=messageJson.getString("mmOfRadius");
//            JSONArray holes=messageJson.getJSONArray("holes");
//            Camera camera =cameraService.getCameraByMac(camerMac);
//            int cameraIndex=-1;
//            if(camera!=null)
//            {
//                cameraIndex=camera.getDevice_index();
//            }
//            Device_Group device_group=deviceGroupService.getDeviceGroupByCameraIndex(cameraIndex);
//            int displayIndex=-1;
//            int deviceGroupIndex=-1;
//            if(device_group!=null){
//                displayIndex=device_group.getDisplayId();
//                deviceGroupIndex=device_group.getGroupIndex();
//            }
//            String displayMac=null;
//            Display display=displayService.getDisplayByIndex(displayIndex);
//            if(display!=null){
//                displayMac=display.getMac();
//            }
//            Trainee_Group traineeGroupInShooting =traineeGroupService.getTraineeGroupInShooting();
//            String traineeIdsInShooting=traineeGroupInShooting.getTraineeIds();
//            if(traineeIdsInShooting!=null) {
//                String[] traineeIdsArray = traineeIdsInShooting.split(",");
//                int traineeId=Integer.parseInt(traineeIdsArray[deviceGroupIndex-1].trim());
//                int scoreCount=scoresService.getCount(traineeId);
//                int scoreCountInJson=holes.size();
//                if(scoreCountInJson>scoreCount){
//                    JSONObject newScore=holes.getJSONObject(scoreCountInJson-1);
//                    ScoresParam scoresParam=new ScoresParam();
//                    String now=df.format(System.currentTimeMillis());
//                    scoresParam.setHittingTime(df.parse(now));
//                    scoresParam.setMac(camerMac);
//                    scoresParam.setMmofradius(Float.valueOf(mmOfRadius));
//                    scoresParam.setMx(newScore.getFloat("mx"));
//                    scoresParam.setMy(newScore.getFloat("my"));
//                    scoresParam.setOffset(newScore.getString("offset"));
//                    scoresParam.setPx(newScore.getFloat("px"));
//                    scoresParam.setPy(newScore.getFloat("py"));
//                    scoresParam.setRadius(Float.valueOf(radius));
//                    scoresParam.setRingnumber(newScore.getFloat("score"));
//                    scoresParam.setScoreIndex(newScore.getInteger("id"));
//                    scoresParam.setTraineeId(traineeId);
//                    scoresService.save(scoresParam);
//
//                }//将最近收到的数据保存完毕，下面统一取出，装配发送给display和server的数据
//                List<Scores> scoresList=scoresService.getScoresByTraineeId(traineeId);
//                Float totalScore= getTotalScore(scoresList);
//                MarkData markData=new MarkData();
//                String mac="";//没有用到其实
//                String radius1="";
//                String mmOfRadius1="";
//                List<Hole> holes1=new ArrayList<>();
//                for(int i=0;i<scoresList.size();i++){
//                    Scores scores1=scoresList.get(i);
//                    Hole hole =new Hole();
//                    if(scores1!=null){
//                        hole.setId(scores1.getScoreIndex());
//                        hole.setMx(scores1.getMx());
//                        hole.setMy(scores1.getMy());
//                        hole.setOffset(scores1.getOffset());
//                        hole.setPx(scores1.getPx());
//                        hole.setPy(scores1.getPy());
//                        hole.setScore(scores1.getRingnumber());
//                        hole.setShootingTime(df.format(scores1.getHittingTime()));
//                        //TODO应该只取一次取到即可，但这里取了多次,
//                        mac=scores1.getMac();
//                        radius1= String.valueOf(scores1.getRadius());
//                        mmOfRadius1= String.valueOf(scores1.getMmofradius());
//                    }
//                    holes1.add(hole);
//                }
//                markData.setHoles(holes1);//App端用于显示，server端也使用
//                markData.setTotalScore(totalScore);//server端用于显示成绩列表中的总成绩
//                markData.setMac(mac);
//                markData.setDeviceGroupIndex(deviceGroupIndex);
//                markData.setRadius(radius1);
//                markData.setMmOfRadius(mmOfRadius1);
//                markData.setCode(1);//告诉ｓｅｒｖｅｒ现在打靶成绩的显示
//                markData.setDataType(ServerCommand.MARK_DATA);
//                JSONObject jo= (JSONObject) JSONObject.toJSON(markData);
//                String markDataStr=jo.toJSONString();
//                System.out.print(markDataStr);
//                //messageProducer.sendTopicMessage("server-to-other-exchange","server-to-display-markdata-routing-key-"+displayMac,markDataStr );
//                messageProducer.sendTopicMessage("server-to-display-exchange","server-to-display-routing-key-"+displayMac,markDataStr );
//
//                long delieverTag=message.getMessageProperties().getDeliveryTag();
//                channel.basicAck(delieverTag,false);//TODO:应该为false
//
//                //向server发送新的射击websocket消息
//                infoHandler().sendMessageToUsers( new TextMessage(markDataStr)) ;
//
//
//            }
//            System.out.print("tag========"+ message.getMessageProperties().getDeliveryTag());
//        }catch (Exception e) {
//            // TODO Auto-generated catch block
//            e.printStackTrace();
//        }
//    }
//
// /*   @Override
//    public void onMessage(Message message) {
//        // TODO Auto-generated method stub
//        try {
//            System.out.print("===endDat===="+ new String(message.getBody(),"UTF-8"));
//        } catch (Exception e) {
//            // TODO Auto-generated catch block
//            e.printStackTrace();
//        }
//    }*/
//
//    public float getTotalScore(List<Scores> scoresList) {
//
//        float totalScore=0.0f;
//        // 去掉重复的key
//        for (Scores scores : scoresList) {
//          totalScore=totalScore+scores.getRingnumber();
//        }
//           return totalScore;
//    }
//
//}