package com.board.springboard.model.service;

import com.board.springboard.model.dto.Board;
import com.board.springboard.model.mapper.BoardMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor // new 자바객체파일() 생략
public class BoardService {
    // 보드 매퍼에 작성된 기능을 활용하겠다.
    // 보드 매퍼 xml에서 가져온 SQL 기능을 보유하고 있는 명칭들의 집합소!
    private final BoardMapper boardMapper;

    @Value("${file.upload.path}")
    private String boardUploadPath; // application.yml -> config.yml에서 가져오는 경로

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
    public void writeBoard(Board board, MultipartFile imageFile, String uploadPath) throws IOException {
        // TODO 1 : 만약 이미지 파일이 있을 경우에만 컬럼 데이터 업로도
        if (imageFile != null & !imageFile.isEmpty()) {
            // TODO 2 : 회사컴퓨터 or 개발자컴퓨터에 저장 폴더 없으면 자동 생성
            File folder = new File(boardUploadPath);
            if (!folder.exists()) folder.mkdirs();
            // TODO 3 : UUID + 원본 확장자로 파일명 생성 (중복파일명 충돌 방지)
            String 원본파일이름 = imageFile.getOriginalFilename();
            String 확장자 = 원본파일이름.substring(원본파일이름.lastIndexOf("."));
            String 저장할파일 = UUID.randomUUID().toString() + 확장자;
            // TODO 4 : 회사컴퓨터 or 개발자컴퓨터에 실제 클라이언트가 전달한 파일 저장
            File 파일저장 = new File(boardUploadPath + "/" + 저장할파일);
            imageFile.transferTo(파일저장);
            // TODO 5 : DB에 저장할 웹 접근 경로를 Board 객체 세팅
            // 실제 회사컴퓨터 or 개발자컴퓨터에 올라가는 접근 경로 uploads/board
            // 웹 접근 경로 : board
            String 웹에서_접근할_경로 = "/board/" + 저장할파일;
            // String 웹에서_접근할_경로 = "/board" + 저장할파일;
            // board파일이름랜덤.png로 board가 파일이름 앞에 붙는 신세가 된다.
            board.setAttach_img(웹에서_접근할_경로);
        }

        // TODO 6 : DB에 게시물 저장 (이미지 없으면 attach_img = null로 저장되며, 수정할 일 없음)
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
