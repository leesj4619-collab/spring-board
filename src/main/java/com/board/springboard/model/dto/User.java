package com.board.springboard.model.dto;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class User {
    /*
    파일 만드는 순서
    1. dto                  SQL 컬럼 연결고리 세팅
    2. mapper.java          SQL을 가져올 기능 명칭 자료형 매개변수 설정
    3. mapper.xml           mapper.java에서 설정한 기능 참고해서 SQL 작성
    4. service.java         회사에서 요구하는 기능을 바탕으로 서비스 로직 작성
                            필요한 경우 SQL과 연결된 mapper 활용하여 서비스 로직 작성
    5. controller.java      어떤 api/endpoint 주소에서 어떤 jsp or html 템플릿을 보여줄 것인지 설정
                            주소에서 템플릿을 보여줄 때 가져갈 데이터나 특정 설정이 있다면
                            서비스에서 기능을 가져와 로직 세팅
    6. jsp 파일              유저에게 보여줄 화면 세팅
     */
    private Integer id;
    private String name;
    private String email;
    private String password; // 비밀번호 컬럼 추가
    private LocalDateTime created_at;
    private String profileImg; // 프로필 사진 파일 경로 -> profileImg

    // 실무에서는 SQL 무조건 _로 구분짓는다.
    // html css js -> className _로 구분짓거나 -으로 구분짓는 방법 많이 사용
    // 자바에서는 카멜케이스 형태로 구분짓는 경우가 많다.
    // 다른 명칭들은 본인들의 단어가 어떤 의미인지 표기만 하면된다.
    // 자바의 경우 Mapper Service Controller처럼 부가적인 수식어가 붙는 경우가 많기 떄문에
    // 카멜케이스 형태로 작성
    // 변수 명명 규칙 / 파일 명명 규칙의 경우 누구나 알 수 있는 명칭으로 작성
    // 길게 작성 OK
}
