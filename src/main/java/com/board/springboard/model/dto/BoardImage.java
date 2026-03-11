package com.board.springboard.model.dto;

/*
import = pom.xml이나 build.gradel 또는 자바 라이브러리에 저장되어 있는 기능을 가져와서 사용한다.
lombok = 특정 부서나 회사에서 만든 모듈
       = 모두다 현재 자바 class 파일에서 사용하겠다.
       = all
import           lombok              .*              ;
가져와서 사용하겠다. 롬복이라는 회사에서 만든 모든기능을 마침표
*/
// lombok에서 만들어진 기능을 가져와서 사용하는 어노테이션들 @= 어노테이션
import lombok.*;
import java.time.LocalDateTime;


@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class BoardImage {
    private Integer id;                 // PK
    private Integer board_no;           // board 테이블 FK 외래키 다른 기본키와 테이블 연결을 위한 키
    private String img_path;            // 웹 접근 경로
    private LocalDateTime created_at;   // 생성 일자
}
