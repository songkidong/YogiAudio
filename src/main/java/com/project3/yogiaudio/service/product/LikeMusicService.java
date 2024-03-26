package com.project3.yogiaudio.service.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.project3.yogiaudio.dto.common.Criteria;
import com.project3.yogiaudio.dto.common.PageReq;
import com.project3.yogiaudio.dto.common.PageRes;
import com.project3.yogiaudio.dto.music.MusicDTO;
import com.project3.yogiaudio.repository.entity.product.LikeMusic;
import com.project3.yogiaudio.repository.interfaces.product.LikeMusicRepository;

import lombok.RequiredArgsConstructor;

/**
  * @FileName : LikeMusicService.java
  * @Project : YogiAudio
  * @Date : 2024. 3. 19. 
  * @작성자 : 최장호
  * @변경이력 :
  * @프로그램 설명 : LikeMusicService
  */
@Service
@RequiredArgsConstructor
public class LikeMusicService {
	private final LikeMusicRepository likeMusicRepository;
	
	/**
	  * @param musicNo 
	 * @param userId 
	 * @Method Name : delete
	  * @작성일 : 2024. 3. 19.
	  * @작성자 : 최장호
	  * @변경이력 : 
	  * @Method 설명 : 삭제
	  */
	public int delete(long userId, long musicNo) {
		LikeMusic likeMusic = readByUserIdAndMusicNo(userId, musicNo);
		int result = 0;
		if(likeMusic != null) {
			result = likeMusicRepository.delete(likeMusic.getId());
		}
		return result;
	}
	/**
	  * @Method Name : insert
	  * @작성일 : 2024. 3. 19.
	  * @작성자 : 최장호
	  * @변경이력 : 
	  * @Method 설명 : 저장
	  */
	public int save(long userId, long musicNo) {
		LikeMusic likeMusic = LikeMusic.builder().userId(userId).musicNo(musicNo).build();
		return likeMusicRepository.insert(likeMusic);
	}
	/**
	  * @Method Name : readByUserIdAndMusicNo
	  * @작성일 : 2024. 3. 19.
	  * @작성자 : 최장호
	  * @변경이력 : 
	  * @Method 설명 : UserId, MusicNo 로 like_music tb 조회
	  */
	public LikeMusic readByUserIdAndMusicNo(long userId, long musicNo) {
		LikeMusic likeMusic = LikeMusic.builder().userId(userId).musicNo(musicNo).build();
		return likeMusicRepository.findByUseIdAndMusicNo(likeMusic);
	}
	
	/**
	  * @Method Name : readMusicListOrderByLikeCount
	  * @작성일 : 2024. 3. 24.
	  * @작성자 : 최장호
	  * @변경이력 : 
	  * @Method 설명 : 좋아요 순으로 음악 TOP10가져오기
	  * @return
	  */
	public List<MusicDTO> readMusicListOrderByLikeCount(String major, Integer limit) {
		Map<String, Object> params = new HashMap<>();
		params.put("major", major);
		params.put("limit", limit);
		return likeMusicRepository.findMusicListOrderByLikeCount(params);
	}
	/**
	  * @Method Name : musicListOrderByLikeCountPaging
	  * @작성일 : 2024. 3. 25.
	  * @작성자 : 최장호
	  * @변경이력 : 
	  * @Method 설명 :
	  * @param Criteria cri
	  * @return
	  */
	public List<MusicDTO> musicListOrderByLikeCountPaging(Criteria cri) {
		List<MusicDTO> getMusicListOderByLikeCount = likeMusicRepository.musicListOrderByLikeCountPaging(cri);
		return getMusicListOderByLikeCount;
	}
	
	/**
	  * @Method Name : allCountMusicByMajor
	  * @작성일 : 2024. 3. 25.
	  * @작성자 : 최장호
	  * @변경이력 : 
	  * @Method 설명 : major 별 전체 음악 개수
	  * @param major
	  * @return
	  */
	public Integer allCountMusicByMajor(String major) {
		if(major != null && major.isBlank()) {
			major = null;
		}
		 return likeMusicRepository.allCountMusicByMajor(major);
	}
	
}
