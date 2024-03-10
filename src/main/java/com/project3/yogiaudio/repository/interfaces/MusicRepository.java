package com.project3.yogiaudio.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project3.yogiaudio.product.dto.MusicDTO;

@Mapper
public interface MusicRepository {

	//국내음악리스트출력하기
	public List<MusicDTO> domesticListAll() throws Exception;
	

	
	
	
	
	
}
