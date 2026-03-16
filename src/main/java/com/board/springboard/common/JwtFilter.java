package com.board.springboard.common;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

/**
 * JWT 토큰 발급 검증
 *
 * Access Token : 30 -> 매 API 요청 헤더 or 쿠키 첨부
 * Refresh Token : 14일 -> 임시 저장 / 만료 시 재발급용 (=Redis 임시 저장)
 *                  ConcurrentHashMap 컴퓨터 메모리 임시 저장
 */
@Slf4j
@Component
public class JwtFilter {
}
