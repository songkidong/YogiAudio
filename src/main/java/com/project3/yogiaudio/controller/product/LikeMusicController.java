package com.project3.yogiaudio.controller.product;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project3.yogiaudio.repository.entity.product.LikeMusic;
import com.project3.yogiaudio.service.product.LikeMusicService;

import lombok.RequiredArgsConstructor;

/**
  * @FileName : LikeMusicController.java
  * @Project : YogiAudio
  * @Date : 2024. 3. 19. 
  * @작성자 : 최장호
  * @변경이력 :
  * @프로그램 설명 : 좋아요 버튼 관련 컨트롤러
  */
@Controller
@RequiredArgsConstructor
public class LikeMusicController {
	private final LikeMusicService likeMusicService;

	/**
	  * @Method Name : deleteLikeMusic
	  * @작성일 : 2024. 3. 19.
	  * @작성자 : 최장호
	  * @변경이력 : 
	  * @Method 설명 : 좋아요 삭제
	  */
	@GetMapping("/deleteLikeMusic")
	@ResponseBody
	public int deleteLikeMusic(@RequestParam(value="userId") long userId, @RequestParam(value="musicNo") long musicNo) {
		int result = likeMusicService.delete(userId, musicNo);
		if(result == 0) {
			throw new DataAccessException("Failed to delete playlist") {};
		}
		return result;
	}
	/**
	  * @Method Name : saveLikeMusic
	  * @작성일 : 2024. 3. 19.
	  * @작성자 : 최장호
	  * @변경이력 : 
	  * @Method 설명 : 좋아요 추가
	  */
	@GetMapping("/saveLikeMusic")
	@ResponseBody
	public int saveLikeMusic(@RequestParam(value="userId") long userId, @RequestParam(value="musicNo") long musicNo) {
		int result = likeMusicService.save(userId, musicNo);
		if(result == 0) {
			throw new DataAccessException("Failed to save playlist") {};
		}
		return result;
	}
	/**
	  * @Method Name : readLikeMusic
	  * @작성일 : 2024. 3. 19.
	  * @작성자 : 최장호
	  * @변경이력 : 
	  * @Method 설명 : userId, musicNo로 좋아요 확인
	  */
	@GetMapping("/readLikeMusic")
	@ResponseBody
	public LikeMusic readLikeMusic(@RequestParam(value = "userId") long userId, @RequestParam(value = "musicNo") long musicNo) {
		LikeMusic result = likeMusicService.readByUserIdAndMusicNo(userId, musicNo);
		return result;
	}
}

