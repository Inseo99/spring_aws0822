package com.myaws.myapp.controller;

import java.net.InetAddress;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myaws.myapp.domain.CommentVo;
import com.myaws.myapp.service.CommentService;
import com.myaws.myapp.util.UserIp;

@RestController	// ResponseBody가 있는거와 같은거
@RequestMapping(value="/comment")
public class CommentController {

	@Autowired(required = false)
	private CommentService commentService;
	
	@Autowired(required = false)
	private UserIp userIp;
	
	@RequestMapping(value = "/{bidx}/commentList.aws")
	public JSONObject commentList(
			@PathVariable("bidx") int bidx
			) {
		
		JSONObject js = new JSONObject();
		
		ArrayList<CommentVo> clist = commentService.commentSelectAll(bidx);
		js.put("clist", clist);
		
		return js;
	}
	
	@RequestMapping(value = "/commentWriteAction.aws", method = RequestMethod.POST)
	public JSONObject commentWriteAction(CommentVo cv, HttpServletRequest request) throws Exception {
		JSONObject js = new JSONObject();
		
		String cip = userIp.getUserIp(request);
		cv.setCip(cip);
		
		int value = commentService.commentInsert(cv);
		
		js.put("value", value);
		
		return js;
	}
	
	@RequestMapping(value = "/{cidx}/commentDeleteAction.aws", method = RequestMethod.GET)
	public JSONObject commentDeleteAction(
			CommentVo cv,
			@PathVariable("cidx") int cidx,
			HttpServletRequest request
			) throws Exception {
		JSONObject js = new JSONObject();
		
		int midx = Integer.parseInt(request.getSession().getAttribute("midx").toString());
		String cip = userIp.getUserIp(request);
		
		cv.setCidx(cidx);
		cv.setMidx(midx);
		cv.setCip(cip);
		
		int value = commentService.commentDelete(cv);
		
		js.put("value", value);
		
		return js;
	}
}
