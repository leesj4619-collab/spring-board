package com.board.springboard.controller;


import com.board.springboard.model.dto.Board;
import com.board.springboard.model.service.BoardService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller // jsp나 html 템플릿과 소비자가 연결해야하는 api 주소 작성
@RequiredArgsConstructor // 이한줄이 생성자 코드를 자동 생성해준다.
public class ViewController {
    private final BoardService boardService;
    /*
    아래 생성자 매개변수 코드를 @RequiredArgsConstructor 어노테이션으로
    대체하여 사용할 수 있다.
    생성자 직접 작성방법
                        서비스를 매개변수로 받아서
    public ViewController(BoardService boardService) {
        this.boardService = boardService; -> 클래스 필드에 직접 대입해서 사용하겠다.
    }
     */
    /**
     * 메인 페이지로 이동
     * @return index.jsp로 전달
     */
    @GetMapping("/")
    public String indexView(){
        return "index";
    }

    /**
     * 게시물 목록 조회 및 페이지 이동
     * @param model 게시물 리스트 데이터를 전달하기 위한 객체
     * @return board/list 전달
     */
    // /board/list
    @GetMapping("/board/list")
    public String listView(Model model){
        List<Board> boardListData = boardService.findAllBoard();
        model.addAttribute("boardLists",boardListData);
        /*
        Model model 모듈 사용해서 SQL에서 가져온 전체 게시물을 board/list 전달
        list.jsp에 전달할 변수이름 : boardLists
        service에서 데이터를 담아올 변수이름 : boardListData
         */
        return "board/list";
    }

    // /board/writer
    @GetMapping("/board/write")
    public String writeView(){
        return "board/write";
    }

    /**
     * 게시물 작성 처리 (DB저장)
     * @return 다이렉트로 list로 이동
     */
    @PostMapping("/board/write")
    public String writeBoard(Board board) {
        boardService.writeBoard(board);
        return "redirect:/board/list";
    }

    @GetMapping("/board/detail")
    public String boardDetail(@RequestParam("no") int board_no, Model model) {
        // 1. 서비스 호출 (조회수 증가 및 데이터 가져오기)
        Board boardData = boardService.boardDetail(board_no);

        // 2. 모델에 데이터 담기 (JSP에서 사용할 이름: "board")
        model.addAttribute("board", boardData);

        return "board/detail";
    }

    /**
     * 게시물 수정 이동 (기존 데이터 조회 포함)
     * @param board_no 수정해야하는 게시물 번호
     * @param model    기존 데이터를 전달하기 위한 객체
     * @return         board 폴더 안에 존재하는 edit 파일로 이동
     */
    @GetMapping("/board/edit")
    public String editView(@RequestParam("no") int board_no, Model model) {

        // 힌트: 상세보기와 동일하게 단일 게시물 조회 메서드를 사용합니다.
        Board board = boardService.boardDetail(board_no);

        model.addAttribute("board", board);

        return "board/edit";
    }

    /**
     * 게시물 삭제 처리
     * @param board_no : JSP에서 'no'라는 이름으로 보낸 게시물 번호
     * @return : 삭제 후 게시물 목록 페이지로 이동
     *
     * redirect : 서버가 웹 사이트에게 다른 주소로 다시 가라고 명령하는 것,
     * 사용자가 보낸 요청을 서버가 처리하고 나서, 현재 페이지에 머무는 것이 아니라
     * 새로운 페이지를 처음부터 다시 호출하게 만들 때 사용
     * -> 저장하고, 삭제할 일 다했으니 지금 페이지에 있지마시고 000 페이지로 이동하세요.
     */
    @GetMapping("/board/delete")
    public String deleteBoard(@RequestParam("no") int board_no) {

        boardService.deleteBoard(board_no);

        return "redirect:/board/list";
    }


}
