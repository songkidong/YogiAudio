package com.project3.yogiaudio.controller.board;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project3.yogiaudio.dto.board.BoardFileDTO;
import com.project3.yogiaudio.dto.board.FreeDTO;
import com.project3.yogiaudio.dto.board.FreeUpdateDTO;
import com.project3.yogiaudio.dto.common.PageReq;
import com.project3.yogiaudio.dto.common.PageRes;
import com.project3.yogiaudio.filedb.entity.Filedb;
import com.project3.yogiaudio.filedb.service.FiledbService;
import com.project3.yogiaudio.repository.entity.User;
import com.project3.yogiaudio.repository.entity.board.BoardFree;
import com.project3.yogiaudio.service.board.FreeService;
import com.project3.yogiaudio.util.Define;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestBody;


@Slf4j
@Controller
@RequestMapping("/board/free")
public class FreeController {

	@Autowired
	private HttpSession session;

	@Autowired
	private FreeService freeService;

	@Autowired
	private FiledbService filedbService;

	// http://localhost:80/board/free/freeList
	/**
	 * @Method Name : freeList
	 * @작성일 : 2024. 3. 12.
	 * @작성자 : 노수현
	 * @변경이력 :
	 * @Method 설명 : 자유게시판 목록 화면
	 */
	/*
	 * @GetMapping("/freeList") public String freeList() {
	 * 
	 * return "board/free/freeList"; }
	 */

	/**
	 * @Method Name : freeList
	 * @작성일 : 2024. 3. 23.
	 * @작성자 : 노수현
	 * @변경이력 :
	 * @Method 설명 : 자유게시판 검색&페이징 목록
	 */
	@GetMapping("/freeList")
	public String freeList(PageReq pageReq, Model model) {

		// 페이징
		if (pageReq.getPage() <= 0) {
			pageReq.setPage(1); // 페이지가 0 이하일 경우 첫 페이지로 설정한다
		}

		if (pageReq.getSize() <= 0) {
			pageReq.setSize(10); // 페이지 당 보여줄 개수
		}

		PageRes<BoardFree> pageRes = freeService.findAllByKeywordwithPasing(pageReq); // 페이징 처리함
		List<BoardFree> freeList = pageRes.getContent(); // 내용을 보여줄거다

		// 페이징 정보를 모델에 추가
		model.addAttribute("freeList", freeList); // 프로젝트 마다 다른 코드
		System.out.println("리스트 나와라!!!!!!!!!!!" + freeList.toString());
		// 공통 코드
		model.addAttribute("page", pageReq.getPage());
		model.addAttribute("size", pageRes.getSize());
		model.addAttribute("totalPages", pageRes.getTotalPages());
		model.addAttribute("startPage", pageRes.getStartPage());
		model.addAttribute("endPage", pageRes.getEndPage());

		return "board/free/freeList";
	}

	/**
	 * @Method Name : freeView
	 * @작성일 : 2024. 3. 23.
	 * @작성자 : 노수현
	 * @변경이력 :
	 * @Method 설명 : 자유게시판 상세보기 화면
	 */
	@GetMapping("/freeView/{id}")
	public String freeView() {

		return "board/free/freeView";
	}

	/**
	 * @Method Name : freeView
	 * @작성일 : 2024. 3. 23.
	 * @작성자 : 노수현
	 * @변경이력 :
	 * @Method 설명 : 자유게시판 상세보기 출력
	 */
	@PostMapping("/freeView/{id}")
	@ResponseBody
	public BoardFree freeViewId(@PathVariable(value = "id") int id) {
		System.out.println("아이디아이디 : " + id);

		BoardFree boardfree = freeService.freeReadById(id);

		System.out.println("엔티티엔티티 : " + boardfree.toString());

		return boardfree;
	}

	/**
	 * @Method Name : freeWrite
	 * @작성일 : 2024. 3. 13.
	 * @작성자 : 노수현
	 * @변경이력 :
	 * @Method 설명 : 자유게시판 작성하기 화면
	 */
	@GetMapping("/freeWrite")
	public String freeWrite() {
		return "board/free/freeWrite";
	}

	/**
	 * @Method Name : insertFree
	 * @작성일 : 2024. 3. 23.
	 * @작성자 : 노수현
	 * @변경이력 :
	 * @Method 설명 : 자유게시판 작성하기
	 */
	@PostMapping("/freeWrite")
	public String insertfree(FreeDTO freeDTO) {
		System.out.println("컨트롤러 "+ freeDTO);
		
		User principal = (User) session.getAttribute(Define.PRINCIPAL);

		freeDTO.setWriterId(principal.getId());

		System.out.println(freeDTO.toString());

		int result = freeService.savefree(freeDTO);

		if (result != 1) {
			// TODO : 예외처리
		}

		return "redirect:/board/free/freeList";
	}

