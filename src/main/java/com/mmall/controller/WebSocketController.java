package com.mmall.controller;

import com.mmall.config.SpringWebSocketHandler;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.socket.TextMessage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/sys/websocket")
@Slf4j
public class WebSocketController {

    @Bean//这个注解会从Spring容器拿出Bean
    public SpringWebSocketHandler infoHandler() {

        return new SpringWebSocketHandler();
    }


    @RequestMapping("websocket.loginpage")
    public ModelAndView page() {
        return new ModelAndView("login");
    }

    @RequestMapping("/login.json")
    public ModelAndView login(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String username = request.getParameter("username");
        System.out.println(username+"登录");
        HttpSession session = request.getSession(false);
        session.setAttribute("SESSION_USERNAME", username); //一般直接保存user实体
        return new ModelAndView("send");
    }

    @RequestMapping("/send.json")
    @ResponseBody
    public String send(HttpServletRequest request) {
        String username = request.getParameter("username");
        infoHandler().sendMessageToUser(username, new TextMessage("你好，测试！！！！"));
        return null;
    }


    @RequestMapping("/broad.json")
    @ResponseBody
    public  String broad() {
        infoHandler().sendMessageToUsers(new TextMessage("发送一条小Broad"));
        System.out.println("群发成功");
        return "broad";
    }

}