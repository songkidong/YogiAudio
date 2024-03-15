package com.project3.yogiaudio.dto.user;

import lombok.Data;

@Data
public class Profile {

	private String nickname;
	private String thumbnailImageUrl;
	private String profileImageUrl;
	private Boolean isDefaultImage;


}
