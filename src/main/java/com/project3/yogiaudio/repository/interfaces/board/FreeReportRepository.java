package com.project3.yogiaudio.repository.interfaces.board;

import org.apache.ibatis.annotations.Mapper;

import com.project3.yogiaudio.dto.board.BoardFreeReportDTO;
import com.project3.yogiaudio.repository.entity.board.BoardFreeReport;

@Mapper
public interface FreeReportRepository {

	// 게시글 신고하기
	public int insertFreeBoardReport(BoardFreeReport boardFreeReport);

	// 게시글 신고 중복 확인
	public BoardFreeReport checkReport(BoardFreeReportDTO boardFreeReportDTO);
	
}
