package com.kis.management.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kis.management.domain.MemberVo;
import com.kis.management.service.MemberService;
import com.kis.management.util.UploadFileUtiles;
import com.kis.management.util.MediaUtils;
import com.kis.management.domain.PageMaker;
import com.kis.management.domain.SearchCriteria;
import com.kis.management.controller.MemberController;

@Controller
@RequestMapping(value="/member/")
public class MemberController {
   
   private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
   
   @Autowired
   private MemberService memberService;
   
   @Autowired(required = false)
	private PageMaker pm;
   
   @Resource(name = "uploadPath")
   private String uploadPath;
   
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
      // logger.info("adminJoinAction ����");      
      // logger.info("bCryptPasswordEncoder" + bCryptPasswordEncoder);
       
      String memberpwd_enc = bCryptPasswordEncoder.encode(mv.getMember_pwd());
      mv.setMember_pwd(memberpwd_enc);
      
      int value = memberService.adminInsert(mv);
      
      String path = "";
      if (value == 1) {
    	 rttr.addFlashAttribute("msg", "ȸ�������� �Ǿ����ϴ�.");
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
         HttpSession session,
         Model model
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
            rttr.addAttribute("photo", mv.getPhoto());
            
            session.setAttribute("mv", mv);
            rttr.addFlashAttribute("msg", "�α��� �Ǿ����ϴ�.");
            
            path = "redirect:/board/dashboard.aws";         
          
         } else {
        	 rttr.addAttribute("midx", "");
             rttr.addAttribute("grade", "");
             rttr.addAttribute("member_id", "");
             rttr.addAttribute("name", "");
             rttr.addAttribute("photo", "");
             session.setAttribute("msg", "���̵�/��й�ȣ�� Ȯ�����ּ���.");
            
             path = "redirect:/";
         }
      } else {
    	  rttr.addAttribute("midx", "");
          rttr.addAttribute("grade", "");
          rttr.addAttribute("member_id", "");
          rttr.addAttribute("name", "");
          rttr.addAttribute("photo", "");
          session.setAttribute("msg", "�ش��ϴ� ���̵� �����ϴ�.");
          path = "redirect:/";
      }      
      return path;
   }
   
   @RequestMapping(value = "memberLogout.aws", method = RequestMethod.GET)
	public String memberLogout(HttpSession sesssion) {		
		// logger.info("memberLogout ����");
		
		sesssion.removeAttribute("midx");
		sesssion.removeAttribute("grade");
		sesssion.removeAttribute("name");
		sesssion.removeAttribute("member_id");
		sesssion.invalidate();
		
		return "redirect:/";
	}
   
   @RequestMapping(value = "employeeRegister.aws", method = RequestMethod.GET)
   public String employeeRegister() {
      return "WEB-INF/member/employeeRegister";
   }
   
   @RequestMapping(value = "employeeRegisterAction.aws", method = RequestMethod.POST)
   public String employeeRegisterAction(
		   MemberVo mv, 
		   @RequestParam("attachfile") MultipartFile attachfile,
		   RedirectAttributes rttr
		   ) throws IOException, Exception {
	   // logger.info("employeeRegisterAction ����");
	   MultipartFile file = attachfile;
	   String uploadedFileName = "";
		
	   if (! file.getOriginalFilename().equals("")) {	// ���Ͼ��ε�
		   uploadedFileName = UploadFileUtiles.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes());			
	   }
	  
	   String memberpwd_enc = bCryptPasswordEncoder.encode(mv.getMember_pwd());
	   
	   mv.setUploadedFileName(uploadedFileName);
	   mv.setMember_pwd(memberpwd_enc);
      
	   int value = memberService.employeeInsert(mv);
      
	   String path = "";
	   if (value == 1) {
		  rttr.addFlashAttribute("msg", "������ ��ϵǾ����ϴ�.");
		  path = "redirect:/member/memberList.aws";
	   } else if (value == 0) {         
		  rttr.addFlashAttribute("msg", "������ ��ϵ��� �ʾҽ��ϴ�.");
		  path = "redirect:/member/employeeRegister.aws";         
	   }
      
	   return path;
   }
   
   @RequestMapping(value = "information.aws", method = RequestMethod.GET)
	public String information(
			@RequestParam("midx") int midx, 
			Model model
			) {
	   
	   MemberVo mv = memberService.memberSelectOne(midx);
		
	   model.addAttribute("mv", mv);
	   model.addAttribute("midx", midx);
		
	   return "WEB-INF/member/information";
	}
   
   @RequestMapping(value = "informationAction.aws", method = RequestMethod.POST)
	public String information(
			MemberVo mv,
			@RequestParam("midx") int midx,
			RedirectAttributes rttr
			) throws Exception {		
		
		int value = memberService.informationUpdate(mv);
		
		String path = "";
		if (value == 1) {
			rttr.addFlashAttribute("msg", "���� �����Ǿ����ϴ�.");
			path = "redirect:/board/dashboard.aws";			
		} else {
			path = "redirect:/member/information.aws?midx=" + midx; 
		}
		
		return path;
	}
   
   @RequestMapping(value = "memberList.aws", method = RequestMethod.GET)
	public String memberList(SearchCriteria scri, Model model) {
		
	   	int cnt = memberService.memeberTatalCount(scri);
		
		pm.setScri(scri);		
		pm.setTotalCount(cnt);
	   
		ArrayList<MemberVo> mlist = memberService.memberSelectAll(scri);
		
		model.addAttribute("mlist", mlist);
		model.addAttribute("pm", pm);
		
		return "WEB-INF/member/memberList";
	}
   
   @RequestMapping(value = "memberModify.aws", method = RequestMethod.GET)
	public String memberModify(
			@RequestParam("midx") int midx, 
			Model model
			) {
	   
	   MemberVo mv = memberService.memberSelectOne(midx);
		
	   model.addAttribute("mv", mv);
	   model.addAttribute("midx", midx);
		
	   return "WEB-INF/member/memberModify";
	}
   
   @RequestMapping(value = "memberModifyAction.aws", method = RequestMethod.POST)
	public String memberModifyAction(
			MemberVo mv,
			@RequestParam("midx") int midx,
			@RequestParam("attachfile") MultipartFile attachfile,
			RedirectAttributes rttr
			) throws Exception {		
		// logger.info("boardModifyAction ����");
		MultipartFile file = attachfile;
		String uploadedFileName = "";
		
		if (! file.getOriginalFilename().equals("")) {	// ���Ͼ��ε�
			uploadedFileName = UploadFileUtiles.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes());			
		}

		String memberpwd_enc = bCryptPasswordEncoder.encode(mv.getMember_pwd());
		
		mv.setUploadedFileName(uploadedFileName);
		mv.setMember_pwd(memberpwd_enc);
		
		int value = memberService.memberUpdate(mv);
		// System.out.println("value: " + value);
		
		String path = "";
		if (value == 1) {
			rttr.addFlashAttribute("msg", "���� �����Ǿ����ϴ�.");
			path = "redirect:/member/memberList.aws";			
		} else {
			path = "redirect:/member/memberModify.aws?midx=" + midx; 
		}
		
		return path;
	}
   
   @RequestMapping(value = "memberDeleteAction.aws", method = RequestMethod.POST)
	public String memberDeleteAction(
			@RequestParam("midx") int midx,
			RedirectAttributes rttr
			) {		
		
		int value = memberService.memberDelete(midx);
		
		String path = "";
		if (value == 1) {
			rttr.addFlashAttribute("msg", "���� �����Ǿ����ϴ�.");
			path = "redirect:/member/memberList.aws";		
		} else {			
			path = "redirect:/member/memberModify.aws?midx=" + midx;
		}
		
		return path;
	}
   
   @RequestMapping(value = "/displayFile.aws", method = RequestMethod.GET)
	public ResponseEntity<byte[]> displayFile(
			@RequestParam("fileName") String fileName,
			@RequestParam(value = "down", defaultValue = "0") int down
			) {
		
		ResponseEntity<byte[]> entity = null;	// byteŸ�� ��ü�� ��°�
		InputStream in = null;	// �����͸� ó���� �о��ִ� ����
		
		try{
			String formatName = fileName.substring(fileName.lastIndexOf(".")+1);	// Ȯ�����̸� ����
			MediaType mType = MediaUtils.getMediaType(formatName);	// Ȯ���� Ÿ�� ����
			
			HttpHeaders headers = new HttpHeaders();		
			 
			in = new FileInputStream(uploadPath+fileName);	// ���ϰ�� �о�帮�鼭 ��ü ����
			
			if(mType != null){ // ������ Ÿ���� �ٿ� ���������� ǥ���Ұ����� ����
				
				if (down==1) {
					fileName = fileName.substring(fileName.indexOf("_")+1);
					headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
					headers.add("Content-Disposition", "attachment; filename=\""+
							new String(fileName.getBytes("UTF-8"),"ISO-8859-1")+"\"");	
					
				}else {
					headers.setContentType(mType);	// ����� �̹����� ��� ȭ�鿡 ����
				}
				
			}else{	// ������ Ÿ���� �ƴҶ� �ٿ�
				
				fileName = fileName.substring(fileName.indexOf("_")+1);
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				headers.add("Content-Disposition", "attachment; filename=\""+
						new String(fileName.getBytes("UTF-8"),"ISO-8859-1")+"\"");				
			}
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in),
					headers,
					HttpStatus.CREATED);	// ���µ��� ���
			
		}catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);	// ������� ����
		}finally{
			try {
				in.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return entity;
	}
}
