package com.pikaboo.master.controller;

import ch.qos.logback.core.model.Model;
import com.pikaboo.master.dto.ImageSet;
import com.pikaboo.master.model.service.ImageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;
import java.util.List;

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

//    @GetMapping("/edit")
//    public String edit(@RequestParam("id") int targetId,  Model model) {
//        try {
//            model.addAttribute("imageMan", service.read(targetId));
//        }catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return "index";
//    }

    @PostMapping("/delete")
    public String deleteImg(int targetid) {

        return "redirect:/main";
    }
}
