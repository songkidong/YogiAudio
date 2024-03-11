package com.project3.yogiaudio.controller.cs;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project3.yogiaudio.dto.MusicDTO;
import com.project3.yogiaudio.dto.common.Criteria;
import com.project3.yogiaudio.dto.common.PageVO;
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
	//국내음악리스트 호출하기
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
	
	//국외음악리스트 호출하기
	@GetMapping("/aboard-music")
	public String productAboardGET(Model model, Criteria cri, MusicDTO dto) throws Exception {
		
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(musicService.countaboardListAll());
		
		model.addAttribute("pageVO", pageVO);
		
		List<MusicDTO> result = musicService.aboardListAll(cri);
		
		model.addAttribute("aboardlist", result);
		
		
		log.debug("국외음악페이지출력");
		return "product/aboard";
	}
	
	
	//국내음악상세페이지
	// http://localhost:80/product/domestic-detail?musicno=&musicmajor=
	@GetMapping("/domestic-detail")
	public String domesticDetailGET(@RequestParam(value = "musicno") int musicno, @RequestParam(value = "musicmajor") String musicmajor,Model model) {
	    System.out.println("musicno: " + musicno); 
	    System.out.println("musicmajor: " + musicmajor);
		return"product/domesticdetail";
	}
	
	
	
	
	
	//국외음악상세페이지
	// http://localhost:80/product/aboard-detail?musicno=&musicmajor=
	@GetMapping("/aboard-detail")
	public String aboardDetailGET(@RequestParam(value = "musicno") int musicno, @RequestParam(value = "musicmajor") String musicmajor,Model model) {
		 System.out.println("musicno: " + musicno); 
		 System.out.println("musicmajor: " + musicmajor);
		return"product/aboarddetail";
	}
	
	
	
	
	
}
