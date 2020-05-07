package com.mmall.controller;

import com.alibaba.fastjson.JSONObject;
import com.mmall.beans.*;
import com.mmall.common.JsonData;
import com.mmall.config.SpringWebSocketHandler;
import com.mmall.model.Trainee;
import com.mmall.model.Trainee_Group;
import com.mmall.param.AclParam;
import com.mmall.param.TraineeGroupParam;
import com.mmall.param.TraineeParam;
import com.mmall.service.DeviceGroupService;
import com.mmall.service.TraineeGroupService;
import com.mmall.service.TraineeService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.socket.TextMessage;

import javax.annotation.Resource;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/sys/trainee")
@Slf4j
public class TraineeController {

    @Bean//这个注解会从Spring容器拿出Bean
    public SpringWebSocketHandler infoHandler() {

        return new SpringWebSocketHandler();
    }

    @Resource
    private TraineeService traineeService;

    @Resource
    private DeviceGroupService deviceGroupService;

    @Resource
    private TraineeGroupService traineeGroupService;

    @RequestMapping("trainee.page")
    public ModelAndView page() {
        return new ModelAndView("trainee");
    }

    //实施分组动作
    @RequestMapping("group.page")
    public ModelAndView groupPage() {
        return new ModelAndView("traineegroup");
    }

    @RequestMapping("traineegroupquery.page")
    public ModelAndView groupStatePage() {
        return new ModelAndView("traineegroupquery");
    }




    @RequestMapping("/save.json")
    @ResponseBody
    public JsonData saveTrainee(TraineeParam param) throws ParseException {
        traineeService.save(param);
        return JsonData.success();
    }

    @RequestMapping("/update.json")
    @ResponseBody
    public JsonData updateTrainee(TraineeParam param) throws ParseException {
        traineeService.update(param);
        return JsonData.success();
    }

/*    @RequestMapping("/page.json")
    @ResponseBody
    public JsonData page(PageQuery pageQuery) {
        PageResult<Trainee> result = traineeService.getPage(pageQuery);
        return JsonData.success(result);
    }*/

    @RequestMapping("/delete.json")
    @ResponseBody
    public JsonData delete(@RequestParam("id") int id) {
        traineeService.delete(id);
        return JsonData.success();
    }

    @RequestMapping("/pageByTrainingId.json")
    @ResponseBody
    public JsonData page(@RequestParam("trainingId") int trainingId,PageQuery pageQuery) {
        PageResult<Trainee> result = traineeService.getPageByTrainingId(trainingId, pageQuery);;
        return JsonData.success(result);
    }
    //更新靶位编组调整之前后靶位之间的调整
    @RequestMapping("/updateTraineeGroup_target.json")
    @ResponseBody
    public JsonData updateTraineeGroup_for_target_exchage(@RequestParam("id") int traineeGroupId,@RequestParam("trainee_ids") String trainee_ids) throws ParseException {
        TraineeGroupParam traineeGroupParam=new TraineeGroupParam();
        traineeGroupParam.setId(traineeGroupId);
        traineeGroupParam.setTrainee_ids(trainee_ids);
        traineeGroupService.update(traineeGroupParam);//TODO:用事务
        String[] traineeIdArray=trainee_ids.split(",");
        for(int i=0;i<traineeIdArray.length;i++){
            int target_index=i+1;//
            int traineeId=Integer.parseInt(traineeIdArray[i].trim());
            TraineeParam traineeParam=new TraineeParam();
            traineeParam.setId(traineeId);
            traineeParam.setTarget_index(target_index);
            traineeService.update(traineeParam);
        }
        return JsonData.success();
    }

    //更新靶位编组调整之编组之间的调整

