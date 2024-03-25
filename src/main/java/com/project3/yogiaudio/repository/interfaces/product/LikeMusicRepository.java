package com.project3.yogiaudio.repository.interfaces.product;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project3.yogiaudio.dto.common.Criteria;
import com.project3.yogiaudio.dto.music.MusicDTO;
import com.project3.yogiaudio.repository.entity.product.LikeMusic;

/**
  * @FileName : LikeMusicRepository.java
  * @Project : YogiAudio
  * @Date : 2024. 3. 19. 
  * @작성자 : 최장호
  * @변경이력 :
  * @프로그램 설명 : like_music tb repository
  */
@Mapper
public interface LikeMusicRepository {
	public int delete(long id);
	public int insert(LikeMusic likeMusic);
	public LikeMusic findByUseIdAndMusicNo(LikeMusic likeMusic);
	public List<MusicDTO> findMusicListOrderByLikeCount(Map<String, Object> params);
	public List<MusicDTO> musicListOrderByLikeCountPaging(Criteria cri);
	//major별 음악 카운팅하기
	public Integer allCountMusicByMajor(String major);
}
