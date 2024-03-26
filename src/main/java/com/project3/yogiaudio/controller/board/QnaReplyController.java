package com.project3.yogiaudio.controller.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project3.yogiaudio.repository.entity.board.BoardQnaReply;
import com.project3.yogiaudio.service.board.QnaReplyService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/board/qna")
public class QnaReplyController {

	@Autowired
	private QnaReplyService qnaReplyService ;

	/**
	  * @Method Name : qnaReplyView
	  * @작성일 : 2024. 3. 26.
	  * @작성자 : 노수현
	  * @변경이력 : 
	  * @Method 설명 : 답변 상세보기
	  */
	@PostMapping("/qnaReply/{boardQnaId}")
	@ResponseBody
	public BoardQnaReply qnaReplyView(@PathVariable("boardQnaId") int boardQnaId) {

		System.out.println("dskjfdskjflkdsjl");
		
		
		System.out.println("컨트롤러상세보기" + boardQnaId);

		BoardQnaReply boardQnaReply = qnaReplyService.qnaReplyView(boardQnaId);

		System.out.println("!!!!!@#@!#!@#!@#!@#@!#" + boardQnaReply);

		return boardQnaReply;
	}
}
