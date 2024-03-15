package com.project3.yogiaudio.repository.interfaces.playlist;

import org.apache.ibatis.annotations.Mapper;

import com.project3.yogiaudio.repository.entity.playlist.PlaylistOrder;

@Mapper
public interface PlaylistOrderRepository {
	public int insert(PlaylistOrder playlistOrder);
}
