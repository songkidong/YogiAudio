package com.project3.yogiaudio.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project3.yogiaudio.dto.admin.AdminCriteria;
import com.project3.yogiaudio.dto.admin.NoticeSaveFormDTO;
import com.project3.yogiaudio.dto.board.NoticeDTO;
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
import com.project3.yogiaudio.repository.interfaces.CancelRepository;

@Service
public class AdminService {

	@Autowired
	private AdminRepository adminRepository;
	
	@Autowired
	private CancelRepository cancelRepository;
	
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
	  * @Method Name : withdrawUser
	  * @작성일 : 2024. 3. 22.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 유저 탈퇴
	  */
	public boolean withdrawUser(Integer id) {
		
		return adminRepository.withdrawUser(id);
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
	
	/**
	  * @Method Name : updateRefund
	  * @작성일 : 2024. 3. 22.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 환불 승인
	  */
	@Transactional
	public boolean updateRefund(Integer id, Integer userId, Integer amount, Integer pNo) {
		
		// 결제 취소내역 등록하기 / user id
		cancelRepository.InsertCancel(userId, amount, pNo);
		
		// 유저 이용권 구매여부 변경하기
		cancelRepository.refundStatus(userId);
		
		return adminRepository.updateRefund(id);
	}
}
