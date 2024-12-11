package com.kis.management.api;

import java.util.HashMap;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.kis.management.util.MailHandler;

@Service
public class MailApi {
	
	@Autowired(required = false)
	private JavaMailSender mailSender;
	
	public void sendEmail(HttpServletRequest request, 
			HttpServletResponse response,
			HashMap<String, Object> hm
			) {
		
		String subject = hm.get("subject").toString();
		String contents = hm.get("contents").toString();
		String senderemail = hm.get("senderemail").toString();
		String receiveremail = hm.get("receiveremail").toString();
		
		try {
			MailHandler mailHandler = new MailHandler(mailSender);
			mailHandler.setSubject(subject);
			mailHandler.setText(contents, true);
			mailHandler.setFrom(senderemail);
			mailHandler.setTo(receiveremail);
			mailHandler.send();
			
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
