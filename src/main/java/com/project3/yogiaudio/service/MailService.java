package com.project3.yogiaudio.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class MailService {

	@Autowired
	private JavaMailSender javaMailSender;

	// 인증 번호
	private String generatedCode = tempPassword();

	// 메일 보내는 메소드
	public void mailSend(String email) {

		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(email);
		message.setSubject("YogiAudio");
		message.setText("YogiAudio 인증번호 : " + generatedCode);
		message.setFrom("ehdzl5464@naver.com");
		message.setReplyTo("ehdzl5464@naver.com");
		javaMailSender.send(message);
	}

	// 랜덤함수로 인증번호 만들기
	public String tempPassword() {
		char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
				'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };
		String password = "";
		// 문자 배열 길이의 값을 랜덤으로 10개를 뽑아 구문을 작성함
		int j = 0;
		for (int i = 0; i < 10; i++) {
			j = (int) (charSet.length * Math.random());
			password += charSet[j];
		}
		return password;
	}

	// 인증 번호 확인
	public Boolean confirmCodeByEmail(String number) {

		if (number.equals(generatedCode)) {
			return true;
		} else {
			return false;
		}
	}
}
