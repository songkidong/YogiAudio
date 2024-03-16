package com.project3.yogiaudio.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project3.yogiaudio.dto.admin.AdminCriteria;
import com.project3.yogiaudio.dto.admin.NoticeSaveFormDTO;
import com.project3.yogiaudio.dto.board.NoticeDTO;
import com.project3.yogiaudio.filedb.service.FiledbService;
import com.project3.yogiaudio.repository.entity.Music;
import com.project3.yogiaudio.repository.entity.User;
import com.project3.yogiaudio.repository.entity.board.BoardNotice;
import com.project3.yogiaudio.repository.entity.board.BoardQna;
import com.project3.yogiaudio.repository.interfaces.AdminRepository;

@Service
public class AdminService {

	@Autowired
	AdminRepository adminRepository;
	
	@Autowired
	FiledbService fileDbService;
	
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
	  * @Method Name : findAllNotice
	  * @작성일 : 2024. 3. 13.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 공지사항 목록
	  */
	public List<BoardNotice> findAllNotice(AdminCriteria cri) {
		
		return adminRepository.findAllNotice(cri);
	}
	
	/**
	  * @Method Name : countAllNotice
	  * @작성일 : 2024. 3. 13.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 공지사항 카운팅
	  */
	public int countAllNotice() {
		
		return adminRepository.countAllNotice();
	}
	
	/**
	  * @Method Name : deleteNotice
	  * @작성일 : 2024. 3. 13.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 공지사항 삭제
	  */
	public boolean deleteNotice(Integer id) {
		
		return adminRepository.deleteNotice(id);
	}
	
	/**
	  * @Method Name : findAllQna
	  * @작성일 : 2024. 3. 14.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : qna 목록
	  */
	public List<BoardQna> findAllQna(AdminCriteria cri) {
		
		return adminRepository.findAllQna(cri);
	}
	
	/**
	  * @Method Name : countAllQna
	  * @작성일 : 2024. 3. 14.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : qna 카운팅
	  */
	public int countAllQna() {
		
		return adminRepository.countAllQna();
	}
	
	/**
	  * @Method Name : deleteQna
	  * @작성일 : 2024. 3. 14.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : qna 삭제
	  */
	public boolean deleteQna(Integer id) {
		
		return adminRepository.deleteQna(id);
	}
	
	/**
	  * @Method Name : insertNotice
	  * @작성일 : 2024. 3. 14.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 공지사항 등록
	  */
	public boolean insertNotice(NoticeSaveFormDTO dto) {
		
		
		
		// 단일 파일 업로드
		//String filePath = fileDbService.saveFiles(dto.getFilePath());
		// 다중 파일 업로드
		String filePath = fileDbService.saveFiles(dto.getFiles());
		
		BoardNotice notice = BoardNotice.builder()
						.writerId(100) // 작성자 아이디 임시번호
						.title(dto.getTitle())
						.content(dto.getContent())
						.filePath(filePath) // 타입 String
						.build();
		
		return adminRepository.insertNotice(notice);
	}
	
	/**
	  * @Method Name : findNoticeById
	  * @작성일 : 2024. 3. 15.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 공지사항 글보기
	  */
	public BoardNotice findNoticeById(Integer id) {
		
		return adminRepository.findNoticeById(id);
	}
}
