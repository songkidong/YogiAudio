package com.project3.yogiaudio.repository.interfaces.board;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project3.yogiaudio.repository.entity.board.BoardQna;
import com.project3.yogiaudio.repository.entity.board.BoardQnaReply;

@Mapper
public interface QnaRepository {

	// 문의하기 검색&페이지 selectAll
	public List<BoardQna> findAllByKeywordwithPasing(@Param("offset") int offset, @Param("limit") int limit,
			@Param("searchType") String searchType, @Param("searchInput") String keyword);

	// 문의하기 검색&페이지 countAll
	public int getAllPageCount(@Param("searchType") String searchType, @Param("searchInput") String keyword);

	// 문의하기 insert
	public int insertQna(BoardQna boardQna);

	// 문의하기 상세보기
	public BoardQna findById(int id);

	// 문의하기 삭제하기
	public int qnaDelete(int id);

	// 문의하기 수정하기
	public int qnaUpdate(BoardQna boardQna);

	// 문의하기 답변 상세보기
	public BoardQnaReply qnaReplyView(int boardQnaId);

}
