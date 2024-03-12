package com.project3.yogiaudio.repository.entity;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Music {

	private int musicNo;
	private String musicTitle;
	private String musicSinger;
	private String musicContent;
	private String musicCompany;
	private String lyrics;
	private String startdate;
	private Timestamp regdate;
	private String filePath;
	private String fileMusic;
	private String musicSample;
	private String musicMajor;
	private String musicMinor;
	private int musicPrice;
	private String status;
	private int likeit;


	
	
}
