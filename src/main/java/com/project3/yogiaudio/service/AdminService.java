package com.project3.yogiaudio.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project3.yogiaudio.dto.admin.AdminCriteria;
import com.project3.yogiaudio.dto.admin.NoticeSaveFormDTO;
import com.project3.yogiaudio.dto.board.NoticeDTO;
import com.project3.yogiaudio.dto.music.MusicDTO;
import com.project3.yogiaudio.dto.music.MusicVideoDTO;
import com.project3.yogiaudio.filedb.service.FiledbService;
import com.project3.yogiaudio.repository.entity.History;
import com.project3.yogiaudio.repository.entity.Music;
import com.project3.yogiaudio.repository.entity.Refund;
import com.project3.yogiaudio.repository.entity.User;
import com.project3.yogiaudio.repository.entity.board.BoardFree;
import com.project3.yogiaudio.repository.entity.board.BoardFreeComment;
import com.project3.yogiaudio.repository.entity.board.BoardNotice;
import com.project3.yogiaudio.repository.entity.board.BoardQna;
import com.project3.yogiaudio.repository.interfaces.AdminRepository;

@Service
public class AdminService {

	@Autowired
	AdminRepository adminRepository;
	
	
	/**
	  * @Method Name : findAllUser
	  * @작성일 : 2024. 3. 12.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 유저 목록
	  */
	public List<User> findAllUser(AdminCriteria cri) {
		
		return adminRepository.findAllUser(cri);
	}
	
	/**
	  * @Method Name : countAllUser
	  * @작성일 : 2024. 3. 12.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 유저 카운팅
	  */
	public int countAllUser() {
		
		return adminRepository.countAllUser();
	}
	
	/**
	  * @Method Name : deleteUser
	  * @작성일 : 2024. 3. 12.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 유저 삭제
	  */
	public boolean deleteUser(Long id) {
		
		return adminRepository.deleteUser(id);
	}
	
	/**
	  * @Method Name : findAllMusic
	  * @작성일 : 2024. 3. 13.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 음악 목록
	  */
	public List<Music> findAllMusic(AdminCriteria cri) {
		
		return adminRepository.findAllMusic(cri);
	}
	
	
	// 뮤비리스트
	public List<MusicVideoDTO> findAllMusicVideo(AdminCriteria cri){
		return adminRepository.findAllMusicVideo(cri);
	}
	
	
	
	/**
	  * @Method Name : countAllMusic
	  * @작성일 : 2024. 3. 13.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 음악 카운팅
	  */
	public int countAllMusic() { 
		
		return adminRepository.countAllMusic();
	}
	
	
	//뮤비리스트카운팅
	public int countAllMusicVideo() {
		return adminRepository.countAllMusicVideo();
	}
	
	
	/**
	  * @Method Name : deleteMusic
	  * @작성일 : 2024. 3. 13.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 음악 삭제
	  */
	public boolean deleteMusic(Integer musicNo) {
		
		return adminRepository.deleteMusic(musicNo);
	}
	
	/**
	  * @Method Name : findAllHistory
	  * @작성일 : 2024. 3. 22.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 결제 내역
	  */
	public List<History> findAllHistory(AdminCriteria cri) {
		
		return adminRepository.findAllHistory(cri);
	}
	
	/**
	  * @Method Name : countAllHistory
	  * @작성일 : 2024. 3. 22.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 결제 내역 카운팅
	  */
	public int countAllHistory() {
		
		return adminRepository.countAllHistory();
	}
	
	/**
	  * @Method Name : selectAllRefund
	  * @작성일 : 2024. 3. 22.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 환불 내역
	  */
	public List<Refund> findAllRefund(AdminCriteria cri) {
		
		return adminRepository.findAllRefund(cri);
	}
	
	/**
	  * @Method Name : countAllRefund
	  * @작성일 : 2024. 3. 22.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 환불 내역 카운팅
	  */
	public int countAllRefund() {
		
		return adminRepository.countAllRefund();
	}
	
	
	
	//음원등록
	@Transactional
	public void insertMusic(MusicDTO dto,String filePath,String fileMusic,String musicSample) {
		
		MusicDTO music = MusicDTO.builder()
			.musictitle(dto.getMusictitle())
			.musicsinger(dto.getMusicsinger())
			.musiccontent(dto.getMusiccontent())
			.musiccompany(dto.getMusiccompany())
			.musicmajor(dto.getMusicmajor())
			.musicminor(dto.getMusicminor())
			.musicprice(dto.getMusicprice())
			.lyrics(dto.getLyrics())
			.startdate(dto.getStartdate())
			.filepath(filePath)
			.filemusic(fileMusic)
			.musicsample(musicSample)
			.build();
		
		Integer result = adminRepository.insertMusic(music);
		
		
	}
	
	
	
	//뮤비등록
	@Transactional
	public void insertMusicVideo(MusicVideoDTO dto,String filePath) {
		
		MusicVideoDTO mv = MusicVideoDTO.builder()
				.musicno(dto.getMusicno())
				.videotitle(dto.getVideotitle())
				.videosinger(dto.getVideosinger())
				.filepath(filePath)
				.mvfile(dto.getMvfile())
				.videocontent(dto.getVideocontent())
				.musicmajor(dto.getMusicmajor())
				.musicminor(dto.getMusicminor())
				.build();
		
		Integer result = adminRepository.insertMusicVideo(mv);
		
		
	}
	
	
	
}
