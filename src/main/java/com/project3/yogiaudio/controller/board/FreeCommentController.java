package com.project3.yogiaudio.controller.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project3.yogiaudio.dto.board.FreeCommentDTO;
import com.project3.yogiaudio.repository.entity.User;
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

	// 댓글 입력
	@PostMapping("/comment")
	@ResponseBody
	public String commentInsert(@RequestBody FreeCommentDTO freeCommentDTO) {
		log.info("commentInsert : " + freeCommentDTO);

		User principal = (User) session.getAttribute(Define.PRINCIPAL);

		freeCommentDTO.setWriterId(principal.getId());


		int result = freeCommentService.insertComment(freeCommentDTO);

		if (result != 1) {
			// TODO : 예외처리
		}

		return "redirect:/board/free/freeList";
	}

}
