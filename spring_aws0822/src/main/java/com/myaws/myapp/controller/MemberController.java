package com.myaws.myapp.controller;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myaws.myapp.domain.MemberVo;
import com.myaws.myapp.service.MemberService;
import com.myaws.myapp.service.Test;

import netscape.javascript.JSObject;

@Controller
@RequestMapping(value="/member/")
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);	
	 
	@Autowired
	private MemberService memberService;
	
	@Autowired(required = false)
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@RequestMapping(value = "memberJoin.aws", method = RequestMethod.GET)
	public String memberJoin() {
		
		// logger.info("memberJoin µé¾î¿È");
		// logger.info("bCryptPasswordEncoder" + bCryptPasswordEncoder);
		
		return "WEB-INF/member/memberJoin";
	}
	
	@RequestMapping(value = "memberJoinAction.aws", method = RequestMethod.POST)
	public String memberJoinAction(MemberVo mv) {
		 logger.info("memberJoinAction µé¾î¿È");		
		// logger.info("bCryptPasswordEncoder" + bCryptPasswordEncoder);
		 
		String memberpwd_enc = bCryptPasswordEncoder.encode(mv.getMemberpwd());
		mv.setMemberpwd(memberpwd_enc);
		
		int value = memberService.memberInsert(mv);
		// logger.info("value : " + value);
		
		String path = "";
		if (value == 1) {
			path = "redirect:/";
		} else if (value == 0) {			
			path = "redirect:/member/memberJoin.aws";			
		}
		
		return path;
	}
	
	@RequestMapping(value = "memberLogin.aws", method = RequestMethod.GET)
	public String memberLogin() {
		
		// logger.info("memberLogin µé¾î¿È");	
		
		return "WEB-INF/member/memberLogin";
	}
	
	
	
	@ResponseBody
	@RequestMapping(value = "memberIdCheck.aws", method = RequestMethod.POST)
	public JSONObject memberIdCheck(@RequestParam("memberid") String memberid) {
		
		int cnt = memberService.memberIdCheck(memberid);
		
		// PrintWriter out = response.getWriter();
		// out.println("{\"cnt\" :\""+ cnt +"\"}");
		
		JSONObject obj = new JSONObject();
		obj.put("cnt", cnt);
		
		return obj;
	}
	
	

}
