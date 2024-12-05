package com.kis.management.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kis.management.domain.DepartmentVo;
import com.kis.management.domain.PageMaker;
import com.kis.management.domain.SearchCriteria;
import com.kis.management.service.DepartmentService;

@Controller
@RequestMapping(value="/department/")
public class DepartmentController {
   
   private static final Logger logger = LoggerFactory.getLogger(DepartmentController.class);   
   
   String path = "";
   
   @Autowired
   private DepartmentService departmentService;
   
   @Autowired(required = false)
   private PageMaker pm;
   
   @RequestMapping(value = "departmentList.aws", method = RequestMethod.GET)
   public String departmentList(
		   SearchCriteria scri, 
		   Model model) {   
      
	  int cnt = departmentService.departmentTatalCount(scri);	   
      
	  pm.setScri(scri);		
	  pm.setTotalCount(cnt);
	  
	  ArrayList<DepartmentVo> dlist = departmentService.departmentSelectAll(scri);
	  
	  model.addAttribute("dlist", dlist);
	  model.addAttribute("pm", pm);

      return "WEB-INF/department/departmentList";
   }
   
   @RequestMapping(value = "departmentRegister.aws", method = RequestMethod.GET)
   public String departmentRegister() {   
      return "WEB-INF/department/departmentRegister";
   }
   
   @RequestMapping(value = "departmentRegisterAction.aws", method = RequestMethod.POST)
   public String departmentRegisterAction(
		   DepartmentVo dv,
		   RedirectAttributes rttr
		   ) {   
	  
	  int value = departmentService.departmentInsert(dv);
	  
	  String path = "";
	   if (value == 1) {
		  rttr.addFlashAttribute("msg", "부서가 등록되었습니다.");
		  path = "redirect:/department/departmentList.aws";
	   } else if (value == 0) {         
		  path = "redirect:/department/departmentRegister.aws";         
	   }
     
	   return path;
   }
   
   @RequestMapping(value = "departmentModify.aws", method = RequestMethod.GET)
   public String departmentModify(
		   @RequestParam("didx") int didx, 
		   Model model
		   ) { 
	  
	  DepartmentVo dv = departmentService.departmentSelectOne(didx);
		
	  model.addAttribute("dv", dv);
	  model.addAttribute("didx", didx);
	   
      return "WEB-INF/department/departmentModify";
   }
   
   @RequestMapping(value = "departmentModifyAction.aws", method = RequestMethod.POST)
   public String departmentModifyAction(
		   @RequestParam("didx") int didx,
		   DepartmentVo dv,
		   RedirectAttributes rttr
		   ) {   
	  
	  int value = departmentService.departmentUpdate(dv);
	  
	  String path = "";
	   if (value == 1) {
		  rttr.addFlashAttribute("msg", "수정되었습니다.");
		  path = "redirect:/department/departmentList.aws";
	   } else if (value == 0) {         
		  path = "redirect:/department/departmentModify.aws?didx=" + didx;;         
	   }
     
	   return path;
   }
   
   @RequestMapping(value = "departmentDeleteAction.aws", method = RequestMethod.POST)
	public String departmentDeleteAction(
			@RequestParam("didx") int didx,
			RedirectAttributes rttr
			) {		
		
		int value = departmentService.departmentDelete(didx);
		
		String path = "";
		if (value == 1) {
			rttr.addFlashAttribute("msg", "글이 삭제되었습니다.");
			path = "redirect:/department/departmentList.aws";		
		} else {			
			path = "redirect:/department/departmentModify.aws?didx=" + didx;
		}
		
		return path;
	}
}




















