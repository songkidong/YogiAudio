package com.project3.yogiaudio.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project3.yogiaudio.product.dto.Criteria;
import com.project3.yogiaudio.product.dto.MusicDTO;

@Mapper
public interface MusicRepository {

	//국내음악리스트출력하기
	public List<MusicDTO> domesticListAll(Criteria cri) throws Exception;
	
	//국내음악리스트 카운팅하기
	public int countdomesticListAll() throws Exception;
	
	//국외음악리스트출력하기
	public List<MusicDTO> aboardListAll(Criteria cri) throws Exception;
	
	//국외음악리스트 카운팅하기
	public int countaboardListAll() throws Exception;
	
	//국내음악디테일 
	public MusicDTO domesticDetail(@Param(value = "musicno") int musicno, @Param(value = "musicmajor") String musicmajor);
	
	//국외음악디테일
	public MusicDTO aboardDetail(int musicno, String musicmajor);

	//앨범자켓바꾸기
	public Integer albumUpdate(MusicDTO dto);
	
	
	
	
}
