package com.project3.yogiaudio.dto.user;

import lombok.Data;

@Data
public class KakaoProfile {
    private Long id;
    private String connectedAt;
    private Properties properties;
    private KakaoAccount kakaoAccount;
}
