package com.board.springboard.controller;

import com.board.springboard.model.dto.User;
import com.board.springboard.model.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequiredArgsConstructor
public class UserViewController {

    private final UserService userService;

    @Value("${file.upload.path}")
    private String uploadPath;

    // Todo 1 : 회원가입 페이지 반환
    // GET /user/register → "user/register" JSP 반환
    @GetMapping("/user/register")
    public String registerView() {
        return "user/register";
    }

    // Todo 2 : 회원가입 처리
    // POST /user/register → 성공 시 로그인 페이지 / 실패 시 회원가입 페이지로 redirect
    @PostMapping("/user/register")
    public String register(User user) {
        boolean result = userService.회원가입(user);
        if (result) { // result 자체에 데이터가 들어 있다면 true
            return "redirect:/user/login";
        } else { // !result 라면! result 자체데이터가 없다면 false
            return "redirect:/user/register";  // 힌트: 실패 시 회원가입 페이지로 돌려보내기
        }
    }

    // Todo 3 : 로그인 페이지 반환
    @GetMapping("/user/login")
    public String loginView() {
        return "user/login";
    }

    // Todo 4 : 로그인 처리
    // 성공 시 메인페이지 redirect / 실패 시 로그인 페이지 redirect
    @PostMapping("/user/login")
    public String login(@RequestParam String email, HttpSession session) {
        User 로그인한유저데이터 = userService.로그인(email);  // 힌트: email 로 조회
        if (로그인한유저데이터 != null) {
            session.setAttribute("loginUser", 로그인한유저데이터);  // 힌트: "loginUser" 라는 이름으로 세션에 저장
            return "redirect:/";
        } else {
            return "redirect:/login";  // 힌트: 실패 파라미터 붙여서 로그인 페이지로
        }
    }

    // Todo 5 : 로그아웃 처리
    @GetMapping("/user/logout")
    public String 로그아웃(HttpSession session) {
        session.invalidate();  // 힌트: 세션 전체를 초기화하는 메서드 호출
        return "redirect:/";
    }

    // Todo 6 : 이메일 찾기 페이지 반환
    @GetMapping("/user/find-email")
    public String findEmailView() {
        return "user/findUser";
    }

    // Todo 7 : 프로필 페이지 반환
    @GetMapping("/user/profile")
    public String profileView(HttpSession session, Model model) {
        User 임시보관된_유저정보 = (User) session.getAttribute("loginUser");  // 힌트: "loginUser"
        if (임시보관된_유저정보 == null) return "redirect:/user/login";  // 힌트: 로그인 안 했으면 로그인 페이지로
        User 최신유저정보 = userService.유저단건조회(임시보관된_유저정보.getId());
        model.addAttribute("user", 최신유저정보);  // 힌트: JSP 에서 user 라는 이름으로 사용 중
        return "/user/profile";
    }

    // Todo 8 : 프로필 사진 업로드 처리
    @PostMapping("/user/profile/upload")
    public String 프로필사진업로드하기(@RequestParam("imageFile") MultipartFile imageFile,
                             HttpSession session, RedirectAttributes redirectAttributes) {
        User 로그인된_유저정보 = (User) session.getAttribute("loginUser");
        if (로그인된_유저정보 == null) return "redirect:/user/login";
        try {
            User updateUser = userService.프로필사진업로드(로그인된_유저정보, imageFile, uploadPath);
            session.setAttribute("loginUser", updateUser);
            redirectAttributes.addFlashAttribute("msg", "성공");  // 힌트: 성공 메세지 작성
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "실패");  // 힌트: 실패 메세지 작성
        }
        return "redirect:/user/profile";
    }
}
