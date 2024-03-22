package com.project3.yogiaudio.service.playlist;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project3.yogiaudio.repository.entity.playlist.PlaylistOrder;
import com.project3.yogiaudio.repository.interfaces.playlist.PlaylistOrderRepository;

/**
  * @FileName : PlaylistOrderService.java
  * @Project : YogiAudio
  * @Date : 2024. 3. 12. 
  * @작성자 : 최장호
  * @변경이력 :
  * @프로그램 설명 : 플레이리스트_order service
  */
@Service
public class PlaylistOrderService {
	
	@Autowired
	private PlaylistOrderRepository playlistOrderRepository;
	
	/**
	  * @Method Name : addList
	  * @작성일 : 2024. 3. 16.
	  * @작성자 : 최장호
	  * @변경이력 : 
	  * @Method 설명 : playlist_order 테이블에 저장하는 메소드
	  * @param inputMusic 
	  * @return
	  */
	@Transactional
	public int addList(PlaylistOrder inputMusic) {
		return playlistOrderRepository.insert(inputMusic);
	}
	
	/**
	  * @Method Name : readByplaylistId
	  * @작성일 : 2024. 3. 16.
	  * @작성자 : 최장호
	  * @변경이력 : 
	  * @Method 설명 : playlistId에 해당하는 playlist_order 마지막 정보 조회하는 메소드(1건)
	  * @param playlistId
	  * @return
	  */
	public PlaylistOrder readLastByplaylistId(long playlistId) {
		PlaylistOrder playlistOrder = playlistOrderRepository.findLastByPlaylistId(playlistId);
		return playlistOrder;
	}

	/**
	  * @Method Name : deleteByPlaylistIdAndIndex
	  * @작성일 : 2024. 3. 17.
	  * @작성자 : 최장호
	  * @변경이력 : 
	  * @Method 설명 : playlist, index로 id 얻어서 delete
	  * @param deleteParams
	  * @return
	  */
	@Transactional
	public int deleteByIndex(Map<String, Object> deleteParams) {
		PlaylistOrder playlistOrder = playlistOrderRepository.findByPlaylistIdAndIndex(deleteParams);
		if(playlistOrder == null) {
			throw new DataAccessException("Failed to find playlistOrder") {};
		}
		int result = playlistOrderRepository.deleteById(playlistOrder.getId());
		if(result == 0) {
			throw new DataAccessException("Failed to delete playlistOrder") {};
		}
		return result;
	}
}
