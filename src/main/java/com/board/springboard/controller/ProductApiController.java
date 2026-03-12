package com.board.springboard.controller;

import com.board.springboard.model.dto.Product;
import com.board.springboard.model.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/product")
@RequiredArgsConstructor

public class ProductApiController {

    private final ProductService productService;

    // Todo 5 : 제품 수정 처리
    // PUT /product/edit → 수정된 product 객체를 JSON 으로 반환
    // editForm.jsp 의 fetch() 가 PUT 으로 요청 → JSON 응답을 받아 처리
    @PutMapping("/edit")
    public Product 제품수정처리(@RequestBody Product product) {  // 힌트: @RequestBody or @ModelAttribute
        productService.제품수정(product);
        return product;  // 힌트: 수정된 product 객체 반환 → JSON 자동 변환
    }

    // Todo 6 : 제품 삭제 처리
    // DELETE /product/delete?id=1 → "ok" 문자열 반환
    // product_list.jsp 의 fetch() 가 DELETE 로 요청 → "ok" 받으면 화면에서 행 제거
    @DeleteMapping("/delete")
    public String 제품삭제처리(@RequestParam Long id) {  // 힌트: @RequestParam 으로 id 받기
        productService.제품삭제(id);
        return "ok";  // 힌트: 삭제 완료 신호 문자열
    }
}
