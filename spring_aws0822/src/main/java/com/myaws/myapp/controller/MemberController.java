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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
		
		// logger.info("memberJoin 들어옴");
		// logger.info("bCryptPasswordEncoder" + bCryptPasswordEncoder);
		
		return "WEB-INF/member/memberJoin";
	}
	
	@RequestMapping(value = "memberJoinAction.aws", method = RequestMethod.POST)
	public String memberJoinAction(MemberVo mv) {
		 logger.info("memberJoinAction 들어옴");		
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
		
		// logger.info("memberLogin 들어옴");	
		
		return "WEB-INF/member/memberLogin";
	}
	
	@RequestMapping(value = "memberLoginAction.aws", method = RequestMethod.POST)
	public String memberLoginAction(
			@RequestParam("memberid") String memberid, 
			@RequestParam("memberpwd") String memberpwd,
			RedirectAttributes rttr
			) {
				
		MemberVo mv = memberService.memberLoginCheck(memberid);
		// 저장된 비밀번호를 가져온다
		String path = "";
		if (mv != null) {
			String reservedPwd = mv.getMemberpwd();
			
			if(bCryptPasswordEncoder.matches(memberpwd, reservedPwd)) {
				// System.out.println("비밀번호 일치");
//				rttr.addAttribute("midx", mv.getMidx());
//				rttr.addAttribute("memberid", mv.getMemberid());
//				rttr.addAttribute("memberName", mv.getMembername());
				
				path = "redirect:/";
			} else {
				// System.out.println("비밀번호 불일치");
//				rttr.addAttribute("midx", "");
//				rttr.addAttribute("memberid", "");
//				rttr.addAttribute("memberName", "");
				rttr.addFlashAttribute("msg", "아이디/비밀번호를 확인해주세요.");
				
				path = "redirect:/member/memberLogin.aws";
			}
		} else {
//			rttr.addAttribute("midx", "");
//			rttr.addAttribute("memberid", "");
//			rttr.addAttribute("memberName", "");
			rttr.addFlashAttribute("msg", "해당하는 아이디가 없습니다.");
			path = "redirect:/member/memberLogin.aws";
		}
		
		
		// 회원정보를 세션에 담는다.
		// 로그인이 안되면 다시 로그인 페이지로 ㄱ가고
		// 로그인이 되면 메인으로 가라
		
		return path;
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
