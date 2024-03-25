package com.project3.yogiaudio.repository.interfaces.board;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project3.yogiaudio.repository.entity.board.BoardFree;
import com.project3.yogiaudio.repository.entity.board.BoardFreeComment;

@Mapper
public interface FreeCommentRepository {

	public BoardFreeComment freeCommentView(int boardFreeId);

	public List<BoardFreeComment> selectFreeCommentList(int boardFreeId);

	public int freeCommentSave(BoardFreeComment boardFreeComment);

	public int freeCommentDelete(int id);

	public int freeCommentUpdate(Map<String, Object> params);

}
