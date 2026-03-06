package com.board.springboard.controller;

import com.board.springboard.model.dto.User;
import com.board.springboard.model.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    /**
     * 회원가입 페이지 이동
     * @return user/register.jsp
     */
    @GetMapping("/user/register")
    public String registerView() {
        return "user/register";
    }

    /**
     * 회원가입 처리 (DB 저장)
     * 성공 시 로그인 페이지로 이동
     * 실패(이메일 중복) 시 회원가입 페이지로 이동
     * @param user 작성된 회원 데이터
     * @return 성공 → 로그인 페이지 / 실패 → 회원가입 페이지
     */
    @PostMapping("/user/register")
    public String register(User user) {
        /*
           UserService의 회원가입 기능을 실행한다.
           클라이언트가 입력한 회원 정보(user)를 전달하며,
           회원가입 처리 결과(성공 = true, 실패 = false)를
           result에 담아 결과에 따라 클라이언트를 다른 페이지로 안내한다.
         */
        boolean result = userService.회원가입(user);
        if (result)  {
            return "redirect:/user/login?success=join";
        } else {
            return "redirect:/user/register?error=email";
        }
    }

    /**
     * 로그인 페이지 이동
     * @return user/login.jsp
     */
    @GetMapping("/user/login")
    public String loginView() {
        return "user/login";
    }

    @PostMapping("/user/login")
    public String login(@RequestParam String email, HttpSession session) {
        /*
            email로 userService.로그인 기능을 작동한 결과는 User 객체 타입으로 데이터가 존재하며,
            SQL결과를 로그인한 유저 데이터라는 변수 명칭의 공간에 잠시 담아둘 것
            로그인기능이 User라는 타입으로 전달할 예정리기 때문에 로그인한 유저데이터 라는 공간 또한
            User형태로 생성하여 메모리에 존재하도록 설정
         */
        User 로그인한유저데이터 = userService.로그인(email);

        if(로그인한유저데이터 != null) {
            session.setAttribute("loginUser", 로그인한유저데이터);
            return "redirect:/";
        }else {
            return "redirect:/user/login?error=fail";
        }
    }

    @GetMapping("/user/logout")
    public String 로그아웃(HttpSession session) {
        session.invalidate(); //세셴 초기화
        return "redirect:/";
    }
    @GetMapping("/user/find-email")
    public String findEmailView(){
        return "user/findUser";
    }

    @PostMapping("/user/find-email")
    public String findEmail(@RequestParam String name, Model model) {
        User 유저데이터 = userService.이메일로유저찾기(name);

        if(유저데이터 != null) {
            model.addAttribute("email", 유저데이터.getEmail());
        }else {
            model.addAttribute("error", "해당 이름으로 가입된 이메일이 없습니다.");
        }
        return "user/findUser";
    }

    /*
    // 미완성된 기능
        접근제어자 반환타입 기능명칭(매개변수자리);

    // 완성된 기능 {}내부에 기능이 작성되지 않더라도 {} 존재 자체만으로 완성된 기능
        접근제어자 반환타입 기능명칭(매개변수자리){기능자리}
     */
    // TODO 4: 빈칸을 채우세요
    @GetMapping("/user/profile")
    public String profileView(HttpSession session, Model model) {
        // 무조건 모든 언어에서는
        // set으로 시작하면 저장하다 의미              (개발자 적 관례)
        // get으로 시작하면 저장된 데이터를 가져온다 의미 (개발자 적 관례)
        User loginUser = (User) session.getAttribute("loginUser");

        // 로그인한 유저의 정보가 없는데.. 악의적으로 URL을 접속해서 유저정보를 조회하려 할 경우
        if (loginUser == null) {
            return "redirect:/user/login";
        }

        User freshUser = userService.유저단건조회(loginUser.getId());
        model.addAttribute("user", freshUser); // 일시적으로 넘겨주는 데이터가 아닌 지속적으로 유지하는 데이터
        // 새로고침을 하더라도 user 키이름 내부에 존재하는 데이터 보존

        return "redirect:/user/profile";
    }


}