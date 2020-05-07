package com.mmall.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.mmall.beans.*;
import com.mmall.common.JsonData;
import com.mmall.config.SpringWebSocketHandler;
import com.mmall.model.*;
import com.mmall.param.DisplayParam;
import com.mmall.param.TraineeParam;
import com.mmall.rabbitmq.MessageProducer;
import com.mmall.service.*;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.ss.formula.functions.T;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.socket.TextMessage;

import javax.annotation.Resource;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

@SuppressWarnings("ALL")
@Controller
@RequestMapping("/sys/shootingrange")
@Slf4j
public class ShootingRangeController {
    @Bean//这个注解会从Spring容器拿出Bean
    public SpringWebSocketHandler infoHandler() {

        return new SpringWebSocketHandler();
    }
    @Resource
    private MessageProducer messageProducer;
    @Resource
    private TrainingService trainingService;
    @Resource
    private TraineeService traineeService;
    @Resource
    private ScoresService scoresService;

    @Resource
    private DisplayService displayService;

    @Resource
    private TargetService targetService;

    @Resource
    private CameraService cameraService;

    @Resource
    private DeviceGroupService deviceGroupService;
    @Resource
    private TraineeGroupService traineeGroupService;
    //进入射击靶场
    @RequestMapping("/enter.page")
    public ModelAndView page() {
        return new ModelAndView("shootingrange");
    }

