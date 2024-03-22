package com.project3.yogiaudio.dto.user;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class GoogleProfile {

	private String sub;
	private String name;
	private String given_name;
	private String family_name;
	private String picture;
	private String email;
	private String email_verified;
}
