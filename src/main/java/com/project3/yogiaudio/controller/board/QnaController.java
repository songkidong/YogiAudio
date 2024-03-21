package com.project3.yogiaudio.controller.board;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project3.yogiaudio.dto.board.BoardFileDTO;
import com.project3.yogiaudio.dto.board.QnaDTO;
import com.project3.yogiaudio.dto.board.QnaUpdateDTO;
import com.project3.yogiaudio.dto.common.PageReq;
import com.project3.yogiaudio.dto.common.PageRes;
import com.project3.yogiaudio.filedb.entity.Filedb;
import com.project3.yogiaudio.filedb.service.FiledbService;
import com.project3.yogiaudio.repository.entity.User;
import com.project3.yogiaudio.repository.entity.board.BoardQna;
import com.project3.yogiaudio.service.board.QnaService;
import com.project3.yogiaudio.util.Define;

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

	@Autowired
	private FiledbService filedbService;

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
		System.out.println("리스트 나와라!!!!!!!!!!!" + qnaList.toString());
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
	@GetMapping("/qnaView/{id}")
	public String qnaView() {

		return "board/qna/qnaView";
	}

	/**
	 * @Method Name : qnaViewId
	 * @작성일 : 2024. 3. 19.
	 * @작성자 : 노수현
	 * @변경이력 :
	 * @Method 설명 : 문의하기 상세보기 출력
	 */
	@PostMapping("/qnaView/{id}")
	@ResponseBody
	public BoardQna qnaViewId(@PathVariable(value = "id") int id) {
		System.out.println("아이디아이디 : " + id);

		BoardQna boardQna = qnaService.qnaReadById(id);

		System.out.println("엔티티엔티티 : " + boardQna.toString());

		return boardQna;
	}

	/**
	 * @Method Name : qnaWrite
	 * @작성일 : 2024. 3. 13.
	 * @작성자 : 노수현
	 * @변경이력 :
	 * @Method 설명 : 문의하기 작성하기 화면
	 */
	@GetMapping("/qnaWrite")
	public String qnaWrite() {
		return "board/qna/qnaWrite";
	}

	/**
	 * @Method Name : insertQna
	 * @작성일 : 2024. 3. 19.
	 * @작성자 : 노수현
	 * @변경이력 :
	 * @Method 설명 : 문의하기 작성하기
	 */
	@PostMapping("/qnaWrite")
	public String insertQna(QnaDTO qnaDTO) {

		User principal = (User) session.getAttribute(Define.PRINCIPAL);

		qnaDTO.setWriterId(principal.getId());

		System.out.println(qnaDTO.toString());

		int result = qnaService.saveQna(qnaDTO);

		if (result != 1) {
			// TODO : 예외처리
		}

		return "redirect:/board/qna/qnaList";
	}

	/**
	 * @param modifiedUrl 
	 * @Method Name : qnaUpdate
	 * @작성일 : 2024. 3. 13.
	 * @작성자 : 노수현
	 * @변경이력 :
	 * @Method 설명 : 문의하기 수정하기 화면
	 */
	@GetMapping("/qnaUpdate/{id}")
	public String qnaUpdate(@PathVariable(value = "id") int id, Model model) {
		
		QnaDTO qnaDTO = new QnaDTO();

		BoardQna boardQna = qnaService.qnaReadById(id);

		// id에 맞는 title, content값 세팅
		qnaDTO.setTitle(boardQna.getTitle());
		qnaDTO.setContent(boardQna.getContent());

		// qna db값
		String filePath = boardQna.getFilePath();

		// qna db값을 쉼표를 기준으로 문자열 분리 - 다중 파일
		String[] filePathList = filePath.split(",");

		//OriginFileName, UUID 값 가진 DTO
		List<BoardFileDTO> boardFileDTOList = new ArrayList<>();
		
		for (String url : filePathList) {  
			BoardFileDTO boardFileDTO = new BoardFileDTO(); // BoardFileDTO의 재사용 문제 : 마지막 파일 정보로 모든 boardFileDTOList 요소가 덮어쓰여졌음
			
            String uuid = url.replace("http://localhost/filedb/get-file/", "");
            Filedb filedb = filedbService.findByUuid(uuid);
            String originFileName = filedb.getOriginalFileName();
            System.out.println("originFileName추출" + originFileName);
            System.out.println("uuid추출" + uuid);
            
            boardFileDTO.setFilePath(url);
            boardFileDTO.setOriginFileName(originFileName);
            boardFileDTOList.add(boardFileDTO);
            System.out.println("url추출" + url);
            System.out.println("boardFileDTO추출" + boardFileDTO);
            System.out.println("boardFileDTOList추출" + boardFileDTOList);            
        }
		
		qnaDTO.setBoardFileDTOList(boardFileDTOList);
		
		model.addAttribute("qnaDTO", qnaDTO);

		return "board/qna/qnaUpdate";
	}

	/**
	 * @Method Name : qnaUpdate
	 * @작성일 : 2024. 3. 19.
	 * @작성자 : 노수현
	 * @변경이력 :
	 * @Method 설명 : 문의하기 수정하기 출력
	 */
	@PostMapping("/qnaUpdate/{id}")
	@ResponseBody
	public boolean qnaUpdate(@PathVariable(value = "id") int id, QnaUpdateDTO qnaUpdateDTO) {

		System.out.println("아이디 번호" + id);
		
		System.out.println("데이터" + qnaUpdateDTO.toString());

//		boolean result = qnaService.qnaUpdate(id, qnaUpdateDTO);
//
//		return result;
		return true;
	}

	/**
	 * @Method Name : qnaDelete
	 * @작성일 : 2024. 3. 19.
	 * @작성자 : 노수현
	 * @변경이력 :
	 * @Method 설명 : 문의하기 삭제하기
	 */
	@PostMapping("/qnaDelete/{id}")
	@ResponseBody
	public boolean qnaDelete(@PathVariable(value = "id") int id) {
		boolean result = qnaService.qnaDelete(id);

		return result;
	}

}