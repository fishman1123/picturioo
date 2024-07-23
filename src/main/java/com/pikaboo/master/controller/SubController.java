package com.pikaboo.master.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/sub")
public class SubController {
    @GetMapping("/")
    public String masterMain() {
        return "subTest";
    }


}