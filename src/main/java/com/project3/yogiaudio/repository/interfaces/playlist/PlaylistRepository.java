package com.project3.yogiaudio.repository.interfaces.playlist;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project3.yogiaudio.dto.playlist.PlayListStartDTO;
import com.project3.yogiaudio.repository.entity.playlist.Playlist;

@Mapper
public interface PlaylistRepository {
	public List<PlayListStartDTO> findPlayListById(long id);
	public int delete(long id);
	public int insert(Playlist input);
	public Playlist findByUserIdAndPlaylistName(Map<String, Object> params);
}
