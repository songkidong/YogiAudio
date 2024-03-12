package com.project3.yogiaudio.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project3.yogiaudio.dto.admin.AdminCriteria;
import com.project3.yogiaudio.repository.entity.User;
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
	  * @Method Name : deleteUser
	  * @작성일 : 2024. 3. 12.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 유저 삭제
	  */
	public void deleteUser(Long id) {
		
		adminRepository.deleteUser(id);
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
}
