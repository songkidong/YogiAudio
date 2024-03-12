package com.project3.yogiaudio.repository.entity;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User {

	private long id;
	private String name;
	private String nickname;
	private String email;
	private String password;
	private String filePath;
	private Timestamp createdAt;
	private String role;
	private String deleteYn;
	private Timestamp deleteAt;
}
