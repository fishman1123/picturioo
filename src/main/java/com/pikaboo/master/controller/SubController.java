package com.pikaboo.master.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/upload")
public class SubController {
    @GetMapping
    public String redirectToMain() {

        return "errorPage";
    }

    @GetMapping("/create")
    public String uploadMain() {
        return "uploadPage";
    }
    @PostMapping("/create")
    public String uploadMainPost() {
        System.out.println("moved to post");
        return "subTest";
    }


}