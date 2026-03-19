package com.board.springboard.common;


import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Value("${file.upload.path}")
    private String uploadPath;

    @Value("${file.upload.board-path}")
    private String boardUploadPath;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        /**
         * 유저 프로필 사진 매핑
         * 웹   URL : /uploads/profile/**
         * 실제경로 : C:/upload/profile/
         */
        registry.addResourceHandler("/uploads/profile/**")
                .addResourceLocations("file:///" + uploadPath + "/");
        /**
         * 게시물 첨부 이미지 매핑
         * 웹   URL : /board/**
         * 실제경로 : C:/uploads/board/
         * 클라이언트에게 보이는 경로와 실제 회사에 저장된 파일의 경로를 다르게 보여줄 수 있다.
         */
        registry.addResourceHandler("/board/**")
                .addResourceLocations("file:///" + boardUploadPath + "/");
    }
}