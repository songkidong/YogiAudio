package com.project3.yogiaudio.dto.user;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class LikeMusicListDTO {
	private String filePath;
	private int musicNo;
	private String musicTitle;
	private String musicSinger;
	private Timestamp createdAt;
}
