package com.project3.yogiaudio.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project3.yogiaudio.dto.admin.AdminCriteria;
import com.project3.yogiaudio.dto.music.MusicDTO;
import com.project3.yogiaudio.dto.music.MusicVideoDTO;
import com.project3.yogiaudio.repository.entity.History;
import com.project3.yogiaudio.repository.entity.Music;
import com.project3.yogiaudio.repository.entity.Refund;
import com.project3.yogiaudio.repository.entity.User;
import com.project3.yogiaudio.repository.entity.board.BoardFree;
import com.project3.yogiaudio.repository.entity.board.BoardFreeComment;
import com.project3.yogiaudio.repository.entity.board.BoardNotice;
import com.project3.yogiaudio.repository.entity.board.BoardQna;
import com.project3.yogiaudio.repository.entity.board.BoardQnaReply;

@Mapper
public interface AdminRepository {
	
	// 유저 목록
	public List<User> findAllUser(AdminCriteria cri);
	// 유저 카운팅
	public int countAllUser();
	// 유저 삭제 / 타입 long
	public boolean deleteUser(Long id);
	
	// 음악 목록
	public List<Music> findAllMusic(AdminCriteria cri);
	// 음악 카운팅
	public int countAllMusic();
	
	//뮤비목록
	public List<MusicVideoDTO> findAllMusicVideo(AdminCriteria cri);
	
	//뮤비카운팅
	public int countAllMusicVideo();
	
	// 음악 삭제
	public boolean deleteMusic(Integer musicNo);
	
	// 결제 내역
	public List<History> findAllHistory(AdminCriteria cri);
	// 결제 내역 카운팅
	public int countAllHistory();
	
	// 환불 내역
	public List<Refund> findAllRefund(AdminCriteria cri);
	// 환불 내역 카운팅
	public int countAllRefund();
	
	//음원등록
	public Integer insertMusic(MusicDTO dto);
	//뮤비등록
	public Integer insertMusicVideo(MusicVideoDTO dto);
	
	
}
