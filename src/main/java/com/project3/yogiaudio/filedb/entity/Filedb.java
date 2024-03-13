package com.project3.yogiaudio.filedb.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Filedb {
	
	private String uuid;
	private String originalFileName;
	private byte[] fileData;

	
	
	
}