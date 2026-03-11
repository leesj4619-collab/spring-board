package com.board.springboard.controller;


import com.board.springboard.model.dto.Board;
import com.board.springboard.model.dto.BoardImage;
import com.board.springboard.model.mapper.BoardImageMapper;
import com.board.springboard.model.mapper.BoardMapper;
import com.board.springboard.model.service.BoardService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
/*
    api에서 endpoint는 ~~~ 됩니다.
    대소문자 / 대문자 -> 집중 주의 할 때 사용
    자바 파일 맨 첫글자만 주로 사용
    변수 상수
    상수 공간은 모두다 대문자 형태로 스네이크 케이스 형태로 사용

    api 주소들의 모음
    @GetMapping
     endpoint = "/"                 도메인이 정의 내리는 마지막 지점
     endpoint = "/board/detail"
     endpoint = "/board/list"
     endpoint = "/board/write"
     endpoint = "/board/edit"
     endpoint = "/board/delete"
    @PostMapping
     endpoint = "/board/write"


    ⭕         @Controller     ⭕ -> 마지막에 view 화면을 보여주는 것

    ❌ 아직 안함 @RestController ❌ -> DB에서 가져온 데이터를 Json 형태로 화면에서 보여주는 것

 */
@Controller // jsp나 html 템플릿과 소비자가 연결해야하는 api 주소 작성
@RequiredArgsConstructor // 이한줄이 생성자 코드를 자동 생성해준다.
public class ViewController {
    private final BoardService boardService;
    private final BoardImageMapper boardImageMapper;
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

    // /board/write
    @GetMapping("/board/write")
    public String writeView(){
        return "board/write";
    }

    /**
     * 게시물 작성 처리 (DB저장)
     * 클라이언트가 write.jsp에서 작성한 제목 / 작성자 /내용 / 첨부 이미지를
     * POST 방식으로 전송하면, 해당 데이터를 받아 DB에 저장한 후
     * 게시물 목록 페이지로 이동
     *
     * @param board 작성된 데이터가 담긴 DTO
     *              write.jsp의 form에서 전송된 게시물 데이터 (title, writer, content)
     *              Spring이 자동으로 Board 객체의 필드에 매핑하여 주입해준다.
     * @param imageFile &lt;input type="file" name="imageFile"&gt;로 전송된 첨부 이미지 파일
     *                  이미지를 춤부하지 않아도 게시물 작성이 가능하도록 required = false로 설정
     *                  이미지가 없을 경우 null 또는 비어있는 상태로 전달
     * @return "redirect:/board/list"
     *          게시물 저장 완료 후 목록 페이지로 리다이렉트 한다
     *          redirect:를 붙이면 서버가 클라이언트에게 해당 주소로 다시 요청하도록 명령한다.
     * @throws Exception 파일 저장 중 IO 오류 등 예외가 발생할 경우를 대비하여 선언한다.
     *          IO Input Output 파일 읽고, 파일 저장 데이터 받기 보내기 입력 출력 조회 저장 의미
     * @RequestParam 클라이언트가 URL 또는 form으로 보낸 데이터를 메서드 매개변수에 꽃아주는 어노테이션 <br>
     * 속성 종류 : <br>
     * Value는 다른 속성이 없으면 기본으로 설정되는 속성이므로 작성하지 않아도 되는 값 <br>
     * JSP input의 name과 연결지을 이름 기본값 매개변수명 <br>
     * required : 필수로 서버나 백엔드에 데이터를 전달해야하는 필수 여부 유무 기본 세팅은 true 되어 있다. <br>
     * defaultValue : 값이 없을 때 기본으로 설정해놓을 값
     * @RequestParam(required = false) 이미지가 없어도 게시물 작성 가능하도록 설정
     * @RequestParam(required = false, value = "imageFile") MultipartFile imageFile)
     * jsp에서 input name="imageFile"인 이미지 파일을 가져와서 백엔드로 넣을 것이지만 필수는 아니다. <br>
     * 굳이 이미지 데이터가 있어야 하는 것은 이니다. <br>
     * required=false를 쓰지 않으면 기본적으로 모든 매개변수 속성은 required=true로 되어있다. <br>
     */
    /*@PostMapping("/board/write")
    public String writeBoard(Board board, @RequestParam(required = false, value = "imageFile") MultipartFile imageFile) throws Exception {
        boardService.writeBoard(board, imageFile);
        return "redirect:/board/list";
    }
    */

    /**
     * 게시물 작성 처리 (다중 이미지 포함)
     * @param board     form에서 전송된 게시물 데이터(title, writer, content)
     * @param imageFiles &lt;input type="file" name="imageFile multiple"&gt;로 전송된 이미지 목록 <br>
     *                   이미지가 없어도 게시물 작성 가능하도록 required=false 작성
     * @return           저장 완료 후 게시물 목록으로 리다이렉트
     * @throws Exception 문제가 발생했을 경우 개발자가 회사의 방침에 따라 예외 상황에 대하여 메뉴얼 따른 대처 코드 제공
     */
    @PostMapping("/board/write")
    public String writeBoard(Board board, @RequestParam(required = false) List<MultipartFile> imageFiles) throws Exception {
        boardService.writeBoard(board, imageFiles);
        return "redirect:/board/list";
    }

    @GetMapping("/board/detail")
    public String boardDetail(@RequestParam("no") int board_no, Model model) {
        // 1. 서비스 호출 (조회수 증가 및 데이터 가져오기)
        Board boardData = boardService.boardDetail(board_no);

        // 2. 모델에 데이터 담기 (JSP에서 사용할 이름: "board")
        model.addAttribute("board", boardData);

        // service에서 컨트롤러로 가져와야한다.
        List<BoardImage> images = boardImageMapper.이미지목록(board_no);
        model.addAttribute("images", images);
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
    @PutMapping("/board/edit")
    @ResponseBody
        public Board editBoard(Board board) {
        boardService.updateBoard(board);
        return board;
        // return "redirect://board/detail?no=" + board.getBoard_no();
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