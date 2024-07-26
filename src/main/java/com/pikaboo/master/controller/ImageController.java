package com.pikaboo.master.controller;

import ch.qos.logback.core.model.Model;
import com.pikaboo.master.dto.ImageSet;
import com.pikaboo.master.model.service.ImageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/image")

public class ImageController {
    @Autowired
    ImageService service;

    @GetMapping("/all")
    @ResponseBody
    public ResponseEntity<List<ImageSet>> getAll() {
        try {
            List<ImageSet> list = service.readAll();

            return ResponseEntity.ok(list);
        } catch (SQLException e) {
            e.printStackTrace();
            return ResponseEntity.status(500).build();
        }
    }

    @PostMapping("/edit")
    public String editImg(@RequestParam("targetImage") MultipartFile targetFile,
                          @RequestParam("originalUrl") String originalUrl,
                          RedirectAttributes redirectAttributes) {

        if (targetFile.isEmpty()) {
            redirectAttributes.addFlashAttribute("message", "Please select a file to upload");
            return "redirect:/main";
        }

        try {
            // Extract the file path from the original URL
            String filePath = System.getProperty("user.home") + "/Desktop" + originalUrl.substring(originalUrl.indexOf("/userGroup"));
            System.out.println(filePath);

            // Save the new file to the same path, thereby overwriting the old file
            Path path = Paths.get(filePath);
            targetFile.transferTo(path.toFile());

            // Add success message
            redirectAttributes.addFlashAttribute("message", "You successfully uploaded '" + targetFile.getOriginalFilename() + "'");

        } catch (IOException e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("message", "An error occurred while uploading the file");
        }

        return "redirect:/main";
    }


    @PostMapping("/delete")
    public String deleteImg(int targetid) {

        return "redirect:/main";
    }

    private String extractUserNameFromPath(String originalUrl) {
        String[] parts = originalUrl.split("/");
        return parts[parts.length - 2]; // Assuming the username is the second last part of the path
    }

//    @PostMapping("/save")
//    public String deleteImg(int targetid) {
//
//        return "redirect:/main";
//    }


}