	/**
	 * @Method Name : freeUpdate
	 * @작성일 : 2024. 3. 23.
	 * @작성자 : 노수현
	 * @변경이력 :
	 * @Method 설명 : 자유게시판 수정하기 화면
	 */
	@GetMapping("/freeUpdate/{id}")
	public String freeUpdate(@PathVariable(value = "id") int id, Model model) {

		FreeDTO freeDTO = new FreeDTO();

		BoardFree boardfree = freeService.freeReadById(id);

		// id에 맞는 title, content값 세팅
		freeDTO.setTitle(boardfree.getTitle());
		freeDTO.setContent(boardfree.getContent());

		// qna db값
		String filePath = boardfree.getFilePath();

		// qna db값을 쉼표를 기준으로 문자열 분리 - 다중 파일
		String[] filePathList = filePath.split(",");

		// OriginFileName, UUID 값 가진 DTO
		List<BoardFileDTO> boardFileDTOList = new ArrayList<>();

		for (String url : filePathList) {
			BoardFileDTO boardFileDTO = new BoardFileDTO(); // BoardFileDTO의 재사용 문제 : 마지막 파일 정보로 모든 boardFileDTOList 요소가
															// 덮어쓰여졌음

			String uuid = url.replace("http://localhost/filedb/get-file/", "");
			Filedb filedb = filedbService.findByUuid(uuid);

			if (filedb != null) { // filedb가 null이 아닌 경우에만 처리
				String originFileName = filedb.getOriginalFileName();
				System.out.println("originFileName추출" + originFileName);
				System.out.println("uuid추출" + uuid);

				boardFileDTO.setFilePath(url);
				boardFileDTO.setOriginFileName(originFileName);
				boardFileDTOList.add(boardFileDTO);
				System.out.println("url추출" + url);
				System.out.println("boardFileDTO추출" + boardFileDTO);
				System.out.println("boardFileDTOList추출" + boardFileDTOList);
			} else {
				// filedb가 null일 경우 처리
				System.out.println("filedb가 null입니다. uuid: " + uuid);
				// 원하는 예외 처리를 추가하세요.
			}
		}

		freeDTO.setBoardFileDTOList(boardFileDTOList);

		model.addAttribute("freeDTO", freeDTO);

		return "board/free/freeUpdate";
	}

	/**
	 * @Method Name : freeUpdate
	 * @작성일 : 2024. 3. 23.
	 * @작성자 : 노수현
	 * @변경이력 :
	 * @Method 설명 : 자유게시판 수정하기
	 */
	@PostMapping("/freeUpdate/{id}")
	@ResponseBody
	public boolean freeUpdate(@PathVariable(value = "id") int id, FreeUpdateDTO freeUpdateDTO) {

		System.out.println("아이디 번호" + id);
		System.out.println("데이터" + freeUpdateDTO.toString());

		boolean result = freeService.freeUpdate(id, freeUpdateDTO);

		return result;
	}

	/**
	 * @Method Name : freeDelete
	 * @작성일 : 2024. 3. 23.
	 * @작성자 : 노수현
	 * @변경이력 :
	 * @Method 설명 : 자유게시판 삭제하기
	 */
	@PostMapping("/freeDelete/{id}")
	@ResponseBody
	public boolean freeDelete(@PathVariable(value = "id") int id) {
		boolean result = freeService.freeDelete(id);

		return result;
	}
	
	/**
	 * @Method Name : sortFreeBoard
	 * @작성일 : 2024. 3. 23.
	 * @작성자 : 노수현
	 * @변경이력 :
	 * @Method 설명 : 자유게시판 정렬
	 */
	@GetMapping("/sort")
	@ResponseBody
    public PageRes<BoardFree> sortFreeBoard(@RequestParam("sortType") String sortType, @RequestParam("page") int page) {
        int size = 10; // 페이지당 아이템 수
        PageRes<BoardFree> sortedPage = freeService.getSortedFreeBoard(sortType, page, size);

        System.out.println("sortedPage " + sortedPage);

        return sortedPage;
    }
	
	@PostMapping("/blameFree")
	@ResponseBody
	public int insertBlameFree() {
		
		return 0;
	}
	
	
	
}
