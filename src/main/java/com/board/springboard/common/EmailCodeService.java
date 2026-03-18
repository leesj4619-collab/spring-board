package com.board.springboard.common;

import lombok.RequiredArgsConstructor;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Map;
import java.util.Random;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 이메일 인증번호 기능
 *
 * 1. 인증번호 만들어서 이메일로 발송
 * 2. 발송한 인증번호를 메모리에 5분 동안 보관
 * 3. 사용자가 입력한 번호와 대조해서 맞으면 삭제 (1회용)
 */
@Service
@RequiredArgsConstructor
public class EmailCodeService {

    private final JavaMailSender 메일발송기;

    // 인증번호 임시 보과함 { 이메일 -> (코드, 만료시각) }
    private final Map<String, 코드정보> 보관함 = new ConcurrentHashMap<>();

    public void 인증번호발송(String 받는이메일) {
        String 코드 = String.format("%06d", new Random().nextInt(999999));

        //잠시 서버 메모리에 저장 (5분 후 만료)
        보관함.put(받는이메일, new 코드정보(코드,LocalDateTime.now().plusMinutes(5)));

        // 이메일 발송
        SimpleMailMessage 메세지 = new SimpleMailMessage();
        메세지.setTo(받는이메일);
        메세지.setSubject("[SpringBoard] 이메일 인증번호 : ");
        메세지.setText("인증번호 : " + 코드 + "\n\n5분 안에 입력해주세요.");
        메일발송기.send(메세지);
    }
    //클라이언트가 인증번호를 작성한게 맞으면 true, 아니면 false
    public boolean 인증번호확인(String 이메일, String 입력코드) {
        코드정보 저장된정보 = 보관함.get(이메일);

        if(저장된정보 == null) return false;
        if(저장된정보.만료시각().isBefore(LocalDateTime.now())) {
            보관함.remove(이메일);
            return false;
        }// 5분이라는 시간이 초과되면 만료됨 처리
        if(!저장된정보.코드().equals(입력코드)) return false; // 번호가 일치하지 않는다면 돌려보내기

        보관함.remove(이메일); // 위 if문에서 결격사유가 없으면 제시간안에 제대로된 인증번호를 입력한게 맞다면 삭제
        return true; // 인증번호 완료된 고객임을 전달
    }

    // 코드와 만료시각을 함께 저장하는 내부 레코드
    private record 코드정보(String 코드, LocalDateTime 만료시각) {}
}

