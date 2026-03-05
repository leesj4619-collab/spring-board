package com.board.springboard.model.service;

import com.board.springboard.model.dto.Product;
import com.board.springboard.model.mapper.ProductMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ProductService {

    private final ProductMapper productMapper;

    // TODO 1. 전체 목록 조회 메서드를 완성하시오
    // 조건 : 반환타입 = List<Product> / 매개변수 없음
    public List<Product> 전체제품목록() {
        return productMapper.전체제품목록();
    }

    // TODO 2. 단건 조회 메서드를 완성하시오
    // 조건 : 반환타입 = Product / 매개변수 = int id
    public Product 제품단건(Long id) {
        return productMapper.제품단건(id);
    }

    // TODO 3. 제품 추가 메서드를 완성하시오
    // 조건 : 반환타입 = void / 매개변수 = Product product
    public void 제품추가(Product product) {
        productMapper.제품추가(product);
    }

    // TODO 4. 제품 수정 메서드를 완성하시오
    // 조건 : 반환타입 = void / 매개변수 = Product product
    public void 제품수정(Product product) {
        productMapper.제품수정(product);
    }

    // TODO 5. 제품 삭제 메서드를 완성하시오
    // 조건 : 반환타입 = void / 매개변수 = int id
    public void 제품삭제(Long id) {
        productMapper.제품삭제(id);
    }
}
