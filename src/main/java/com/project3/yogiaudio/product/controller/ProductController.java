package com.project3.yogiaudio.product.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project3.yogiaudio.product.dto.Criteria;
import com.project3.yogiaudio.product.dto.MusicDTO;
import com.project3.yogiaudio.product.dto.PageVO;
import com.project3.yogiaudio.service.MusicService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/product")
public class ProductController {
	
	@Autowired
	private MusicService musicService;
	
	
	
	// http://localhost:80/product/main
	//메인페이지 호출하기
	@GetMapping("/main")
	public String productMainGET() {
		log.debug("메인페이지호출테스트");
		return"product/main";
	}
	
	
	// http://localhost:80/product/domestic-music
	@GetMapping("/domestic-music")
	public String productDomesticGET(Model model, Criteria cri,MusicDTO dto) throws Exception {
		
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(musicService.countdomesticListAll());		
		
		model.addAttribute("pageVO", pageVO);
		
		List<MusicDTO> result = musicService.domesticListAll(cri);
		
		model.addAttribute("domesticlist", result);
		
		log.debug("국내음악페이지출력");
		return "product/domestic";
		
	}
	
	
	
	
	
}
