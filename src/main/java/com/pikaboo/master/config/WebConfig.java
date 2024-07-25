package com.pikaboo.master.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        String userGroupPath = System.getProperty("user.home") + "/Desktop/userGroup/";
        registry.addResourceHandler("/userGroup/**")
                .addResourceLocations("file:" + userGroupPath);
    }
}