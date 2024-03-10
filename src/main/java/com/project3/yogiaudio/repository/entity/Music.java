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

	private Integer musicNo;
	private String musicTitle;
	private String musicSinger;
	private String musicContent;
	private String startdate;
	private Timestamp regdate;
	private String filePath;
	private Integer musicMajor;
	private Integer musicMinor;
	private Integer musicPrice;
	
	
}
