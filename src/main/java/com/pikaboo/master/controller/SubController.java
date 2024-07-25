package com.pikaboo.master.controller;


import com.pikaboo.master.dto.ImageSet;
import com.pikaboo.master.model.service.ImageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.Map;

@Controller
@RequestMapping("/upload")
public class SubController {

    @Autowired
    ImageService service;

    @GetMapping
    public String redirectToMain() {

        return "errorPage";
    }

    @GetMapping("/create")
    public String uploadMain() {
        return "uploadPage";
    }
    @PostMapping("/create")
    public String uploadMainPost(@RequestParam("targetImage") MultipartFile file, @RequestParam("userName") String name ) {
        System.out.println(file);
        System.out.println(name);
        String uploadDir = System.getProperty("user.dir") + "/src/main/resources/static/userGroup/" + name + "/";
        Path uploadPath = Paths.get(uploadDir);

        try {
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }
            String filePath = uploadDir + file.getOriginalFilename();
            System.out.println(filePath);
            Path destination = Paths.get(filePath);
            file.transferTo(destination.toFile());

            ImageSet tempImageSet = new ImageSet();
            tempImageSet.setId("1");
            tempImageSet.setUserName(name);
            tempImageSet.setImgUrl("/userGroup/" + name + "/uploads/" + file.getOriginalFilename());
            tempImageSet.setLikeStatus(0);
            tempImageSet.setPrivateCheck(false);

            service.add(tempImageSet);
        } catch (Exception err) {
            err.printStackTrace();
        }




        return "redirect:/intro";
    }



}