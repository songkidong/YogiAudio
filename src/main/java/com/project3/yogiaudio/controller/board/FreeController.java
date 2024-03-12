package com.project3.yogiaudio.controller.board;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/board/free")
public class FreeController {

	// http://localhost:80/board/free/freeList
		/**
		  * @Method Name : freeList
		  * @작성일 : 2024. 3. 12.
		  * @작성자 : 노수현
		  * @변경이력 : 
		  * @Method 설명 : 자유게시판 목록 화면
		  */
		@GetMapping("/freeList")
		public String freeList() {
			
			return"board/free/freeList";
		}
	
	
	
	
}
