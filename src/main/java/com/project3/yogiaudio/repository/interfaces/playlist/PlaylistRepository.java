package com.project3.yogiaudio.repository.interfaces.playlist;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project3.yogiaudio.dto.playlist.PlayListStartDTO;

@Mapper
public interface PlaylistRepository {
	public List<PlayListStartDTO> findPlayListById(long id);
	public int delete(long id);
}
