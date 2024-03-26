package com.project3.yogiaudio.controller.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project3.yogiaudio.dto.board.FreeCommentDTO;
import com.project3.yogiaudio.repository.entity.User;
import com.project3.yogiaudio.repository.entity.board.BoardFreeComment;
import com.project3.yogiaudio.service.board.FreeCommentService;
import com.project3.yogiaudio.util.Define;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/board/free")
public class FreeCommentController {

	@Autowired
	private HttpSession session;

	@Autowired
	private FreeCommentService freeCommentService;

	// 댓글 작성하기 화면
	@GetMapping("/freeComment/{boardFreeId}")
	public String freeCommentInsertPage(@PathVariable("boardFreeId") int boardFreeId, Model model) {

		model.addAttribute("boardFreeId", boardFreeId);

		return "board/free/freeView";
	}

	// 댓글 작성하기
	@PostMapping("/freeComment/{boardFreeId}")
	@ResponseBody
	public boolean freeCommentInsert(@PathVariable("boardFreeId") int boardFreeId,
			@RequestBody FreeCommentDTO freeCommentDTO) {
		System.out.println("컨트롤러작성하기" + boardFreeId);

		User principal = (User) session.getAttribute(Define.PRINCIPAL);

		freeCommentDTO.setWriterId(principal.getId());

		System.out.println("작성하기컨트롤러" + freeCommentDTO);

		boolean result = freeCommentService.freeCommentSave(freeCommentDTO, boardFreeId);

		return result;
	}

	// 댓글 상세보기
	@PostMapping("/freeComment")
	@ResponseBody
	public BoardFreeComment freeCommentView(@RequestParam("boardFreeId") int boardFreeId) {

		System.out.println("컨트롤러상세보기" + boardFreeId);

		BoardFreeComment boardFreeComment = freeCommentService.freeCommentView(boardFreeId);

		System.out.println("컨트롤러상세보기" + boardFreeComment);

		return boardFreeComment;
	}

	// 댓글 리스트
	@GetMapping("/freeCommentList/{boardFreeId}")
	@ResponseBody
	public List<BoardFreeComment> getFreeCommentList(@PathVariable("boardFreeId") int boardFreeId) {
		return freeCommentService.selectFreeCommentList(boardFreeId);
	}

	// 댓글 삭제 컨트롤러 메소드
	@DeleteMapping("/freeComment/{id}")
	@ResponseBody
	public boolean deleteComment(@PathVariable("id") int id) {
		// 댓글 삭제 로직 수행
		boolean result = freeCommentService.freeCommentDelete(id);
		return result;
	}

	// 댓글 수정 컨트롤러 메소드
	@PostMapping("/freeComment/update")
	@ResponseBody
	public String updateComment(@RequestParam("id") int id, @RequestParam("comment") String comment) {
		boolean result = freeCommentService.freeCommentUpdate(id, comment);
		return comment;
	}
}
