package com.pikaboo.master.controller;

import com.pikaboo.master.dto.ImageSet;
import com.pikaboo.master.model.service.ImageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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

    @PostMapping("/delete")
    public String deleteImg(int targetid) {

        return "redirect:/main";
    }
}
