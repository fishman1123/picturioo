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
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.Map;
import java.util.UUID;

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
    public String uploadMainPost(@RequestParam("targetImage") MultipartFile file,
                                 @RequestParam("userName") String name) {
        System.out.println(file);
        System.out.println(name);

        String dateStr = new SimpleDateFormat("yyyyMMdd").format(new Date());
        String uploadDir = System.getProperty("user.home") + "/Desktop/userGroup/" + name + "/";
        Path uploadPath = Paths.get(uploadDir);

        try {
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }

            String originalFileName = file.getOriginalFilename();
            String fileExtension = "";
            String fileNameWithoutExtension = originalFileName;

            int dotIndex = originalFileName.lastIndexOf(".");
            if (dotIndex > 0 && dotIndex < originalFileName.length() - 1) {
                fileExtension = originalFileName.substring(dotIndex);
                fileNameWithoutExtension = originalFileName.substring(0, dotIndex);
            }


            String uuid = UUID.randomUUID().toString();

            String newFileName = uuid + "_" + fileNameWithoutExtension + "_" + dateStr + fileExtension;
            String filePath = uploadDir + newFileName;
            System.out.println(filePath);
            Path destination = Paths.get(filePath);
            file.transferTo(destination.toFile());

            ImageSet tempImageSet = new ImageSet();
            tempImageSet.setId("1");
            tempImageSet.setUserName(name);
            tempImageSet.setImgUrl("/userGroup/" + name + "/" + newFileName);
            tempImageSet.setLikeStatus(0);
            tempImageSet.setPrivateCheck(false);
            tempImageSet.setCreatedAt(LocalDateTime.now());

            service.add(tempImageSet);
        } catch (Exception err) {
            err.printStackTrace();
        }

        return "redirect:/main";
    }
}
