package com.kis.management.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kis.management.domain.MemberVo;
import com.kis.management.service.MemberService;

@Controller
@RequestMapping(value="/member/")
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired(required = false)
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@RequestMapping(value = "adminJoin.aws", method = RequestMethod.GET)
	public String memberJoin() {
		
		return "WEB-INF/member/adminJoin";
	}
	
//	@RequestMapping(value = "memberLoginAction.aws", method = RequestMethod.POST)
//	public String memberLoginAction(
//			@RequestParam("member_id") String memberid, 
//			@RequestParam("member_pwd") String memberpwd,
//			@RequestParam("grade") String grade,
//			RedirectAttributes rttr,
//			HttpSession sesssion
//			) {
//				
//		MemberVo mv = memberService.memberLoginCheck(memberid);
//		// ����� ��й�ȣ�� �����´�
//		String path = "";
//		if (mv != null) {
//			String reservedPwd = mv.getMemberpwd();
//			
//			if(bCryptPasswordEncoder.matches(memberpwd, reservedPwd)) {
//				// System.out.println("��й�ȣ ��ġ");
//				rttr.addAttribute("midx", mv.getMidx());
//				rttr.addAttribute("memberId", mv.getMemberid());
//				rttr.addAttribute("memberName", mv.getMembername());
//				
//				// logger.info("saveUrl : " + sesssion.getAttribute("saveUrl"));
//				
//				if (sesssion.getAttribute("saveUrl") != null) {
//					path = "redirect:" + sesssion.getAttribute("saveUrl").toString();
//				} else {
//					path = "redirect:/";					
//				}
//				
//			} else {
//				rttr.addFlashAttribute("msg", "���̵�/��й�ȣ�� Ȯ�����ּ���.");
//				
//				path = "redirect:/member/memberLogin.aws";
//			}
//		} else {
//			rttr.addFlashAttribute("msg", "�ش��ϴ� ���̵� �����ϴ�.");
//			path = "redirect:/member/memberLogin.aws";
//		}		
//		return path;
//	}
	
}
