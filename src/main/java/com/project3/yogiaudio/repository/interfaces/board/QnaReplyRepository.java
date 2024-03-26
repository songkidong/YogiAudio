package com.project3.yogiaudio.repository.interfaces.board;

import org.apache.ibatis.annotations.Mapper;

import com.project3.yogiaudio.repository.entity.board.BoardQnaReply;

@Mapper
public interface QnaReplyRepository {

	// 답변 상세보기
	public BoardQnaReply qnaReplyView(int boardQnaId);

}
