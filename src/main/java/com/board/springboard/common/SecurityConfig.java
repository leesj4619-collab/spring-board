package com.board.springboard.common;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {
    // 파일 같은 경우 -> common에서 수제 제작해서 사용할 것
    // private final JwtProvider jwtProvider;

}
