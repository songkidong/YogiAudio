package com.project3.yogiaudio.repository.interfaces;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project3.yogiaudio.repository.entity.User;

@Mapper
public interface UserRepository {

	// 회원 가입
	public int insert(User user);
	
	// 회원 수정
	public int updateById(User user);

	// 이메일 조회
	public User findByEmail(String email);
	//아이디 조회
	public User findById(@Param(value ="id") long id);
	// id 조회
	public User findById(Long id);
}
