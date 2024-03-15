package com.project3.yogiaudio.repository.interfaces;

import org.apache.ibatis.annotations.Mapper;

import com.project3.yogiaudio.repository.entity.User;

@Mapper
public interface UserRepository {

	// 회원 가입
	public int insert(User user);

	// 이메일 조회
	public User findByEmail(String email);
	
	// id 조회
	public User findById(Long id);
}
