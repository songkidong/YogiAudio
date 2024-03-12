package com.project3.yogiaudio.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
		User userEntity = User.builder()
				.name(dto.getName())
				.nickname(dto.getNickname())
				.email(dto.getEmail())
				.password(passwordEncoder.encode(dto.getPassword()))
				.build();
		
		int result = userRepository.insert(userEntity);
		
		if (result != 1) {
			log.error("에러");;
		}
	}
	
	/**
	  * @Method Name : signIn
	  * @작성일 : 2024. 3. 11.
	  * @작성자 : 송기동
	  * @변경이력 : 
	  * @Method 설명 : 로그인
	  */
	public User signIn(SignUpFormDTO dto) {
		User userEntity = userRepository.selectByEmail(dto.getEmail());
		return passwordEncoder.matches(dto.getPassword(), userEntity.getPassword()) ? userEntity : null;
	}
}
