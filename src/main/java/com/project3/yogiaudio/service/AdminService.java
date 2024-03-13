package com.project3.yogiaudio.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project3.yogiaudio.dto.admin.AdminCriteria;
import com.project3.yogiaudio.repository.entity.Music;
import com.project3.yogiaudio.repository.entity.User;
import com.project3.yogiaudio.repository.entity.board.BoardNotice;
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
}