    @RequestMapping("/updateTraineeGroup_group.json")
    @ResponseBody
    public JsonData updateTraineeGroup_for_group_exchage(@RequestParam("id1") int traineeGroupId1,@RequestParam("group_index") int group_index,@RequestParam("trainee_ids1") String trainee_ids1,@RequestParam("id2") int traineeGroupId2,@RequestParam("group_index_before_or_next") int group_index_before_or_next,@RequestParam("trainee_ids2") String trainee_ids2) throws ParseException {
        TraineeGroupParam traineeGroupParam1=new TraineeGroupParam();
        traineeGroupParam1.setId(traineeGroupId1);
        traineeGroupParam1.setTrainee_ids(trainee_ids1);

        TraineeGroupParam traineeGroupParam2=new TraineeGroupParam();
        traineeGroupParam2.setId(traineeGroupId2);
        traineeGroupParam2.setTrainee_ids(trainee_ids2);
        //TODO:添加事务操作应该
        traineeGroupService.update(traineeGroupParam1);
        traineeGroupService.update(traineeGroupParam2);

        //调整完TraineeGroup还应该调整trainee
        String[] traineeIdArray1=trainee_ids1.split(",");
        for(int i=0;i<traineeIdArray1.length;i++){
            int target_index1=i+1;//
            int traineeId1=Integer.parseInt(traineeIdArray1[i].trim());
            TraineeParam traineeParam1=new TraineeParam();
            traineeParam1.setId(traineeId1);
            traineeParam1.setGroup_index(group_index);
            traineeService.update(traineeParam1);
        }

        String[] traineeIdArray2=trainee_ids2.split(",");
        for(int j=0;j<traineeIdArray2.length;j++){
            int target_index2=j+1;//
            int traineeId2=Integer.parseInt(traineeIdArray2[j].trim());
            TraineeParam traineeParam2=new TraineeParam();
            traineeParam2.setId(traineeId2);
            traineeParam2.setGroup_index(group_index_before_or_next);
            traineeService.update(traineeParam2);
        }

        return JsonData.success();
    }
    //获取用户分组数据
    @RequestMapping("/traineeGroupPage.json")
    @ResponseBody
    public JsonData traineeGroupPage(PageQuery pageQuery) {
        PageResult<Trainee_Group> result = traineeGroupService.getPage(pageQuery);
        TraineeGroupQuery traineeGroupQuery=new TraineeGroupQuery();
        List<TraineeGroup> traineeGroupList=new ArrayList<>();
        List<DeviceGroupData> deviceGroupDataList=new ArrayList<>();
        Boolean deviceGroupDataList_filled=false;//还未获得该值

        if(result!=null) {
            List<Trainee_Group> trainee_groupList = result.getData();
            for(int i=0;i<trainee_groupList.size();i++){
                Trainee_Group trainee_Group=trainee_groupList.get(i);
                TraineeGroup traineeGroup=new TraineeGroup();
                List<Trainee> traineeList=new ArrayList<>();
                int groupNumber=trainee_Group.getGroupNumber();
                int id=trainee_Group.getId();
                traineeGroup.setGroupNumber(groupNumber);//
                traineeGroup.setId(id);
                String traineeIds=trainee_Group.getTraineeIds();
                String[] traineeIdArray=traineeIds.split(",");

                for(int n=0;n<traineeIdArray.length;n++) {
                    if(!deviceGroupDataList_filled){
                        DeviceGroupData deviceGroupData=new DeviceGroupData();
                        deviceGroupData.setDeviceGroupIndex(n+1);
                        deviceGroupDataList.add(deviceGroupData);
                    }
                    Trainee trainee =new Trainee();
                    Trainee trainee1=traineeService.getTraineeById(Integer.parseInt(traineeIdArray[n].trim()));
                    if(trainee1==null) {
                        traineeList.add(trainee);
                    }else {
                        traineeList.add(trainee1);
                    }
                }
                deviceGroupDataList_filled=true;
                traineeGroup.setTraineeList(traineeList);
                traineeGroup.setTraineeIds(traineeIds);
                traineeGroupList.add(traineeGroup);
            }
            traineeGroupQuery.setTraineeGroupList(traineeGroupList);
            traineeGroupQuery.setTotal(result.getTotal());
            traineeGroupQuery.setDeviceGroupNumberList(deviceGroupDataList);
        }
        return JsonData.success(traineeGroupQuery);
    }



