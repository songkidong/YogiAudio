package com.project3.yogiaudio.controller.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.project3.yogiaudio.dto.board.NoticeDTO;
import com.project3.yogiaudio.dto.common.PageReq;
import com.project3.yogiaudio.dto.common.PageRes;
import com.project3.yogiaudio.repository.entity.User;
import com.project3.yogiaudio.repository.entity.board.BoardNotice;
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
	/*
	 * @GetMapping("/noticeList") public String noticeList() {
	 * 
	 * return "board/notice/noticeList"; }
	 */

	/**
	 * @Method Name : noticeList
	 * @작성일 : 2024. 3. 14.
	 * @작성자 : 노수현
	 * @변경이력 :
	 * @Method 설명 : 공지사항 검색&페이징 목록
	 */
	@GetMapping("/noticeList")
	public String noticeList(PageReq pageReq, Model model) {
		
		// 페이징
		if (pageReq.getPage() <= 0) {
			pageReq.setPage(1); // 페이지가 0 이하일 경우 첫 페이지로 설정한다
		}

		if (pageReq.getSize() <= 0) {
			pageReq.setSize(10); // 페이지 당 보여줄 개수
		}
		
		PageRes<BoardNotice> pageRes = noticeService.findAllByKeywordwithPasing(pageReq); // 페이징 처리함
		List<BoardNotice> noticeList = pageRes.getContent(); // 내용을 보여줄거다

		// 페이징 정보를 모델에 추가
		model.addAttribute("noticeList", noticeList); // 프로젝트 마다 다른 코드
		// 공통 코드
		model.addAttribute("page", pageReq.getPage());
		model.addAttribute("size", pageRes.getSize());
		model.addAttribute("totalPages", pageRes.getTotalPages());
		model.addAttribute("startPage", pageRes.getStartPage());
		model.addAttribute("endPage", pageRes.getEndPage());

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
		
		System.out.println(noticeDTO.toString());

		int result = noticeService.saveNotice(noticeDTO);

		if (result != 1) {
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