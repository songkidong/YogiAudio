package com.project3.yogiaudio.controller.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project3.yogiaudio.dto.board.BoardFreeReportDTO;
import com.project3.yogiaudio.repository.entity.User;
import com.project3.yogiaudio.service.board.FreeCommentService;
import com.project3.yogiaudio.service.board.FreeReportService;
import com.project3.yogiaudio.service.board.FreeService;
import com.project3.yogiaudio.util.Define;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/board/free")
public class FreeReportController {

	@Autowired
	private HttpSession session;
	
	@Autowired
	private FreeReportService freeReportService;

	/**
	  * @Method Name : insertBoardFreeReport
	  * @작성일 : 2024. 3. 25.
	  * @작성자 : 노수현
	  * @변경이력 : 
	  * @Method 설명 : 게시판 신고하기
	  */
	@PostMapping("/boardFreeReport")
	@ResponseBody
	public int insertBoardFreeReport(BoardFreeReportDTO boardFreeReportDTO) {
		System.out.println("넘어옴??"+boardFreeReportDTO);
		
		User principal = (User) session.getAttribute(Define.PRINCIPAL);
		
		boardFreeReportDTO.setUserId(principal.getId());
		
		System.out.println(boardFreeReportDTO.toString());
		
		int result = freeReportService.saveBoardFreeReport(boardFreeReportDTO);
		
		return result;
	}
	
	
	@PostMapping("/checkReport")
	@ResponseBody
	public String checkReport(BoardFreeReportDTO boardFreeReportDTO) {
		
		return  freeReportService.checkReport(boardFreeReportDTO);
	}
	
	

}
