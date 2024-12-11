package com.kis.management.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.kis.management.api.MailApi;

@Controller
@RequestMapping(value = "/email/")
public class ApiController {
	
	@Autowired
	private MailApi mailApi;
	
	@RequestMapping(value = "emailWrite.aws", method = RequestMethod.GET)
	   public String emailWrite() {		
		return "WEB-INF/email/emailWrite";
	}
	
	@RequestMapping(value = "emailWriteAction.aws", method = RequestMethod.POST)
	   public String emailWriteAction(
			   @RequestParam("subject") String subject,
			   @RequestParam("contents") String contents,
			   @RequestParam("senderemail") String senderemail,
			   @RequestParam("receiveremail") String receiveremail,
			   HttpServletRequest request, 
			   HttpServletResponse response
			   ) {		
		
		HashMap<String, Object> hm = new HashMap<String, Object>();
		hm.put("subject", subject);
		hm.put("contents", contents);
		hm.put("senderemail", senderemail);
		hm.put("receiveremail", receiveremail);
		
		
		mailApi.sendEmail(request, response, hm);
		
		String path = "redirect:/";
		
		return path;
	}
}
