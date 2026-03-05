package com.board.springboard.model.dto;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Product {
    private Long id; // Integer 보다 숫자범위가 더 넓음 대기업 Long 사용
    private String name;
    private int price;
    private int stock;
    private LocalDateTime created_at;
}
