package com.project3.yogiaudio.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project3.yogiaudio.dto.SignUpFormDTO;
import com.project3.yogiaudio.repository.entity.User;
import com.project3.yogiaudio.repository.interfaces.UserRepository;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class UserService {

	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
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
}
