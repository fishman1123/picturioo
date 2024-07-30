package com.pikaboo.master.controller;

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

        //예외처리
        if (targetFile.isEmpty()) {
            redirectAttributes.addFlashAttribute("message", "Please select a file to upload");
            return "redirect:/main";
        }


        try {
            //파일 저장경로 할당
            String filePath = System.getProperty("user.home") + "/Desktop" + originalUrl.substring(originalUrl.indexOf("/userGroup"));

            //정규표현식을 통한 유저이름 확인
            Pattern pattern = Pattern.compile("/userGroup/([^/]+)/.+");
            Matcher matcher = pattern.matcher(originalUrl);
            String userName = null;
            if (matcher.find()) {
                userName = matcher.group(1);
            }
            //예외처리 자카르타 코어방식으로 리턴값 노출
            if (userName == null) {
                redirectAttributes.addFlashAttribute("message", "Invalid original URL format");
                return "redirect:/main";
            }

            //파일 이름 할당
            String originalFileName = targetFile.getOriginalFilename();
            String fileExtension = "";
            String fileNameWithoutExtension = originalFileName;

            //확장자 확인
            int dotIndex = originalFileName.lastIndexOf(".");
            if (dotIndex > 0 && dotIndex < originalFileName.length() - 1) {
                fileExtension = originalFileName.substring(dotIndex);
                fileNameWithoutExtension = originalFileName.substring(0, dotIndex);
            }

            //uuid를 통한 독립성 부여
            String uuid = UUID.randomUUID().toString();

            //날짜선언 및 이름 할당
            String dateStr = new SimpleDateFormat("yyyyMMdd").format(new Date());
            String newFileName = uuid + "_" + fileNameWithoutExtension + "_" + dateStr + fileExtension;
            //새로운 경로를 위한 로컬 세이브 할당
            String newFilePath = System.getProperty("user.home") + "/Desktop/userGroup/" + userName + "/" + newFileName;


            //현재 경로의 부모 반환
            Path newUploadPath = Paths.get(newFilePath).getParent();
            if (!Files.exists(newUploadPath)) {
                Files.createDirectories(newUploadPath);
            }

            //새로운 저장경로 할당 및 저장
            Path newPath = Paths.get(newFilePath);
            targetFile.transferTo(newPath.toFile());

            //디비처리
            service.editUrl("/userGroup/" + userName + "/" + newFileName, originalUrl);

            //예전파일에 대한 파일 추적 후 삭제
            Path oldPath = Paths.get(filePath);
            if (Files.exists(oldPath)) {
                Files.delete(oldPath);
            }
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
            String filePath = System.getProperty("user.home") + "/Desktop" + imageUrl.substring(imageUrl.indexOf("/userGroup"));
            Path path = Paths.get(filePath);

            if (Files.exists(path)) {
                Files.delete(path);
            }

            service.removeUrl(imageUrl);

            return ResponseEntity.ok("Image deleted successfully");
        } catch (IOException | SQLException e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("An error occurred while deleting the image");
        }
    }

    private String extractUserNameFromPath(String originalUrl) {
        String[] parts = originalUrl.split("/");
        return parts[parts.length - 2];
    }



}
