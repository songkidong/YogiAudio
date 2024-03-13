package com.project3.yogiaudio.service;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import com.project3.yogiaudio.dto.user.SignUpFormDTO;
import com.project3.yogiaudio.repository.entity.User;
import com.project3.yogiaudio.repository.interfaces.UserRepository;

import lombok.extern.slf4j.Slf4j;

/**
  * @FileName : UserService.java
  * @Project : yogiaudio
  * @Date : 2024. 3. 11. 
  * @작성자 : 송기동
  * @변경이력 :
  * @프로그램 설명 : 유저 서비스
  */
@Service
@Slf4j
public class UserService {

	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	/**
	  * @Method Name : createUser
	  * @작성일 : 2024. 3. 11.
	  * @작성자 : 송기동
	  * @변경이력 : 
	  * @Method 설명 : 회원가입
	  */
	@Transactional
	public void createUser(SignUpFormDTO dto) {
	    log.info("createUser 메서드 호출됨");

	    // 이미 등록된 이메일인지 확인
	    User existingUser = userRepository.findByEmail(dto.getEmail());
	    if (existingUser != null) {
	        log.warn("이미 등록된 이메일입니다: {}", dto.getEmail());
	        // 이미 등록된 이메일인 경우 기존 사용자 반환
	        return;
	    }

	    // 새로운 사용자 생성
	    User newUser = buildUserEntity(dto);
	    userRepository.insert(newUser);
	    log.info("새로운 사용자 생성: {}", newUser);
	}



	private User buildUserEntity(SignUpFormDTO dto) {
	    return User.builder()
	            .name(dto.getName())
	            .nickname(dto.getNickname())
	            .email(dto.getEmail())
	            .password(passwordEncoder.encode(dto.getPassword()))
	            .build();
	}
	
	/**
	  * @Method Name : signIn
	  * @작성일 : 2024. 3. 11.
	  * @작성자 : 송기동
	  * @변경이력 : 
	  * @Method 설명 : 로그인
	  */
	public User signIn(SignUpFormDTO dto) {
		User userEntity = userRepository.findByEmail(dto.getEmail());
		return passwordEncoder.matches(dto.getPassword(), userEntity.getPassword()) ? userEntity : null;
	}
	
	
	
	//아이디로 유저조회
	public User findById(@Param(value ="id") long id) {
		return userRepository.findById(id);
	}
	
	
	
	
	
}
