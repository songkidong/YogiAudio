package com.project3.yogiaudio.repository.interfaces.board;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project3.yogiaudio.dto.board.BoardFreeReportDTO;
import com.project3.yogiaudio.repository.entity.board.BoardFree;
import com.project3.yogiaudio.repository.entity.board.BoardFreeReport;

@Mapper
public interface FreeRepository {

	// 자유게시판 insert
	public int insertFree(BoardFree boardfree); // insert 쿼리 실행 후 return 1을 반환 (성공했는지 안했는지)

	// 자유게시판 검색&페이지 selectAll
	public List<BoardFree> findAllByKeywordwithPasing(@Param("offset") int offset, @Param("limit") int limit,
			@Param("searchType") String searchType, @Param("searchInput") String keyword);

	// 자유게시판 검색&페이지 countAll
	public int getAllPageCount(@Param("searchType") String searchType, @Param("searchInput") String keyword);

	// 자유게시판 상세보기
	public BoardFree findAllById(int id);

	// 자유게시판 삭제하기
	public int freeDelete(int id);

	// 자유게시판 수정하기
	public int freeUpdate(BoardFree boardfree);

	public List<BoardFree> findAllByOrderByCreatedAtASCWithPaging(@Param("offset") int offset, @Param("size") int size);

	public List<BoardFree> findAllByOrderByHitDescWithPaging(@Param("offset") int offset, @Param("size") int size);

	public long countAllByOrderByCreatedAtASC();

	public long countAllByOrderByHitDesc();

	// 조회수 증가
	public void incrementViewCount(int id);

	// 게시판 신고하기
	public int insertFreeReport(BoardFreeReport boardFreeReport);

}
