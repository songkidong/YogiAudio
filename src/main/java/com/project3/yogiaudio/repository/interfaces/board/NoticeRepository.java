package com.project3.yogiaudio.repository.interfaces.board;

import org.apache.ibatis.annotations.Mapper;

import com.project3.yogiaudio.repository.entity.board.BoardNotice;

@Mapper
public interface NoticeRepository {

	// 공지사항 insert
	public int insertNotice(BoardNotice boardNotice); //insert 쿼리 실행 후 return 1을 반환 (성공했는지 안했는지) 
	
	
}
