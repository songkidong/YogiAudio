package com.project3.yogiaudio.service.playlist;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	
	public int addList(PlaylistOrder inputMusic) {
		return playlistOrderRepository.insert(inputMusic);
	}
}
