package com.board.springboard.common;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

/**
 * JWT 토큰 발급 검증
 *
 * Access Token : 30 -> 매 API 요청 헤더 or 쿠키 첨부
 * Refresh Token : 14일 -> 임시 저장 / 만료 시 재발급용 (=Redis 임시 저장)
 *                  ConcurrentHashMap 컴퓨터 메모리 임시 저장
 *************************************************************************
 * 브라우저가 서버에 요청을 보낼 때마다 자동으로 실행
 * 쿠키에서 액세스 토큰을 꺼내서 유효하면 로그인상태로 등록
 */


@Slf4j
@Component
@RequiredArgsConstructor
public class JwtFilter extends OncePerRequestFilter {
    private final JwtUtil jwtUtil; // 토큰 검증은 util 맡긴다.
    private final CookieUtil cookieUtil;

    /**
     * protected    void     doFilterInternal
     * 상속받은     전달할것        의 뜻
     * 자식만        없다        doFilter = 필터를 실행하겠다
     * 이용가능                 Internal = Spring이 만든 내부 기능을
     * ******************************************************************************
     * @param 요청                브라우저가 보낸 요청 경로
     * @param 응답                브라우저 요청에 대한 응답을 서버가 전달할 때 들고갈 정보
     * @param 다음필터             우리 필터 작업은 끝났고, 다음 작업으로 바통터치할 때 사용
     * @throws ServletException   서버   연결   에러 발생하는 경우
     * @throws IOException        데이터 주고 받을 때 발생하는 경우
     */
    @Override
    protected void doFilterInternal(HttpServletRequest 요청,
                                    HttpServletResponse 응답,
                                    FilterChain 다음필터) throws ServletException, IOException {
  //      String token = 쿠키에서토큰꺼내기(요청); // 쿠키에서 access_token 꺼내기 없으면 null 반환!
        String token = cookieUtil.가져오기(요청, "access_token");
        // 토큰이 있고 유효하면 -> 스프링 보안팀(=시큐리티)에 로그인 상태 등록
        // 토큰이 존재하고 만료/변조된 토큰이 아니면
        if (token != null && jwtUtil.유효토큰인지확인하는기능(token)) {
            String email = jwtUtil.이메일가져오기(token); // 토큰 파싱(분해)해서 이메일 꺼내기

            // 인증정보라는 공간에는 "이 사람 로그인 되었다" 라는 신분증을 생성한 데이터가 담겨져 있다
            UsernamePasswordAuthenticationToken 인증정보 =
                    new UsernamePasswordAuthenticationToken(
                            email,                                           // 팔찌 주인의 이메일
                            null,                                            // 비밀번호(이미 검증했으니 필요없음)
                            List.of(new SimpleGrantedAuthority("ROLE_USER")) // 권한 목록들 중에서 일반 유저라는 목록이 있는가?
                    );
            // Spring 보안팀 경비실에 신분증 제출
            // = 이 요청이 오면 로그인 상태로 처리해줘
            SecurityContextHolder.getContext().setAuthentication(인증정보);
        }
        다음필터.doFilter(요청, 응답); // 바통 넘기기
        // 로그인이 되었든 비로그인이 되었든 검증 할 일은 다 끝냈으니 일 할거 있으면 해~
        // 차단은 SecurityConfig가 담당
    }

    /**
     * 쿠키에서 access_token 값만 꺼내기
     **/
//    private String 쿠키에서AccessToken만꺼낼수있는기능(HttpServletRequest 요청) {
//        Cookie[] 쿠키목록 = 요청.getCookies(); // 요청에 담긴 모든 쿠키 가져오기
//        if (쿠키목록 == null) return null; // 쿠키 자체가 없으면 null 반환
//
//        // 쿠키 목록들을 스트림으로 변환
//        return Arrays.stream(쿠키목록)
//                .filter(c-> "access_token".equals(c.getName())) // access_token 이름인 쿠키만 통과
//                .map(Cookie::getValue) // 쿠키 객체에서 값(토큰 문자열) 만 꺼내기
//                .findFirst() // 첫 번째 결과 가져오기
//                .orElse(null); // 없으면 null 반환
//
//    }
}
