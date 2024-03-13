package com.project3.yogiaudio.controller.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project3.yogiaudio.dto.common.Criteria;
import com.project3.yogiaudio.dto.common.PageVO;
import com.project3.yogiaudio.dto.music.PurchaseDTO;
import com.project3.yogiaudio.filedb.service.FiledbService;
import com.project3.yogiaudio.service.PurchaseService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/purchase")
public class PurchaseController {

	@Autowired
	private PurchaseService purchaseService;
	@Autowired
	private FiledbService filedbService;
	
	
	// http://localhost:80/purchase/main
	
	@GetMapping("/main")
	public String purchaseMainPageGET(Model model,Criteria cri) throws Exception {
		
		
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(purchaseService.countPurchaseList());
		
		
		model.addAttribute("pageVO", pageVO);
		
		
		List<PurchaseDTO> result = purchaseService.purchaseListAll(cri);
		model.addAttribute("purchaselist", result);
		
		System.out.println(result);
		
		
		log.debug("이용권구매페이지출력!");
		
		return "product/purchase";
	}
	
	
	
	
	
	
	
	
}
