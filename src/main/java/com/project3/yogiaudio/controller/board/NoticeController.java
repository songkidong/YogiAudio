package com.project3.yogiaudio.controller.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.project3.yogiaudio.dto.board.NoticeDTO;
import com.project3.yogiaudio.repository.entity.User;
import com.project3.yogiaudio.service.board.NoticeService;
import com.project3.yogiaudio.util.Define;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/board/notice")
public class NoticeController {

	@Autowired
	private HttpSession session;
	
	@Autowired
	private NoticeService noticeService;
	
	// http://localhost:80/board/notice/noticeList
	/**
	  * @Method Name : noticeList
	  * @작성일 : 2024. 3. 12.
	  * @작성자 : 노수현
	  * @변경이력 : 
	  * @Method 설명 : 공지사항 목록 화면
	  */
	@GetMapping("/noticeList")
	public String noticeList() {
		
		return "board/notice/noticeList";
	}
	
	
	/**
	  * @Method Name : noticeView
	  * @작성일 : 2024. 3. 13.
	  * @작성자 : 노수현
	  * @변경이력 : 
	  * @Method 설명 : 공지사항 상세보기 화면
	  */
	@GetMapping("/noticeView")
	public String noticeView() {
		
		return "board/notice/noticeView";
	}
	
	
	/**
	  * @Method Name : noticeWrite
	  * @작성일 : 2024. 3. 13.
	  * @작성자 : 노수현
	  * @변경이력 : 
	  * @Method 설명 : 공지사항 작성하기 화면
	  */
	@GetMapping("/noticeWrite")
	public String noticeWrite() {
		return "board/notice/noticeWrite";
	}
	
	/**
	  * @param MultipartFile 
	  * @param file 
	  * @Method Name : noticeWrite
	  * @작성일 : 2024. 3. 13.
	  * @작성자 : 노수현
	  * @변경이력 : 
	  * @Method 설명 : 공지사항 작성하기 
	  */
	@PostMapping("/noticeWrite")
	public String insertNotice(NoticeDTO noticeDTO) {
		
		User principal = (User) session.getAttribute(Define.PRINCIPAL);
		
		noticeDTO.setWriterId(principal.getId());
		
		int result = noticeService.saveNotice(noticeDTO);
		
		if(result != 1) {
			// TODO : 예외처리
		}
		
		return "redirect:/board/notice/noticeList";
	}
	
	
	/**
	  * @Method Name : noticeUpdate
	  * @작성일 : 2024. 3. 13.
	  * @작성자 : 노수현
	  * @변경이력 : 
	  * @Method 설명 : 공지사항 수정하기 화면
	  */
	@GetMapping("/noticeUpdate")
	public String noticeUpdate() {
		return "board/notice/noticeUpdate";
	}
	
}