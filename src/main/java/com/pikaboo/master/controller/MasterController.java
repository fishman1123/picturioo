package com.pikaboo.master.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class MasterController {
    @GetMapping("/main")
    public String masterMain() {
        return "index";
    }

}
