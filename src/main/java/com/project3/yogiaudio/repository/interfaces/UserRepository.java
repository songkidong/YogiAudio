package com.project3.yogiaudio.repository.interfaces;

import org.apache.ibatis.annotations.Mapper;

import com.project3.yogiaudio.repository.entity.User;

@Mapper
public interface UserRepository {

	// 회원 가입
	public int insert(User user);
}
