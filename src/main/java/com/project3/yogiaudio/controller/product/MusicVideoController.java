package com.project3.yogiaudio.controller.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project3.yogiaudio.dto.common.Criteria;
import com.project3.yogiaudio.dto.common.PageVO;
import com.project3.yogiaudio.dto.music.MusicDTO;
import com.project3.yogiaudio.dto.music.MusicVideoDTO;
import com.project3.yogiaudio.filedb.service.FiledbService;
import com.project3.yogiaudio.service.MusicVideoService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/mv")
public class MusicVideoController {
	
	@Autowired
	private MusicVideoService musicVideoService;
	@Autowired
	private FiledbService filedbService;
	
	
	
	// http://localhost:80/mv/mvlist
	//뮤직비디오 페이지 GET
	@GetMapping("/mvlist")
	public String MusicVideoGET(Model model, Criteria cri, MusicVideoDTO dto) throws Exception {
		
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(musicVideoService.mvlistCount());
		
		model.addAttribute("pageVO", pageVO);
		
		//전체
		List<MusicVideoDTO> result = musicVideoService.mvlistAll(cri);
		
		model.addAttribute("mvlist", result);
		
		
		
		log.debug("뮤직비디오페이지출력");
		return "product/musicvideo";
	}
	
	
	
	//뮤직비디오 조건 페이지 GET
	@GetMapping("/mvlist-option")
	public String MusicVideoOptionGET(HttpServletRequest request, Criteria cri, Model model) throws Exception {
		
		String searchOption = request.getParameter("searchOption");
		
		if (searchOption != null && !searchOption.isEmpty()) {
			cri.setSearchOption(searchOption);
		}
		
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(musicVideoService.optionMVlistCount(cri));
		
		model.addAttribute("pageVO", pageVO);

		
		List<MusicVideoDTO> result = musicVideoService.optionMVlist(cri);
		
		model.addAttribute("mvoptionlist", result);
		
		log.debug("admin-user관리 페이지 출력!");
		return "product/mvoption";
		
			
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