    @RequestMapping("/shootingrangedata.json")
    @ResponseBody
    public JsonData shootingRangeData() throws ParseException {

        ShootingRangeData shootingRangeData=new ShootingRangeData();
        Trainee_Group trainee_group_in_shooting=traineeGroupService.getTraineeGroupInShooting();//当前编组
        Trainee_Group trainee_group_next=traineeGroupService.getTraineeGroupNext();//下一组
        String[] nextGroupTraineeIdArray=null;
        String nextGroupTraineeIds=null;
        if(trainee_group_next!=null)
        {
           nextGroupTraineeIds= trainee_group_next.getTraineeIds();
        }
        if(nextGroupTraineeIds!=null){
            nextGroupTraineeIdArray=trainee_group_next.getTraineeIds().split(",");
        }
        String nextGroupTraineeName="";//2,下一组人员名单
        if(nextGroupTraineeIdArray!=null) {
            for (int i = 0; i < nextGroupTraineeIdArray.length; i++) {
                int traineeId = Integer.parseInt(nextGroupTraineeIdArray[i].trim());
                Trainee trainee=traineeService.getTraineeById(traineeId);
                if(trainee!=null) {
                    String traineeName = trainee.getName();
                    nextGroupTraineeName = nextGroupTraineeName + traineeName + ",";
                }


            }
        }
        List<Trainee_Group> trainee_groupList=traineeGroupService.getAll().getData();
        int current_trainee_group_number=0;
        int sum_trainee_group_count=0;
        int trainee_count_finish_shooting=0;//5,射击完成人数
        int trainee_count_all=0;//7,所有人数
        int trainee_count_not_finish_shooting=0;//6,未打靶人数
        int trainee_count_absent_shooting=0;//8,缺席人数
        if(trainee_groupList!=null) {
            sum_trainee_group_count=trainee_groupList.size();//4共多少组
            Trainee_Group firstTraineeGroup=trainee_groupList.get(0);//取出第一个traineeGroup从中取得trainingId,再取得该trainingId下的所有Trainee，进而统计Trainee总数、已完成、未完成
            int trainingId=firstTraineeGroup.getTrainingId();
             trainee_count_finish_shooting=traineeService.getFinishedShootingTraineeCount(trainingId);//5,射击完成人数
             trainee_count_all=traineeService.getAllTraineeCount(trainingId);//7,所有人数
             trainee_count_not_finish_shooting=traineeService.getNotShootingTraineeCount(trainingId);//6,未打靶人数
             trainee_count_absent_shooting=traineeService.getAbsentShootingTraineeCount(trainingId);//8,缺席人数
        }

        List<TraineeShooting_DeviceGroup_Data> traineeShooting_deviceGroup_data_list=new ArrayList<TraineeShooting_DeviceGroup_Data>();//1
        if(trainee_group_in_shooting!=null)//正在射击的组，并且肯定有人
        {
            current_trainee_group_number=trainee_group_in_shooting.getGroupNumber();//3,当前编组
            String traineeIds=trainee_group_in_shooting.getTraineeIds();
            String[] traineeIdArray=traineeIds.split(",");

            for (int i=0;i<traineeIdArray.length;i++){
                int deviceGroupIndex=i+1;//靶位编号和traineeIdArray的下标对应只是靶位编号从1开始，所以加1
                TraineeShooting_DeviceGroup_Data traineeShooting_deviceGroup_data=new TraineeShooting_DeviceGroup_Data();
                traineeShooting_deviceGroup_data.setDeviceGroupIndex(deviceGroupIndex);
                int traineeId=Integer.parseInt(traineeIdArray[i].trim());
                Trainee trainee=traineeService.getTraineeById(traineeId);
                //设置靶位关于trainee的信息
                if(trainee!=null)// 果靶位上有人，即traineeId!=0,即traineeIdArray,中对应靶位的traineeId为0
                {
                    String name=trainee.getName();
                    int traineeStatus=trainee.getStatus();
                    String photo=trainee.getPhoto();
                    List<Scores> scoresList=scoresService.getScoresByTraineeId(traineeId);
                    Float totalScore=0.0f;
                    for(int m=0;m<scoresList.size();m++)
                    {
                        totalScore=totalScore+scoresList.get(m).getRingnumber();
                    }
                    traineeShooting_deviceGroup_data.setName(name);
                    traineeShooting_deviceGroup_data.setTraineeStatus(traineeStatus);
                    traineeShooting_deviceGroup_data.setPhoto(photo);
                    traineeShooting_deviceGroup_data.setTotalScore(totalScore);
                    traineeShooting_deviceGroup_data.setShootingScoreList(scoresList);

                }
                ////设置靶位关于设备状态的信息
                Device_Group device_group=deviceGroupService.getDeviceGroupByIndex(deviceGroupIndex);
                int display_index=device_group.getDisplayId();
                int camera_index=device_group.getCameraId();
                int target_index=device_group.getTargetId();
                Display display=displayService.getDisplayByIndex(display_index);
                Camera camera=cameraService.getCameraByIndex(camera_index);
                Target target=targetService.getTargetByIndex(target_index);

                int displayStatus=0;
                if (display!=null)
                {
                    displayStatus=display.getStatus();
                }
                int cameraStatus=0;
                if(camera!=null)
                {
                    cameraStatus=camera.getStatus();
                }
                int targetStatus=0;
                if(target!=null)
                {
                    targetStatus=target.getStatus();
                }
                traineeShooting_deviceGroup_data.setDisplayStatus(displayStatus);
                traineeShooting_deviceGroup_data.setCameraStatus(cameraStatus);
                traineeShooting_deviceGroup_data.setTargetStatus(targetStatus);
                //
                traineeShooting_deviceGroup_data_list.add(traineeShooting_deviceGroup_data);
            }

        }else //当前没有打靶的人，取出全部靶位，来获取靶位设备状态信息
        {
            PageResult<Device_Group> deviceGroupList=deviceGroupService.getAll();
            for(int i=0;i<deviceGroupList.getData().size();i++){
                TraineeShooting_DeviceGroup_Data traineeShooting_deviceGroup_data=new TraineeShooting_DeviceGroup_Data();
                Device_Group device_group=deviceGroupList.getData().get(i);
                traineeShooting_deviceGroup_data.setDeviceGroupIndex(i+1);//设置靶位编号：1，2....
                int display_index=device_group.getDisplayId();
                int camera_index=device_group.getCameraId();
                int target_index=device_group.getTargetId();
                Display display=displayService.getDisplayByIndex(display_index);
                Camera camera=cameraService.getCameraByIndex(camera_index);
                Target target=targetService.getTargetByIndex(target_index);

                int displayStatus=0;
                if (display!=null)
                {
                    displayStatus=display.getStatus();
                }
                int cameraStatus=0;
                if(camera!=null)
                {
                    cameraStatus=camera.getStatus();
                }
                int targetStatus=0;
                if(target!=null)
                {
                    targetStatus=target.getStatus();
                }
                traineeShooting_deviceGroup_data.setTargetStatus(targetStatus);
                traineeShooting_deviceGroup_data.setDisplayStatus(displayStatus);
                traineeShooting_deviceGroup_data.setCameraStatus(cameraStatus);
                traineeShooting_deviceGroup_data_list.add(traineeShooting_deviceGroup_data);
            }
        }
        shootingRangeData.setTraineeShooting_deviceGroup_data(traineeShooting_deviceGroup_data_list);
        shootingRangeData.setNextGroupTraineeNames(nextGroupTraineeName);
        shootingRangeData.setCurrentTrainneeGroupIndex(current_trainee_group_number);
        shootingRangeData.setSumOfTraineeGroupCount(sum_trainee_group_count);
        shootingRangeData.setTraineeCountFinishShooting(trainee_count_finish_shooting);
        shootingRangeData.setTraineeCountNotShooting(trainee_count_not_finish_shooting);
        shootingRangeData.setSumOfTraineeCount(trainee_count_all);
        shootingRangeData.setTraineeCountAbsentShooting(trainee_count_absent_shooting);
        System.out.print(shootingRangeData);
        return JsonData.success(shootingRangeData);


//        update trainee_group set all_status=1 where all_status=0 order by group_number asc limit 1
    }

