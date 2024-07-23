package com.pikaboo.master.controller;


import com.pikaboo.master.dto.ImageSet;
import com.pikaboo.master.model.service.ImageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.sql.SQLException;
import java.util.List;

@Controller
@RequestMapping("/")
public class MainController {

    @Autowired
    ImageService service;

    @GetMapping
    public String redirectToMain() {
        return "redirect:/main";
    }
    @GetMapping("/main")
    public String masterMain(Model model) {
        try {
            ImageSet imgSet = service.read(1);
            model.addAttribute("imgSet", imgSet);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "index";
    }


}
