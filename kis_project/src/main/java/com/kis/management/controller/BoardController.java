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

      return "WEB-INF/board/dashboard";
   }
   
   @RequestMapping(value = "noticeList.aws", method = RequestMethod.GET)
   public String noticeList() {   

      return "WEB-INF/board/noticeList";
   }
   
   @RequestMapping(value = "communityList.aws", method = RequestMethod.GET)
   public String communityList() {   

      return "WEB-INF/board/dashcommunityListboard";
   }
   
   @RequestMapping(value = "weekWorkList.aws", method = RequestMethod.GET)
   public String weekWorkList() {   

      return "WEB-INF/board/weekWorkList";
   }
   
   @RequestMapping(value = "weekWorkWrite.aws", method = RequestMethod.GET)
   public String weekWorkWrite() {   

      return "WEB-INF/board/weekWorkWrite";
   }
   
   @RequestMapping(value = "monthWorkList.aws", method = RequestMethod.GET)
   public String monthWorkList() {   

      return "WEB-INF/board/monthWorkList";
   }
   
   @RequestMapping(value = "monthWorkWrite.aws", method = RequestMethod.GET)
   public String monthWorkWrite() {   

      return "WEB-INF/board/monthWorkWrite";
   }
   
   @RequestMapping(value = "leaveList.aws", method = RequestMethod.GET)
   public String leaveList() {   

      return "WEB-INF/board/leaveList";
   }
   
   @RequestMapping(value = "leaveWrite.aws", method = RequestMethod.GET)
   public String leaveWrite() {   

	  return "WEB-INF/board/leaveWrite";
   }
   
   @RequestMapping(value = "businessTripList.aws", method = RequestMethod.GET)
   public String businessTripList() {   

      return "WEB-INF/board/businessTripList";
   }
   
   @RequestMapping(value = "businessTripWrite.aws", method = RequestMethod.GET)
   public String businessTripWrite() {   

      return "WEB-INF/board/businessTripWrite";
   }
   
   @RequestMapping(value = "calendar.aws", method = RequestMethod.GET)
   public String calendar() {   

      return "WEB-INF/board/calendar";
   }
}