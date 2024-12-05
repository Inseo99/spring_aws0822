package com.kis.management.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value="/board/")
public class BoardController {
   
   private static final Logger logger = LoggerFactory.getLogger(MemberController.class);   
   
   String path = "";
   
   @RequestMapping(value = "dashboard.aws", method = RequestMethod.GET)
   public String dashboard() {   
      
      path = "WEB-INF/board/dashboard";

      return path;
   }
}