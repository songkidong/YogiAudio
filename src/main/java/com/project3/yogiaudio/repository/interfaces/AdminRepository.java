package com.project3.yogiaudio.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project3.yogiaudio.dto.admin.AdminCriteria;
import com.project3.yogiaudio.repository.entity.User;

@Mapper
public interface AdminRepository {
	
	// 유저목록
	public List<User> findAllUser(AdminCriteria cri);
	// 유저 카운팅
	public int countAllUser();
	// 유저삭제 / 타입 long
	public void deleteUser(Long id);

}
