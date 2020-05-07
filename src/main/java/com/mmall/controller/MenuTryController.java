package com.mmall.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("sys/menu")
@Slf4j
public class MenuTryController {
    @RequestMapping("menutry.page")
    public ModelAndView page() {
        return new ModelAndView("menutry");
    }
}
