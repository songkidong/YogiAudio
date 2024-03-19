package com.project3.yogiaudio.controller.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project3.yogiaudio.dto.common.PageReq;
import com.project3.yogiaudio.dto.common.PageRes;
import com.project3.yogiaudio.repository.entity.board.BoardNotice;
import com.project3.yogiaudio.repository.entity.board.BoardQna;
import com.project3.yogiaudio.service.board.QnaService;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/board/qna")
public class QnaController {
	
	@Autowired
	private HttpSession session;
	
	@Autowired
	private QnaService qnaService;
	

	// http://localhost:80/board/qna/qnaList
	/**
	 * @Method Name : qnaList
	 * @작성일 : 2024. 3. 12.
	 * @작성자 : 노수현
	 * @변경이력 :
	 * @Method 설명 : 문의하기 목록 화면
	 */
	/*
	 * @GetMapping("/qnaList") public String qnaList() {
	 * 
	 * return "board/qna/qnaList"; }
	 */

	/**
	  * @Method Name : qnaList
	  * @작성일 : 2024. 3. 19.
	  * @작성자 : 노수현
	  * @변경이력 : 
	  * @Method 설명 : 문의하기 검색&페이징 목록
	  */
	@GetMapping("/qnaList")
	public String qnaList(PageReq pageReq, Model model) {
		
		// 페이징
		if (pageReq.getPage() <= 0) {
			pageReq.setPage(1); // 페이지가 0 이하일 경우 첫 페이지로 설정한다
		}

		if (pageReq.getSize() <= 0) {
			pageReq.setSize(10); // 페이지 당 보여줄 개수
		}
		
		PageRes<BoardQna> pageRes = qnaService.findAllByKeywordwithPasing(pageReq); // 페이징 처리함
		List<BoardQna> qnaList = pageRes.getContent(); // 내용을 보여줄거다

		// 페이징 정보를 모델에 추가
		model.addAttribute("qnaList", qnaList); // 프로젝트 마다 다른 코드
		System.out.println("리스트 나와라!!!!!!!!!!!"+qnaList.toString());
		// 공통 코드
		model.addAttribute("page", pageReq.getPage());
		model.addAttribute("size", pageRes.getSize());
		model.addAttribute("totalPages", pageRes.getTotalPages());
		model.addAttribute("startPage", pageRes.getStartPage());
		model.addAttribute("endPage", pageRes.getEndPage());

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