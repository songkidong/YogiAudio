package com.project3.yogiaudio.service.product;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
}
