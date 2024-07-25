package com.pikaboo.master.controller;


import com.pikaboo.master.dto.ImageSet;
import com.pikaboo.master.model.service.ImageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.sql.SQLException;
import java.util.List;

@Controller
@RequestMapping("/")
public class MainController {

    @Autowired
    ImageService service;

    @GetMapping
    public String redirectToMain() {
        return "redirect:/intro";
    }

    @GetMapping("/intro")
    public String introMain(Model model) {
        return "introPage";
    }

    @GetMapping("/main")
    public String masterMain(Model model) {
        try {
//            ImageSet imgSet = service.read(1);// 하나만 가지고 올 경우
//            model.addAttribute("imgSet", imgSet);
            List<ImageSet>list = service.readAll();
            model.addAttribute("list", list);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "index";
    }


}
