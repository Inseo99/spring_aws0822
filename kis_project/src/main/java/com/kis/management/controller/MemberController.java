package com.kis.management.controller;

import javax.servlet.http.HttpSession;

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

import com.kis.management.domain.MemberVo;
import com.kis.management.service.MemberService;
import com.kis.management.controller.MemberController;

@Controller
@RequestMapping(value="/member/")
public class MemberController {
   
   private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
   
   @Autowired
   private MemberService memberService;
   
   @Autowired(required = false)
   private BCryptPasswordEncoder bCryptPasswordEncoder;
   
   @ResponseBody
   @RequestMapping(value = "memberIdCheck.aws", method = RequestMethod.POST)
   public JSONObject memberIdCheck(@RequestParam("member_id") String member_id) {
	   
	   int cnt = memberService.memberIdCheck(member_id);
	   
	   JSONObject obj = new JSONObject();
	   obj.put("cnt", cnt);
	   
	   return obj;
   }
   
   @RequestMapping(value = "adminJoin.aws", method = RequestMethod.GET)
   public String memberJoin() {
      return "WEB-INF/member/adminJoin";
   }
   
   @RequestMapping(value = "adminJoinAction.aws", method = RequestMethod.POST)
   public String memberJoinAction(
		   MemberVo mv, 
		   RedirectAttributes rttr) {
      // logger.info("adminJoinAction 들어옴");      
      // logger.info("bCryptPasswordEncoder" + bCryptPasswordEncoder);
       
      String memberpwd_enc = bCryptPasswordEncoder.encode(mv.getMember_pwd());
      mv.setMember_pwd(memberpwd_enc);
      
      int value = memberService.memberInsert(mv);
      
      String path = "";
      if (value == 1) {
    	 rttr.addFlashAttribute("msg", "회원가입이 되었습니다.");
         path = "redirect:/";
      } else if (value == 0) {         
         path = "redirect:/member/adminJoin.aws";         
      }
      
      return path;
   }
   
   
   @RequestMapping(value = "memberLoginAction.aws", method = RequestMethod.POST)
   public String memberLoginAction(
         @RequestParam("grade") String grade,
         @RequestParam("member_id") String member_id, 
         @RequestParam("member_pwd") String member_pwd, 
         RedirectAttributes rttr,
         HttpSession session
         ) {
      
      MemberVo mv = memberService.memberLoginCheck(member_id, grade);
      
      String path = "";
      if (mv != null) {
         String reservedPwd = mv.getMember_pwd();
         
         if(bCryptPasswordEncoder.matches(member_pwd, reservedPwd)) {
            rttr.addAttribute("midx", mv.getMidx());
            rttr.addAttribute("grade", mv.getGrade());
            rttr.addAttribute("member_id", mv.getMember_id());
            rttr.addAttribute("name", mv.getName());
            
            if ("admin".equals(grade)) {
            	rttr.addFlashAttribute("msg", "로그인 되었습니다.");
            	path = "redirect:/board/adminDashboard.aws";                                          
            } else if ("employee".equals(grade)) {
               path = "redirect:/board/employeeDashboard.aws";
            }
            
         } else {
        	 rttr.addAttribute("midx", "");
             rttr.addAttribute("grade", "");
             rttr.addAttribute("member_id", "");
             rttr.addAttribute("name", "");
             session.setAttribute("msg", "아이디/비밀번호를 확인해주세요.");
            
             path = "redirect:/";
         }
      } else {
    	  rttr.addAttribute("midx", "");
          rttr.addAttribute("grade", "");
          rttr.addAttribute("member_id", "");
          rttr.addAttribute("name", "");
          session.setAttribute("msg", "해당하는 아이디가 없습니다.");
          path = "redirect:/";
      }      
      return path;
   }
   
   
}
