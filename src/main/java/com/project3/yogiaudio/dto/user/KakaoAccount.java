package com.project3.yogiaudio.dto.user;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@JsonNaming(value = PropertyNamingStrategies.SnakeCaseStrategy.class)
public class KakaoAccount {

	private Boolean profileNicknameNeedsAgreement;
	private Boolean profileImageNeedsAgreement;
	private Profile profile;
	private Boolean emailNeedsArgreement;
	private String email;
}
