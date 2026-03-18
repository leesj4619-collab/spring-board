package com.board.springboard.model.service;

import com.board.springboard.common.EmailCodeService;
import com.board.springboard.common.JwtUtil;
import com.board.springboard.model.dto.User;
import com.board.springboard.model.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

@Service
@RequiredArgsConstructor
public class UserService {
    private final UserMapper userMapper;
    private final PasswordEncoder passwordEncoder; // 비밀번호 BCrypt 검증
    private final JwtUtil jwtUtil;                  // 토큰 발급
    private final EmailCodeService emailCodeService; // 인증번호 발송
    private final Map<String, String> 리프레시토큰보관함 = new ConcurrentHashMap<>(); // 리프레시 토큰 메모리 저장 30분 or 14일 정도 토큰

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
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        userMapper.회원가입(user);
        return true; // sql에 저장이 완료되었다면 회원가입 완료를 클라이언트에게 전달하겠다.
    }
        /**
         * 로그인 처리 메서드
         * 이메일로 유저를 조회하여 존재하면 해당 유저 반환, 없으면 null 반환
         * @param email 로그인 시 입력한 이메일
         * @return 조회된 User 객체 / 존재하지 않으면 null
         */
    public Map<String, String> 로그인(String email, String 입력비밀번호) {
            //return userMapper.로그인(email);
            User user = userMapper.로그인(email); //db에서 해당 유조의 이메일이 존재하는지 확인한다.
            // 유저 정보가 없거나 유저가 입력한 비밀번호 암호화한 것과 db에 저장된 암호화비밀번호가 같지 않다면 null 반환
            // 스프링에서 만든 비밀번호 맞는지 확인하는 보안 코드 로직에 의해 아래와 같이 기입해주면 확인처리 해줄 것
            // .matches(웹사이트에서 유저가 입력한 비밀번호를 암호화 처리, DB에 저장된 암호화 비밀번호)
            //                                          클라이언트     DB에 저장된 비밀번호
            if(user == null || !passwordEncoder.matches(입력비밀번호, user.getPassword())) return null;
            // 위 만약에서 걸리지 않으면 본인인증이 확인된 유저의 토큰 생성
            String 액세스토큰 = jwtUtil.액세스토큰만들기(email); // 30분 유효
            String 리프레시토큰 = jwtUtil.리프레시토큰만들기(email); // 14일 유효 토큰 둘 중 하나 사용해도 되며,
            // 개발자는 액세스토큰으로 웹사이트를 운영할 것인지 리프레시토큰으로 운영할 것인지 판단 후 둘 중 하나 사용할 것
            // 크롬 = 리프레시 토큰 네이버 다음 = 액세스 토큰 형태 유효기간은 개발자와 회사에서 지정한 규정대로 설정한다.
            리프레시토큰보관함.put(email, 리프레시토큰);
            return Map.of("accessToken", 액세스토큰, "refreshToken",리프레시토큰);
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

    /**
     * 프로필사진 업로드 및 DB 저장 <br/>
     *
     * 처리 순서 : <br/>
     * 1. 업로드된 파일이 비어있는지 확인 <br/>
     * 2. 저장 폴더가 없으면 자동으로 생성(서버 재시작 재부팅 시 안전하게 이미지를 가져올 수 있다.) <br/>
     * 3. 파일명 충돌 방지를 위해 UUID + 원본 확장자로 파일명 생성 <br/>
     * 4. 서버 디스크에 파일 저장 <br/>
     * 5. DB의 profile_img 컬럼에 웹 접근 경로 저장 <br/>
     * 6. 세션 갱신을 위해 수정된 최신 User 데이터 객체 반환 <br/>
     *
     * @param loginUser 현재 로그인 되오있는 세션에서 꺼낸 현재 로그인 유저의 정보가 담겨있는 변수공간의 명칭
     * @param imageFile <input type= "file">로 전달된 MultipartFile
     * @param uploadPath 파일을 저장할 서버 절대경로(application.properties에서 설정하고, 설정된 키이름 경로 가져올 것)
     * @return 프로필 사진 경로가 반영된 최신 유저 정보를 다시 웹사이트로 반환
     * @throws java.io.IOException 파일 저장에 실패 할 경우를 대비
     */
    public  User 프로필사진업로드(User loginUser, MultipartFile imageFile, String uploadPath) throws IOException {

        // 1. 파일이 비어있으면 업로드 처리 없이 현재 유저 그대로 반환
        if(imageFile == null || imageFile.isEmpty()) return loginUser; // if() {} 중괄호 냅 코드가 1줄일 경우 {} 생략 가능

        //2. 프로필을 저장하는 경로에 폴더들이 존재하지 않을 경우
        File 폴더 = new File(uploadPath);
        if(!폴더.exists()) 폴더.mkdirs();
        // !폴더 = 폴더가 존재하지 않는게 사실이라면 = true 라면
        // .mkdirs() 전체경로에서 존재하지 않는 폴더들 모~두 생성
        // .mkdir() 마지막에 해당하는 폴더만 생성 / 마지막까지 도달하는데 존재하지 않는 폴더가 있을 경우 에러가 발생하여
        // 폴더 생성을 중단하기 때문에 보통 폴더를 생성할 때 mkdirs()를 사용

        //3. 파일명 : 충돌 방지 : UUID + 원본 확장자
        //   원본파일명 : profile.jsp -> 저장파일명 : 랜덤문자와 숫자들.jsp
        String 원본파일이름 = imageFile.getOriginalFilename(); // 예 : my_photo.png
        String 확장자      = 원본파일이름.substring(원본파일이름.lastIndexOf(".")); // .png 데이터만 확장자 공간에 담겨지게 된다.
        String 저장할파일   = UUID.randomUUID().toString() + 확장자;    // 랜덤으로 만들어진_파일이름.png

        //4. 서버 디스크에 파일을 저장
        File 파일저장 = new File(uploadPath + "/" + 저장할파일);
        imageFile.transferTo(파일저장);

        //5. DB에 저장할 웹 접근 경로 설정
        String 웹경로 = "/uploads/profile/" + 저장할파일;

        //6. DB 업데이트 : 해당 유저의 profile_img 컬럼에 웹 경로 저장
        User db저장할유저정보 = new User();
        db저장할유저정보.setId(loginUser.getId());
        db저장할유저정보.setProfile_img(웹경로);
        userMapper.프로필사진수정(db저장할유저정보);

        return userMapper.유저단건조회(loginUser.getId());
    }

    public User 유저단건조회(int id) {
        return userMapper.유저단건조회(id);
    }

    public void 유저정보수정(User user) {
        userMapper.유저정보수정(user);
    }


}
