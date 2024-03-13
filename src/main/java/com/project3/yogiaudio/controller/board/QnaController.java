package com.project3.yogiaudio.controller.board;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/board/qna")
public class QnaController {

	// http://localhost:80/board/qna/qnaList
	/**
	 * @Method Name : qnaList
	 * @작성일 : 2024. 3. 12.
	 * @작성자 : 노수현
	 * @변경이력 :
	 * @Method 설명 : 문의하기 목록 화면
	 */
	@GetMapping("/qnaList")
	public String qnaList() {

		return "board/qna/qnaList";
	}

	/**
	  * @Method Name : qnaView
	  * @작성일 : 2024. 3. 13.
	  * @작성자 : 노수현
	  * @변경이력 : 
	  * @Method 설명 : 문의하기 상세보기 화면
	  */
	@GetMapping("/qnaView")
	public String qnaView() {
		
		return "board/qna/qnaView";
	}
	
	/**
	  * @Method Name : qnaWrite
	  * @작성일 : 2024. 3. 13.
	  * @작성자 : 노수현
	  * @변경이력 : 
	  * @Method 설명 : 나의 문의하기 작성하기 화면
	  */
	@GetMapping("/qnaWrite")
	public String qnaWrite() {
		return "board/qna/qnaWrite";
	}
	
	/**
	  * @Method Name : qnaUpdate
	  * @작성일 : 2024. 3. 13.
	  * @작성자 : 노수현
	  * @변경이력 : 
	  * @Method 설명 : 나의 문의하기 수정하기 화면
	  */
	@GetMapping("/qnaUpdate")
	public String qnaUpdate() {
		return "board/qna/qnaUpdate";
	}
}