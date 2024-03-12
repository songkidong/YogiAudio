package com.project3.yogiaudio.dto.user;

import lombok.Data;

@Data
public class KakaoAccount {

	private Boolean profileNicknameNeedsAgreement;
	private Boolean profileImageNeedsAgreement;
	private Profile profile;


}