    @RequestMapping(value="/login",produces = "application/json; charset=utf-8")
    @ResponseBody
    public String login(@RequestParam("id") String traineeId,@RequestParam("password") String password) throws ParseException {
        int traineeid=Integer.parseInt(traineeId);
        TraineeParam traineeParam=new TraineeParam();
        traineeParam.setId(traineeid);
        traineeParam.setStatus(TraineeStatus.NORMAL_LOGIN);
        traineeService.update(traineeParam);
        Integer target_index=-1;
        Trainee trainee=traineeService.getTraineeById(traineeid);
        target_index=trainee.getTargetIndex();
        JSONObject traineeJson=new JSONObject();
        JSONObject data=new JSONObject();
        traineeJson.put("code",0);//code=0用户的状态数据（未登陆，已登陆．正在射击）,(code=1前端传回的打靶数据)
        data.put("targetIndex",target_index);//targetIndex代表靶位编号，其实应该是deviceGroupIndex，但在设计数据
        // 库trainee时里边的靶位号用成了targetIndex，而后来靶位是 display,target,camera的合体所以后来改成了deviceGroupIndex,
        //但数据库没有改还用targetIndex代表靶位号
        data.put("traineeStatus",TraineeStatus.NORMAL_LOGIN);
        traineeJson.put("data",data);
        infoHandler().sendMessageToUsers( new TextMessage(traineeJson.toJSONString())) ;
        String responsejson="{\"code\":1,message:\"登陆成功\",\"data\":{\"userId\":\"1\",\"name\":\"张三\",\"department\":\"xxxx单位\",\"shooting_gun\":\"五六式手枪\",\"bullet_count\":10,\"target_number\":\"2\",\"group_number\":\"1\"}}";
        return  responsejson;//App其实不需要返回数据了，需要null也可以，因为app只显示等待界面
    }

    //对trainee进行分组
    @RequestMapping("/group.json")
    @ResponseBody
    public JsonData group(@RequestParam("id") int trainingId,@RequestParam("number") int number,@RequestParam("selecteddevicegroup")String selecteddevicegroup) throws ParseException {
        List<Integer> traineeIds=traineeService.getTraineeIds(trainingId);
        List<List<Integer>> traineeIdsGroups = group(traineeIds,number);
        int deviceGroupsCount=deviceGroupService.getCount();
        String[] selectedDeviceGroups=selecteddevicegroup.split(",");
        traineeGroupService.deleteAll();
        for(int i=0;i<traineeIdsGroups.size();i++){
            int[] traineeIdsGroup=new int[deviceGroupsCount];//默认情况下，每组的打靶人员数目和靶位数是相等的
            List<Integer>traineeIdsInOneGroup=traineeIdsGroups.get(i);//取得一个分组
            for(int j=0;j<traineeIdsInOneGroup.size();j++){
                traineeIdsGroup[Integer.parseInt(selectedDeviceGroups[j])-1]=traineeIdsInOneGroup.get(j);//将人员编入靶位
                TraineeParam traineeParam=new TraineeParam();
                traineeParam.setId(traineeIdsInOneGroup.get(j));
                traineeParam.setGroup_index(i+1);
                traineeParam.setTarget_index(j+1);
                traineeService.update(traineeParam);

            }
            TraineeGroupParam traineeGroupParam=new TraineeGroupParam();
            traineeGroupParam.setGroup_number(i+1);
            traineeGroupParam.setTraining_id(trainingId);
            traineeGroupParam.setTrainee_ids(Arrays.toString(traineeIdsGroup).substring(1,Arrays.toString(traineeIdsGroup).length()-1));//去掉队列两端的[ 和]
            try {
                traineeGroupService.save(traineeGroupParam);
            }catch (Exception e){

            }

        }

        return JsonData.success();
    }


    public  List<List<Integer>> group(List<Integer> list, Integer n) {//n代表每组多少人

        int listsize=list.size();
        float fenzushu=(float)listsize / n ;
        // 求分组数
        int count0 = (int) Math.ceil(fenzushu);

        List<List<Integer>> data = new ArrayList<List<Integer>>();
        // 遍历list到余数前
        for (int i = 0; i < count0; i++) {
            List<Integer> ls = null;
            int endex = i * n + n;
            if(endex>=list.size()){
                endex=list.size();
            }

            ls = new ArrayList<Integer>(list.subList(i * n, endex));

            data.add(ls);
        }
        return data;
    }

}
