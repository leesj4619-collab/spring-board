package com.board.springboard.common;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import jakarta.annotation.PostConstruct;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.util.Date;

/*
 * JwtUtil
 * JwtFilter JwtProvider를 만든 이유
 * -> AI Blog에서 알려주는 방식 수 만 가지
 * -> 예전부터 ~ 최신 서치를 했을 때 가장 많이 사용 오래된 추천!
 * JwtFilter JwtProvider 해라 -> JwtUtil 합쳐서 가볍게 작성 가능
 */

/**
 *  JWT 관련 기능을 모아놓은 클래스
 *
 *  1. 토큰 만들기  : createAccessToken(), createRefeshToken()
 *  2. 토큰 읽기   : getEmail(), isValid()
 *  3. 요청 필터링 : 내부 클래스 JwtFilter(매 요청마다 토큰 확인)
 *
 *  로그인 할 때 -> JwtUtil이 먼저
 *  로그인 -> 로그인컨트롤러 -> JwtUtil.액세스토큰만들기() -> 쿠키에 토큰 저장 -> 브라우저 응답
 *  토큰을 만드는 단계이므로 Filter는 필요 없다.
 *
 *  API가 요청 할 때 -> JwtFilter가 먼저
 *  브라우저 -> API 요청(쿠키에 토큰 담아서) -> JwtFilter 실행 토큰을 꺼내 검증 -> JwtUtil.유효토큰인지확인() -> 컨트롤러로 전달
 *
 *  JwtUtil   = 도구
 *  JwtFilter = 도구를 사용하는 문서
 */
@Slf4j
@Component
public class JwtUtil {

    // application.yml 값을 가져옴
    // import org.springframework.beans.factory.annotation.Value;
    @Value("${jwt.secret}")
    private String 시크릿키값;

    @Value("${jwt.access-expiry}")
    private long 액세스토큰만료시간; // 30분

    @Value("${jwt.refresh-expiry}")
    private long 리프레시토큰만료기간; // 14일

    private SecretKey 키; // 암호화에 실제로 사용할 키 객체 문자열이 아니라 암호화용 도구 객체사용

    /**
     * 다른 것들이 Spring에서 @어노테이션으로 등록처리가 다 되고나면 나를 실행하거라!
     * 실행 순서를 설정상 모든 것을 끝낸 후 진행하겠다 배치
     * 생성자가 기본 환경설정 세팅이 완료되면 실행되고자 할 때 표기
     */
    @PostConstruct
    public void 초기화() {
        this.키 = Keys.hmacShaKeyFor(시크릿키값.getBytes());
        // application.yml에 작성한 시크릿키값을 암호화 객체로 변환 처리
        // 암호화 처리 끝난 형태를 문자열로 가져와서 숫자 바이트 배열로 사용하겠다.
    }

    // =================================토큰만들기 ===============================

    /**
     * 액세스 토큰 발급 (30분 짜리) 사이트에서 움직임이 있으면 30분 초기화 매번 진행
     * 로그인할 때 호출된다
     **/
    public String 액세스토큰만들기(String email) {
        return 토큰빌드(email, 액세스토큰만료시간);
    }

    /**
     *  리프레시 토큰 발급 (14일 짜리) 14일이 지나면 다시 로그인해서 본인 인증
     *  로그인 후 액세스 토큰이 만료되었을 때 14일 유효기간 재발급용
     **/
    public String 리프레시토큰만들기(String email) {
        return 토큰빌드(email, 리프레시토큰만료기간);
    }

    private String 토큰빌드(String email, long 만료시간ms) {
        Date 지금 = new Date();                                     // 현재시각 만드는 객체 불러오기
        return Jwts.builder()                                      // 로그인하면 토큰(=로그인 인증 팔찌) 만들기 시작
                .subject(email)                                    // 토큰(=로그인 인증 팔지) 안에 이메일 저장
                .issuedAt(지금)                                     // 토큰(=로그인 인증 팔지) 안에 발급 시각
                .expiration(new Date(지금.getTime() + 만료시간ms))    // 토큰(=로그인 인증 팔지) 안에 만료 시각
                .signWith(키)                                       // 토큰(=로그인 인증 팔지) 서명 (위변조 방지)
                .compact();                                        // 모든 정보를 문자열로 압축해서 팔찌 완성하기!
    }

    // 토큰 읽기
    /**
     * 토큰에서 이메일 꺼내기
     * 위에서 만든 토큰(=로그인 인증 팔찌)를 토큰파싱() = 인증팔찌 분해하는 기능을 통해서
     * 이메일만 꺼내오는 기능
     *
     * 멤버십 큐알 코드 -> 그 안에 데이터 -> 우저정보를 확인하고 대화하는 것과 같다.
     */
    public String 이메일가져오기(String token) {
        return 토큰파싱(token).getSubject();
    }

    /**
     * 토큰이 유효한지 확인 (true = 정상 / false = 만료 or 변조)
     */
    public boolean 유효토큰인지확인하는기능(String token) {
        try {
            토큰파싱(token);  // 토큰(=로그인 인증 팔지)를 분해했을 때 서명키가 우리회사에서 발급한게 맞음
            return true;    // 우리 고객님 맞네요~
        }catch (JwtException e){ // 만료되었거나 변조된 토큰
            log.debug("토큰 검증 실패 : {}", e.getMessage());
            return false;              // 저희 고객님... 으로 하기에는 이상이 있네요. 죄송합니다.
        }catch (IllegalArgumentException e) { // 만료되었거나 변조된 토큰
            log.debug("토큰 검증 실패 : {}", e.getMessage());
            return false;               // 저희 고객님... 으로 하기에는 아무것도 없는데요? 죄송합니다.
        }
    }

    /**
     * 위에서만든 토큰 제조기능으로 만들어진 토큰(= 로그인 인증 팔찌) 분해하는 기능
     * Claims = import io.jsonwebtoken.Claims;
     *          자바 개발자가 만들어놓은 분해기능이 작성된 파일을 이용해서 작업
     * @param token 토큰 (=로그인 인증 팔찌)
     * @return 토큰 해석기 이용해서 내용물 꺼내기
     */
    public Claims 토큰파싱(String token) {
        return Jwts.parser()                // JWT파서(해석기) 시작
                .verifyWith(키)              // 이 키로 서명 검증(위변조 확인)
                .build()                    // 분해 완성
                .parseSignedClaims(token)   // 분해한 토큰 문자열(=로그인 인증팔찌 내용물)을 해석
                .getPayload();              // 안에 든 Claims(내용물 꺼내기)

    }

    // JwtFilter를 이쪽에 작성해보기
}
