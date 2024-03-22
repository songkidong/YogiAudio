package com.project3.yogiaudio.repository.interfaces.playlist;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project3.yogiaudio.repository.entity.playlist.PlaylistOrder;

@Mapper
public interface PlaylistOrderRepository {
	public int insert(PlaylistOrder playlistOrder);
	public PlaylistOrder findLastByPlaylistId(long playlistId);
	public PlaylistOrder findByPlaylistIdAndIndex(Map<String, Object> params);
	public int deleteById(long id);
}
