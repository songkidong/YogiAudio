package com.project3.yogiaudio.service.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project3.yogiaudio.repository.entity.board.BoardQnaReply;
import com.project3.yogiaudio.repository.interfaces.board.QnaReplyRepository;

@Service
public class QnaReplyService {

	@Autowired
	private QnaReplyRepository qnaReplyRepository;

	
	
	/**
	  * @Method Name : qnaReplyView
	  * @작성일 : 2024. 3. 26.
	  * @작성자 : 노수현
	  * @변경이력 : 
	  * @Method 설명 : 답변 상세보기
	  */
	public BoardQnaReply qnaReplyView(int boardQnaId) {

		System.out.println(" 서비스 " + boardQnaId);

		return qnaReplyRepository.qnaReplyView(boardQnaId);
	}

}
