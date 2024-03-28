package com.project3.yogiaudio.repository.interfaces.board;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project3.yogiaudio.repository.entity.board.BoardFree;
import com.project3.yogiaudio.repository.entity.board.BoardFreeComment;

@Mapper
public interface FreeCommentRepository {

	// 댓글 상세보기
	public BoardFreeComment freeCommentView(int boardFreeId);

	// 댓글 리스트
	public List<BoardFreeComment> selectFreeCommentList(int boardFreeId);

	// 댓글 작성하기
	public int freeCommentSave(BoardFreeComment boardFreeComment);

	// 댓글 삭제하기
	public int freeCommentDelete(int id);

	// 댓글 수정하기
	public int freeCommentUpdate(Map<String, Object> params);

}
