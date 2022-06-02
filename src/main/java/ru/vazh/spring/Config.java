package ru.vazh.spring;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
@EnableWebMvc
public class Config implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/video/**")
                .addResourceLocations("file://" + "/Users/valerijzarkov/Downloads/Diplom/src/main/webapp/resources/files/video" + "/");
//                .addResourceLocations("/resources/files/video/");
        registry.addResourceHandler("/img/**")
                .addResourceLocations("file://" + "/Users/valerijzarkov/Downloads/Diplom/src/main/webapp/resources/files/images" + "/");
        registry.addResourceHandler("/audio/**")
                .addResourceLocations("file://" + "/Users/valerijzarkov/Downloads/Diplom/src/main/webapp/resources/files/audio" + "/");
    }
}
