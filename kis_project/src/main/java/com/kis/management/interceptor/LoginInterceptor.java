package com.kis.management.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {
   
   @Override
   public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
         throws Exception {

      HttpSession session = request.getSession();
      
      if (session.getAttribute("midx") != null) {
         session.removeAttribute("midx");
         session.removeAttribute("member_id");
         session.removeAttribute("name");
         session.removeAttribute("grade");
         session.removeAttribute("photo");
         session.invalidate();
      }
            
      return true;
   }
   
   @Override
   public void postHandle(
         HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView)
         throws Exception {
      
      String midx = modelAndView.getModel().get("midx").toString();
      String member_id = modelAndView.getModel().get("member_id").toString();
      String name = modelAndView.getModel().get("name").toString();
      String grade = modelAndView.getModel().get("grade").toString();
      String photo = modelAndView.getModel().get("photo").toString();
      
      
      modelAndView.getModel().clear();
      
      HttpSession session = request.getSession();
      if(midx != "") {
         session.setAttribute("midx", midx);
         session.setAttribute("member_id", member_id);
         session.setAttribute("name", name);
         session.setAttribute("grade", grade);
         session.setAttribute("photo", photo);
      }      
   }
}
