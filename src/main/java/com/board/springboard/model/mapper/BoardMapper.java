package com.board.springboard.model.mapper;

import com.board.springboard.model.dto.Board;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BoardMapper {
    // 전체 게시물 조회
    /*
    @return
    <select id="전체게시물" resultType="com.board.springboard.model.dto.Board">
        <!-- SQL을 작성하시오 -->
        SELECT * FROM board WHERE board_no ORDER BY DESC;
    </select>
     */
    List<Board> 전체게시물();

    // 게시물 하나 조회
    /*
    @return
    <select id="단일게시물" resultType="com.board.springboard.model.dto.Board">
        <!-- SQL을 작성하시오 -->
        SELECT * FROM board WHERE board_no = #{board_no}
    </select>
     */
    Board 단일게시물(int board_no);

    // 게시물 추가
    /*
    <insert id="게시물추가" parameterType="com.board.springboard.model.dto.Board">
        <!-- SQL을 작성하시오 -->
        INSERT INTO board (title, content, writer, created_at, view_count)
        VALUES (#{title}, #{content}, #{writer}, NOW(), 0)
    </insert>
     */
    void 게시물추가(Board board);

    // 게시물 수정
    /*
    <update id="게시물수정" parameterType="com.board.springboard.model.dto.Board">
        <!-- SQL을 작성하시오 -->
        UPDATE board SET title = #{titel}, content = #{content}
        WHERE board_no = #{board_no}
    </update>
     */
    void 게시물수정(Board board);

    // 게시물 삭제
    /*
    <delete id="게시물삭제" parameterType="int">
        <!-- SQL을 작성하시오 -->
        DELETE FROM board WHERE board_no = #{board_no}
    </delete>
     */
    void 게시물삭제(int board_no);

    // 조회수 수정
    /*
    <update id="조회수수정" parameterType="int">
        <!-- SQL을 작성하시오 -->
        UPDATE board SET view_count = view_count + 1
        WHERE board_no = #{board_no}
    </update>
     */
    void 조회수수정(int board_no);

}
