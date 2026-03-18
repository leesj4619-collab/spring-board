package com.board.springboard.common;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Component;

import java.util.Arrays;

/**
 * 쿠키 관련 기능 모음집
 *
 * 쿠키 추가 삭제 꺼내기
 * 어느 컨트롤러에서든 주입받아 사용 가능
 */
@Component
public class CookieUtil {
    /** 쿠키 추가(HttpOnly = JS 접근 불가, 보안상 안전 */
    public void 추가(HttpServletResponse res, String 이름, String 값, int 유지시간초){
        Cookie cookie = new Cookie(이름, 값);
        cookie.setHttpOnly(true); // JS에서 접근 불가 (XSS 공격 방어)
        cookie.setPath("/");  // 모든 경로에서 서버에서 전달해준 쿠키를 사용 가능
        cookie.setMaxAge(유지시간초);
        res.addCookie(cookie);
    }
    /** 쿠키 삭제 (유지시간을 0으로 설정하면 브라우저가 즉시 삭제) */
    public void 삭제(HttpServletResponse res, String 이름){
        Cookie cookie = new Cookie(이름, "");
        cookie.setMaxAge(0); // 쿠키가 존재할 수 있는 시간 없애기
        cookie.setPath("/");  // 어디서든 로그아웃 14일 30분이 지난 쿠키 데이터 삭제 가능하게 ok
        res.addCookie(cookie);
    }
    /** 요청 쿠키에서 특정 이름의 꺼내기 (없으면 null 반환) JwtUtil에 작성한 가져오기 가져와서 정리 */
    public String 가져오기(HttpServletRequest req, String 이름){
      Cookie[] 쿠키목록 = req.getCookies(); // 요청에 담긴 모든 쿠키 가져오기
       if (쿠키목록 == null) return null; // 쿠키 자체가 없으면 null 반환

       // 쿠키 목록들을 스트림으로 변환
       return Arrays.stream(쿠키목록)
               //.filter(c-> "access_token".equals(c.getName())) // access_token 이름인 쿠키만 통과
               .filter(c-> 이름.equals(c.getName()))
               // 구글처럼 토큰이 많을 경우 토큰 내부에 개발자가 상황에 따라 원하는 키의 값을 가져올 수 있도록 설정
               // 회사에서 상황에 따라 access_token 뿐만 아니라 매개변수로 전달받는 모든 쿠키 내 존재하는 키이름
               // 데이터를 확인하고 사용할 수 있는 재사용 가능한 기능으로 교체
                .map(Cookie::getValue) // 쿠키 객체에서 값(토큰 문자열) 만 꺼내기
               .findFirst() // 첫 번째 결과 가져오기
              .orElse(null); // 없으면 null 반환
    }
}
