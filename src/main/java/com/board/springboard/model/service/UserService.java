package com.board.springboard.model.service;

import com.board.springboard.model.dto.User;
import com.board.springboard.model.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserService {
    private final UserMapper userMapper;

    /**
     * 이메일 중복 여부를 확인하는 메서드
     * DB에 동일한 이메일이 존재하면 true, 존재하지 않으면 false 반환
     * @param email 중복 확인할 이메일 주소
     * @return true = 이미 사용중인 이메일 / false = 사용 가능한 이메일
     */
    public boolean 이메일중복체크기능(String email) {
        /*
            int 이메일중복체크(String email); -> 결과는 count에 해당하는 숫자로 나온다.

            하지만 이메일중복인지 아닌지에 대하여 true false로 전달할 것임 설정
            반환값이 int이므로 중복체크기능으로 전달해야하는 데이터 자료형과
            전달하겠다 선언한 자료형이 현재 다른 상황

            이러할 경우에는 개발자가 컨트롤러에 어떻게 데이터를 전달할 것인가?
            기준에 따라 return 옆에 작성한 기능 또는 public 옆에 작성한 자료형 변경

            return userMapper.이메일중복체크(email)
         */

        /*
            만약 이메일 중복체크를 SQL에서 진행했는데, 이메일이 1개이상발견된다면 이메일이 존재하는 것으로 확인

            이메일이 1개 이상 없을 경우 이메일이 없습니다. false의 형태
         */
        return userMapper.이메일중복체크(email) > 0; // 이메일이 존재하면 true 존재합니다.
    }

    /**
     * 회원가입을 처리하는 메서드
     * 이메일 중복 확인 후 중복이 아닐 경우에만 DB에 회원 정보를 저장
     * @param user 가입할 회원 정보가 담긴 객체(name, email)
     * @return true = 회원가입 성공 / false = 이메일 중복으로 인한 가입 실패
     */
    public boolean 회원가입(User user) {
        // 이메일이 중복일 경우 회원가입을 할 수 없도록 회원가입 중단
        // 13번 째 줄에서 개발자가 만들어놓은 이메일 존재 유무 확인하는 기능을 사용해서
        // 만약에 소비자가 작성한 이메일이 존재하는게 사실이라면
        if (이메일중복체크기능(user.getEmail())) {
            return false; // 회원가입을 여기서 중단하겠습니다.
        }
        // 이메일 중복체크기능이 false이고 이메일이 sql에 존재하지 않는게 사실이라면
        // 회원가입을 진행하고
        userMapper.회원가입(user);
        return true; // sql에 저장이 완료되었다면 회원가입 완료를 클라이언트에게 전달하겠다.
    }
        /**
         * 로그인 처리 메서드
         * 이메일로 유저를 조회하여 존재하면 해당 유저 반환, 없으면 null 반환
         * @param email 로그인 시 입력한 이메일
         * @return 조회된 User 객체 / 존재하지 않으면 null
         */
    public User 로그인(String email) {
            return userMapper.로그인(email);
    }

    /**
     * 이메일로 유저를 찾는 메서드
     * 이메일이 존재하면 해당 유저 정보 반환, 없으면 null 반환
     * @param email 찾을 유저의 이메일
     * @return 조회된 User 객체 / 없으면 null
     */
    public User 이메일로유저찾기(String email) {
        return userMapper.이메일로유저찾기(email);
    }

}
