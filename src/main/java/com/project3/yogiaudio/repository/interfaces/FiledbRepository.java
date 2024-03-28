package com.project3.yogiaudio.repository.interfaces;

import org.apache.ibatis.annotations.Mapper;

import com.project3.yogiaudio.repository.entity.Filedb;

@Mapper
public interface FiledbRepository {
	
	public int saveFiledb(Filedb filedb);
	public Filedb findByUuid(String uuid);
	public int deleteByUuid(String uuid);
	
	
}