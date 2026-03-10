package com.board.springboard.model.mapper;

import com.board.springboard.model.dto.Board;
import com.board.springboard.model.dto.BoardImage;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BoardImageMapper {

    /**
     * 이미지 한장 저장
     * @param boardImage
     */
    void 이미지저장(BoardImage boardImage);

    /**
     * 특정 게시물의 모든 이미지 전체 조회
     * @param board_no
     * @return
     */
    List<BoardImage> 이미지목록(int board_no);

    /**
     * 특정 게시물의 이미지 전체 삭제 (게시물 삭제할 경우 이미지도 같이 삭제)
     * @param board_no
     */
    void 이미지전체삭제(int board_no);
}
