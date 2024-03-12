package com.project3.yogiaudio.dto.user;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

import lombok.Data;

@Data
@JsonNaming(value = PropertyNamingStrategies.SnakeCaseStrategy.class)
public class OAuthToken {

	private String accessToken;
	private String tokenType;
	private String refreshToken;
	private Integer expiresIn;
	private String scope;
	private Integer refreshTokenExpiresIn;
}
