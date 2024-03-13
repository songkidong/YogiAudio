package com.project3.yogiaudio.controller.product;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/purchase")
public class PurchaseController {

	
	// http://localhost:80/purchase/main
	
	@GetMapping("/main")
	public String purchaseMainPageGET() {
		log.debug("이용권구매페이지출력");
		return "product/purchase";
	}
	
	
	
	
	
}
