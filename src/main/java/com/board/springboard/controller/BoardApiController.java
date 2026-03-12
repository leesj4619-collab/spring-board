package com.board.springboard.controller;

import com.board.springboard.model.dto.Board;
import com.board.springboard.model.service.BoardService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController // @Controller + @ResponseBody
@RequiredArgsConstructor
public class BoardApiController {
    private final BoardService boardService;

    @PostMapping ("/board/write")
    public Board writeBoard(Board board, @RequestParam(required = false)List<MultipartFile> imageFiles) throws Exception {
        boardService.writeBoard(board, imageFiles);
        //return "redirect:/board/list"; // jsp로 이동이 아닌 화면에 redirect:/board/list 글자만 찍힘
        //return "ok"; // ok 글자가 화면으로 전달
        return board; // board 데이터가 화면으로 전달되거나 보통 성공 실패에 결과를 전달 ResponseEntity라는 개념.. 어려움
    }

    @PutMapping("/board/edit")
    public Board editBoard(@RequestParam Board board) {
        boardService.updateBoard(board);
        return board;
    }
}
