package com.project3.yogiaudio.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project3.yogiaudio.dto.common.Criteria;
import com.project3.yogiaudio.dto.music.MusicDTO;



@Mapper
public interface MusicRepository {

	//국내음악리스트출력하기
	public List<MusicDTO> domesticListAll(Criteria cri) throws Exception;
	
	//국내음악리스트 카운팅하기
	public int countdomesticListAll() throws Exception;
	
	//국내음악리스트(조건) 출력하기
	public List<MusicDTO> searchDmusicList(Criteria cri) throws Exception;
	
	//국내음악리스트(조건) 카운팅하기
	public int countsearchDmusicList(Criteria cri) throws Exception;
	
	//국외음악리스트출력하기
	public List<MusicDTO> aboardListAll(Criteria cri) throws Exception;
	
	//국외음악리스트 카운팅하기
	public int countaboardListAll() throws Exception;
	
	//국외음악리스트(조건) 출력하기
	public List<MusicDTO> searchAmusicList(Criteria cri) throws Exception;
	
	//국외음악리스트(조건) 카운팅하기
	public int countsearchAmusicList(Criteria cri) throws Exception;
	
	//국내음악디테일 
	public MusicDTO domesticDetail(@Param(value = "musicno") int musicno, @Param(value = "musicmajor") String musicmajor);
	
	//국외음악디테일
	public MusicDTO aboardDetail(@Param(value = "musicno") int musicno, @Param(value = "musicmajor") String musicmajor);

	//앨범자켓바꾸기
	public Integer albumUpdate(MusicDTO dto);
	
	//음원등록하기
	public Integer musicUpdate(MusicDTO dto);
	
	
	//최신순으로출력하기
	public List<MusicDTO> newMusicList(Criteria cri) throws Exception;
	
	
	//좋아요순으로출력하기
	public List<MusicDTO> likeMusicList(Criteria cri) throws Exception;
	
	
	//국외최신순
	public List<MusicDTO> newAboardMusicList() throws Exception;

	//좋아요업데이트하기
	public int likeit(MusicDTO dto,@Param(value = "musicno") int musicno, @Param(value = "musicmajor") String musicmajor);
	
	
	
	
}
