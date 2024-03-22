package com.project3.yogiaudio.controller.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project3.yogiaudio.service.MailService;

@Controller
public class MailController {

	@Autowired
	private MailService mailService;

	@PostMapping("/sendMail/{email}")
	public ResponseEntity<HttpStatus> sendMail(@PathVariable("email") String email) {

		mailService.mailSend(email);

		return ResponseEntity.ok(HttpStatus.OK);
	}

	@GetMapping("/sendNumber")
	public ResponseEntity<Boolean> matchNumber(@RequestParam("number") String number) {
		boolean isMatched = mailService.confirmCodeByEmail(number);
		return ResponseEntity.ok(isMatched);
	}
}
