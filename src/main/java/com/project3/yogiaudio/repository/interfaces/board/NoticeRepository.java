package com.project3.yogiaudio.repository.interfaces.board;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project3.yogiaudio.repository.entity.board.BoardNotice;
import com.project3.yogiaudio.repository.entity.board.BoardQna;

@Mapper
public interface NoticeRepository {

	// 공지사항 insert
	public int insertNotice(BoardNotice boardNotice); //insert 쿼리 실행 후 return 1을 반환 (성공했는지 안했는지) 
	
	// 공지사항 검색&페이지 selectAll
	public List<BoardNotice> findAllByKeywordwithPasing(@Param ("offset") int offset, @Param ("limit") int limit,@Param ("searchType") String searchType,@Param ("searchInput") String keyword);

	// 공지사항 검색&페이지 countAll
	public int getAllPageCount(@Param ("searchType") String searchType,@Param ("searchInput") String keyword);

	// 공지사항 상세보기
	public BoardNotice findAllById(int id);

	// 공지사항 삭제하기
	public int noticeDelete(int id);

	// 공지사항 수정하기
	public int noticeUpdate(BoardNotice boardNotice);
}
