package com.project3.yogiaudio.product.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/product")
public class ProductController {
	
	// http://localhost:80/product/main
	//메인페이지 호출하기
	@GetMapping("/main")
	public String productMainGET() {
		log.debug("메인페이지호출테스트");
		return"product/main";
	}
	
	
	
	
	
}
