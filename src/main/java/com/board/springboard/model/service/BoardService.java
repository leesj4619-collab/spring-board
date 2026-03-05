package com.board.springboard.model.service;

import com.board.springboard.model.dto.Board;
import com.board.springboard.model.mapper.BoardMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor // new 자바객체파일() 생략
public class BoardService {
    // 보드 매퍼에 작성된 기능을 활용하겠다.
    // 보드 매퍼 xml에서 가져온 SQL 기능을 보유하고 있는 명칭들의 집합소!
    private final BoardMapper boardMapper;

    // 전체게시물 조회
    public List<Board> findAllBoard(){
        return boardMapper.전체게시물();
    }

    // 단일게시물 조회
    public Board boardDetail(int board_no){
        boardMapper.조회수수정(board_no);
        return boardMapper.단일게시물(board_no);
    }

    // 게시물 추가 됐는지 유무만 확인
    public void writeBoard(Board board) {
        boardMapper.게시물추가(board);
    }

    // 게시물 수정 유무 나중에 확인
    public void updateBoard(Board board){
        boardMapper.게시물수정(board);
    }

    // 게시물 삭제 유무 나중에 확인
    public void deleteBoard(int board_no){
        boardMapper.게시물삭제(board_no);
    }
}
