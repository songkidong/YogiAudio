package com.project3.yogiaudio.service.playlist;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project3.yogiaudio.dto.playlist.PlayListStartDTO;
import com.project3.yogiaudio.repository.interfaces.playlist.PlaylistRepository;

/**
  * @FileName : PlaylistService.java
  * @Project : YogiAudio
  * @Date : 2024. 3. 12. 
  * @작성자 : 최장호
  * @변경이력 :
  * @프로그램 설명 : playlist 서비스
  */
@Service
public class PlaylistService {
	
	@Autowired
	private PlaylistRepository playlistRepository;
	
	public List<PlayListStartDTO> readPlaylistById(long playlistId) {
		List<PlayListStartDTO> playList = playlistRepository.findPlayListById(playlistId);
		return playList;
	}
	
	public int delete(long id) {
		return playlistRepository.delete(id);
	}
}