    @RequestMapping("/changeShootingTrainee.json")
    @ResponseBody
    public JsonData changeShootingTrainee() throws ParseException {
        Trainee_Group trainee_group_in_shooting_befor=traineeGroupService.getTraineeGroupInShooting();//当前编组
        if(trainee_group_in_shooting_befor!=null)//把以前正在射击的人状态变为4：已经完成
        {
            String traineeIds=trainee_group_in_shooting_befor.getTraineeIds();
            String[] traineeIdArray=traineeIds.split(",");
            for (int i=0;i<traineeIdArray.length;i++){
                int traineeId=Integer.parseInt(traineeIdArray[i].trim());
                Trainee trainee=traineeService.getTraineeById(traineeId);
                if(trainee!=null) {
                    TraineeParam param = new TraineeParam();
                    param.setId(trainee.getId());
                    param.setMemo(trainee.getMemo());
                    param.setName(trainee.getName());
                    param.setPassword(trainee.getPassword());
                    param.setPhoto(trainee.getPhoto());
                    param.setStatus(TraineeStatus.FINISH_SHOOTING);
                    param.setTrainingId(trainee.getTrainingId());
                    param.setWorkunit(trainee.getWorkunit());
                    param.setPhone(trainee.getPhone());
                    traineeService.update(param);
                }
            }
        }
        int m=traineeGroupService.changeShootedTrainee();//把正在射击组变为射击完成组//
        int n=traineeGroupService.changeShootingTrainee();//把下一个未打靶组变为正在打靶组
        Trainee_Group trainee_group_in_shooting_now=traineeGroupService.getTraineeGroupInShooting();//当前编组
        if(trainee_group_in_shooting_now!=null)//把新的等待打靶人员状态改为未登陆，
        {
            String traineeIds=trainee_group_in_shooting_now.getTraineeIds();
            String[] traineeIdArray=traineeIds.split(",");
            for (int i=0;i<traineeIdArray.length;i++){//修改新进入靶位者的状态，同时把对应信息推入对应靶位的display
                int traineeId=Integer.parseInt(traineeIdArray[i].trim());
                Trainee trainee=traineeService.getTraineeById(traineeId);
                String displayMac="";
                if(trainee!=null) {
                    //取得靶位对应的display的mac
                    int deviceGroupIndex=i+1;
                    Device_Group device_group=deviceGroupService.getDeviceGroupByIndex(deviceGroupIndex);
                    if(device_group!=null) {
                        int displayIndex = device_group.getDisplayId();
                        Display display = displayService.getDisplayByIndex(displayIndex);
                        if(display!=null){
                            displayMac=display.getMac();
                        }
                    }
                    //endmac
                    //
                    int trainingId=trainee.getTrainingId();
                    Training training=trainingService.getTrainingById(trainingId);
                    String target_number=deviceGroupIndex+"";
                    String group_number=trainee_group_in_shooting_now.getGroupNumber().toString();
                    String memo=trainee.getMemo();
                    String name=trainee.getName();
                    String password=trainee.getPassword();
                    String photo=trainee.getPhoto();
                    String gun=training.getGun();
                    int bullet_count=training.getBulletNumber();
                    int status=trainee.getStatus();
                    String workunit=trainee.getWorkunit();
                    String phone=trainee.getPhone();
                    //更改trainee状态，其实就是更改了status:2待登陆状态
                    TraineeParam param = new TraineeParam();
                    param.setId(traineeId);
                    param.setMemo(memo);
                    param.setName(name);
                    param.setPassword(password);
                    param.setPhoto(photo);
                    param.setStatus(2);//新一批人上靶位，等待登陆
                    param.setTrainingId(trainingId);
                    param.setWorkunit(workunit);
                    param.setPhone(phone);
                    traineeService.update(param);
                    //向消息队列发出当前登录者的信息

                    SignCommand signCommand=new SignCommand();
                    signCommand.setCode(0);
                    signCommand.setDataType(ServerCommand.SIGNINBYPASS_COMMAND);//用户密码登陆命令的index都为1
                    signCommand.setMessage("登录者信息");

                    SignInfo signInfo=new SignInfo();
                    signInfo.setBullet_count(bullet_count);
                    signInfo.setDepartment(workunit);
                    signInfo.setGroup_number(group_number);
                    signInfo.setName(name);
                    signInfo.setPassword(password);
                    signInfo.setPhotopath(photo);
                    signInfo.setShooting_gun(gun);
                    signInfo.setUserId(traineeId);
                    signInfo.setTarget_number(target_number);
                    signCommand.setData(signInfo);
                    JSONObject jo= (JSONObject) JSONObject.toJSON(signCommand);
                    messageProducer.sendTopicMessage("server-to-display-exchange","server-to-display-routing-key-"+displayMac,jo.toJSONString());

                }
            }
        }

        ShootingRangeData shootingRangeData=new ShootingRangeData();
        Trainee_Group trainee_group_in_shooting=traineeGroupService.getTraineeGroupInShooting();//当前编组
        Trainee_Group trainee_group_next=traineeGroupService.getTraineeGroupNext();//下一组
        String[] nextGroupTraineeIdArray=null;
        String nextGroupTraineeIds=null;
        if(trainee_group_next!=null)
        {
            nextGroupTraineeIds= trainee_group_next.getTraineeIds();
        }
        if(nextGroupTraineeIds!=null){
            nextGroupTraineeIdArray=trainee_group_next.getTraineeIds().split(",");
        }
        String nextGroupTraineeName="";//2,下一组人员名单
        if(nextGroupTraineeIdArray!=null) {
            for (int i = 0; i < nextGroupTraineeIdArray.length; i++) {
                int traineeId = Integer.parseInt(nextGroupTraineeIdArray[i].trim());
                Trainee trainee=traineeService.getTraineeById(traineeId);
                if(trainee!=null) {
                    String traineeName = trainee.getName();
                    nextGroupTraineeName = nextGroupTraineeName + traineeName + ",";
                }
            }
        }

        List<Trainee_Group> trainee_groupList=traineeGroupService.getAll().getData();
        int current_trainee_group_number=0;
        int sum_trainee_group_count=0;
        int trainee_count_finish_shooting=0;//5,射击完成人数
        int trainee_count_all=0;//7,所有人数
        int trainee_count_not_finish_shooting=0;//6,未打靶人数
        int trainee_count_absent_shooting=0;//8,缺席人数
        if(trainee_groupList!=null) {
            sum_trainee_group_count=trainee_groupList.size();//4共多少组
            Trainee_Group firstTraineeGroup=trainee_groupList.get(0);//取出第一个traineeGroup从中取得trainingId,再取得该trainingId下的所有Trainee，进而统计Trainee总数、已完成、未完成
            int trainingId=firstTraineeGroup.getTrainingId();
            trainee_count_finish_shooting=traineeService.getFinishedShootingTraineeCount(trainingId);//5,射击完成人数
            trainee_count_all=traineeService.getAllTraineeCount(trainingId);//7,所有人数
            trainee_count_not_finish_shooting=traineeService.getNotShootingTraineeCount(trainingId);//6,未打靶人数
            trainee_count_absent_shooting=traineeService.getAbsentShootingTraineeCount(trainingId);//8,缺席人数
        }

        List<TraineeShooting_DeviceGroup_Data> traineeShooting_deviceGroup_data_list=new ArrayList<TraineeShooting_DeviceGroup_Data>();//1
        if(trainee_group_in_shooting!=null)//正在射击的组，并且肯定有人
        {
            current_trainee_group_number=trainee_group_in_shooting.getGroupNumber();//3,当前编组
            String traineeIds=trainee_group_in_shooting.getTraineeIds();
            String[] traineeIdArray=traineeIds.split(",");

            for (int i=0;i<traineeIdArray.length;i++){
                int deviceGroupIndex=i+1;//靶位编号和traineeIdArray的下标对应只是靶位编号从1开始，所以加1
                TraineeShooting_DeviceGroup_Data traineeShooting_deviceGroup_data=new TraineeShooting_DeviceGroup_Data();
                traineeShooting_deviceGroup_data.setDeviceGroupIndex(deviceGroupIndex);
                int traineeId=Integer.parseInt(traineeIdArray[i].trim());
                Trainee trainee=traineeService.getTraineeById(traineeId);
                //设置靶位关于trainee的信息
                if(trainee!=null)// 果靶位上有人，即traineeId!=0,即traineeIdArray,中对应靶位的traineeId为0
                {
                    String name=trainee.getName();
                    int traineeStatus=trainee.getStatus();
                    String photo=trainee.getPhoto();
                    List<Scores> scoresList=scoresService.getScoresByTraineeId(traineeId);
                    Float totalScore=0.0f;
                    for(int j=0;j<scoresList.size();j++)
                    {
                        totalScore=totalScore+scoresList.get(j).getRingnumber();
                    }
                    traineeShooting_deviceGroup_data.setName(name);
                    traineeShooting_deviceGroup_data.setTraineeStatus(traineeStatus);
                    traineeShooting_deviceGroup_data.setPhoto(photo);
                    traineeShooting_deviceGroup_data.setTotalScore(totalScore);
                    traineeShooting_deviceGroup_data.setShootingScoreList(scoresList);

                }
                ////设置靶位关于设备状态的信息
                Device_Group device_group=deviceGroupService.getDeviceGroupByIndex(deviceGroupIndex);
                int display_index=device_group.getDisplayId();
                int camera_index=device_group.getCameraId();
                int target_index=device_group.getTargetId();
                Display display=displayService.getDisplayByIndex(display_index);
                Camera camera=cameraService.getCameraByIndex(camera_index);
                Target target=targetService.getTargetByIndex(target_index);

                int displayStatus=0;
                if (display!=null)
                {
                    displayStatus=display.getStatus();
                }
                int cameraStatus=0;
                if(camera!=null)
                {
                    cameraStatus=camera.getStatus();
                }
                int targetStatus=0;
                if(target!=null)
                {
                    targetStatus=target.getStatus();
                }
                traineeShooting_deviceGroup_data.setDisplayStatus(displayStatus);
                traineeShooting_deviceGroup_data.setCameraStatus(cameraStatus);
                traineeShooting_deviceGroup_data.setTargetStatus(targetStatus);
                //
                traineeShooting_deviceGroup_data_list.add(traineeShooting_deviceGroup_data);
            }

        }else //当前没有打靶的人，取出全部靶位，来获取靶位设备状态信息
        {
            PageResult<Device_Group> deviceGroupList=deviceGroupService.getAll();
            for(int i=0;i<deviceGroupList.getData().size();i++){
                TraineeShooting_DeviceGroup_Data traineeShooting_deviceGroup_data=new TraineeShooting_DeviceGroup_Data();
                Device_Group device_group=deviceGroupList.getData().get(i);
                traineeShooting_deviceGroup_data.setDeviceGroupIndex(i+1);//设置靶位编号：1，2....
                int display_index=device_group.getDisplayId();
                int camera_index=device_group.getCameraId();
                int target_index=device_group.getTargetId();
                Display display=displayService.getDisplayByIndex(display_index);
                Camera camera=cameraService.getCameraByIndex(camera_index);
                Target target=targetService.getTargetByIndex(target_index);

                int displayStatus=0;
                if (display!=null)
                {
                    displayStatus=display.getStatus();
                }
                int cameraStatus=0;
                if(camera!=null)
                {
                    cameraStatus=camera.getStatus();
                }
                int targetStatus=0;
                if(target!=null)
                {
                    targetStatus=target.getStatus();
                }
                traineeShooting_deviceGroup_data.setTargetStatus(targetStatus);
                traineeShooting_deviceGroup_data.setDisplayStatus(displayStatus);
                traineeShooting_deviceGroup_data.setCameraStatus(cameraStatus);
                traineeShooting_deviceGroup_data_list.add(traineeShooting_deviceGroup_data);
            }
        }
        shootingRangeData.setTraineeShooting_deviceGroup_data(traineeShooting_deviceGroup_data_list);
        shootingRangeData.setNextGroupTraineeNames(nextGroupTraineeName);
        shootingRangeData.setCurrentTrainneeGroupIndex(current_trainee_group_number);
        shootingRangeData.setSumOfTraineeGroupCount(sum_trainee_group_count);
        shootingRangeData.setTraineeCountFinishShooting(trainee_count_finish_shooting);
        shootingRangeData.setTraineeCountNotShooting(trainee_count_not_finish_shooting);
        shootingRangeData.setSumOfTraineeCount(trainee_count_all);
        shootingRangeData.setTraineeCountAbsentShooting(trainee_count_absent_shooting);
        System.out.print(JSON.toJSONString(shootingRangeData));
        return JsonData.success(shootingRangeData);
    }
    @RequestMapping("/startShooting.json")
    @ResponseBody
    public JsonData startShooting() throws ParseException {
        Trainee_Group trainee_group_in_shooting=traineeGroupService.getTraineeGroupInShooting();//当前射击编组
        if(trainee_group_in_shooting!=null)//
        {
            String traineeIds=trainee_group_in_shooting.getTraineeIds();
            String[] traineeIdArray=traineeIds.split(",");
            for (int i=0;i<traineeIdArray.length;i++) {//修改新进入靶位者的状态，同时把对应信息推入对应靶位的display
                int traineeId = Integer.parseInt(traineeIdArray[i].trim());
                Trainee trainee = traineeService.getTraineeById(traineeId);
                String displayMac = "";
                if(trainee!=null) {
                    //取得靶位对应的display的mac
                    int deviceGroupIndex=i+1;
                    Device_Group device_group=deviceGroupService.getDeviceGroupByIndex(deviceGroupIndex);
                    if(device_group!=null) {
                        int displayIndex = device_group.getDisplayId();
                        Display display = displayService.getDisplayByIndex(displayIndex);
                        if(display!=null){
                            displayMac=display.getMac();
                        }
                    }
                    //endmac
                    //
                    int trainingId=trainee.getTrainingId();
                    Training training=trainingService.getTrainingById(trainingId);
                    String target_number=deviceGroupIndex+"";
                    String group_number=trainee_group_in_shooting.getGroupNumber().toString();
                    String memo=trainee.getMemo();
                    String name=trainee.getName();
                    String password=trainee.getPassword();
                    String photo=trainee.getPhoto();
                    String gun=training.getGun();
                    int bullet_count=training.getBulletNumber();
                    int status=trainee.getStatus();
                    String workunit=trainee.getWorkunit();
                    String phone=trainee.getPhone();
                    //更改trainee状态，其实就是更改了status:2待登陆状态
                    TraineeParam param = new TraineeParam();
                    param.setId(traineeId);
                    param.setMemo(memo);
                    param.setName(name);
                    param.setPassword(password);
                    param.setPhoto(photo);
                    param.setStatus(TraineeStatus.IS_SHOOTING);//更改打靶人状态，为正在射击状态
                    param.setTrainingId(trainingId);
                    param.setWorkunit(workunit);
                    param.setPhone(phone);
                    traineeService.update(param);
                    //更改服务器端的显示状态
                    Integer target_index=-1;
                    target_index=trainee.getTargetIndex();
                    JSONObject traineeJson=new JSONObject();
                    JSONObject data=new JSONObject();
                    traineeJson.put("code",0);//code=0用户的状态数据（未登陆，已登陆．正在射击）,(code=1前端传回的打靶数据)
                    data.put("targetIndex",target_index);
                    data.put("traineeStatus",TraineeStatus.IS_SHOOTING);
                    traineeJson.put("data",data);
                    infoHandler().sendMessageToUsers( new TextMessage(traineeJson.toJSONString())) ;

                    //向消息队列发出射击者需要显示界面信息
                    Command shootingCommand=new Command();
                    shootingCommand.setCode(0);
                    shootingCommand.setMessage("开始射击");
                    shootingCommand.setDataType(ServerCommand.STARTSHOOTING_COMMAND);

                    ShootingInfo shootingInfo=new ShootingInfo();
                    shootingInfo.setBullet_count(bullet_count);
                    shootingInfo.setDepartment(workunit);
                    shootingInfo.setGroup_number(group_number);
                    shootingInfo.setName(name);
                    shootingInfo.setShooting_gun(gun);
                    shootingInfo.setUserId(traineeId+"");
                    shootingInfo.setTarget_number(target_number);
                    shootingCommand.setData(shootingInfo);
                    JSONObject jo= (JSONObject) JSONObject.toJSON(shootingCommand);
                    messageProducer.sendTopicMessage("server-to-display-exchange","server-to-display-routing-key-"+displayMac,jo.toJSONString());


                }
            }
        }
        return null;
    }

}
