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
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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
            System.out.println("Original file path: " + filePath);

            // Extract the username from the original URL
            Pattern pattern = Pattern.compile("/userGroup/([^/]+)/.+");
            Matcher matcher = pattern.matcher(originalUrl);
            String userName = null;
            if (matcher.find()) {
                userName = matcher.group(1);
            }

            if (userName == null) {
                redirectAttributes.addFlashAttribute("message", "Invalid original URL format");
                return "redirect:/main";
            }

            // Extract original file name and extension
            String originalFileName = targetFile.getOriginalFilename();
            System.out.println("Original file name: " + originalFileName);
            String fileExtension = "";
            String fileNameWithoutExtension = originalFileName;

            int dotIndex = originalFileName.lastIndexOf(".");
            if (dotIndex > 0 && dotIndex < originalFileName.length() - 1) {
                fileExtension = originalFileName.substring(dotIndex);
                fileNameWithoutExtension = originalFileName.substring(0, dotIndex);
            }

            // Generate new UUID
            String uuid = UUID.randomUUID().toString();

            // Create new URL with new UUID
            String dateStr = new SimpleDateFormat("yyyyMMdd").format(new Date());
            String newFileName = uuid + "_" + fileNameWithoutExtension + "_" + dateStr + fileExtension;
            String newFilePath = System.getProperty("user.home") + "/Desktop/userGroup/" + userName + "/" + newFileName;

            // Ensure the directory exists
            Path newUploadPath = Paths.get(newFilePath).getParent();
            if (!Files.exists(newUploadPath)) {
                Files.createDirectories(newUploadPath);
            }

            // Save the new file to the new path
            Path newPath = Paths.get(newFilePath);
            targetFile.transferTo(newPath.toFile());

            // Update the URL in the database
            service.editUrl("/userGroup/" + userName + "/" + newFileName, originalUrl);

            // Delete the old image
            Path oldPath = Paths.get(filePath);
            if (Files.exists(oldPath)) {
                Files.delete(oldPath);
            }

            // Add success message
            redirectAttributes.addFlashAttribute("message", "You successfully uploaded '" + targetFile.getOriginalFilename() + "'");

        } catch (IOException | SQLException e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("message", "An error occurred while uploading the file");
        }

        return "redirect:/main";
    }



    @PostMapping("/delete")
    @ResponseBody
    public ResponseEntity<String> deleteImg(@RequestBody Map<String, String> request) {
        String imageUrl = request.get("url");

        try {
            // Extract the file path from the URL
            String filePath = System.getProperty("user.home") + "/Desktop" + imageUrl.substring(imageUrl.indexOf("/userGroup"));
            Path path = Paths.get(filePath);

            // Delete the file from the file system
            if (Files.exists(path)) {
                Files.delete(path);
            }

            // Remove the database record
            service.removeUrl(imageUrl);

            return ResponseEntity.ok("Image deleted successfully");
        } catch (IOException | SQLException e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("An error occurred while deleting the image");
        }
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
