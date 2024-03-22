package com.project3.yogiaudio.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project3.yogiaudio.dto.admin.AdminCriteria;
import com.project3.yogiaudio.dto.common.Criteria;
import com.project3.yogiaudio.dto.user.HistoryListDTO;
import com.project3.yogiaudio.dto.user.LikeMusicListDTO;
import com.project3.yogiaudio.repository.entity.History;
import com.project3.yogiaudio.repository.entity.User;
import com.project3.yogiaudio.repository.entity.product.LikeMusic;

@Mapper
public interface UserRepository {

	// 회원 가입
	public int insert(User user);
	
	// 회원 수정
	public int updateById(User user);
	
	// 회원 탈퇴
	public int deleteById(User user);

	// 이메일 조회
	public User findByEmail(String email);
	
	//아이디 조회
	public User findById(@Param(value ="id") long id);
	
	// id 조회
	public User findById(Long id);
	
	// 결제 내역 조회
	public List<HistoryListDTO> findAllHistory(@Param("cri") AdminCriteria cri, @Param("userId") Long userId);
	public int countAllHistory(Long userId);

	// 좋아요 내역 조회
	public List<LikeMusicListDTO> findAllLikeMusic(@Param("cri") AdminCriteria cri, @Param("userId") Long userId);
	public int countAllLikeMusic(Long userId);
}
