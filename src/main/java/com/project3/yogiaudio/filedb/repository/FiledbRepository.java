package com.project3.yogiaudio.filedb.repository;

import org.apache.ibatis.annotations.Mapper;

import com.project3.yogiaudio.filedb.entity.Filedb;

@Mapper
public interface FiledbRepository {
	
	public int saveFiledb(Filedb filedb);
	public Filedb findByUuid(String uuid);
	
	
}