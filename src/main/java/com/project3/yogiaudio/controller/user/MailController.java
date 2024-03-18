package com.project3.yogiaudio.controller.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.project3.yogiaudio.service.MailService;

@Controller
public class MailController {

	@Autowired
	private MailService mailService;
	
	@PostMapping("sendEmail/{email}")
	public void sendEmail(@PathVariable("email") String email) {
		try {
			mailService.sendCodeByEmail(email);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
}
