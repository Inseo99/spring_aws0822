package com.myaws.myapp.controller;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.myaws.myapp.domain.BoardVo;
import com.myaws.myapp.domain.PageMaker;
import com.myaws.myapp.domain.SearchCriteria;
import com.myaws.myapp.service.BoardService;

@Controller
@RequestMapping(value="/board/")
public class BoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);	
	 
	@Autowired(required = false)
	private BoardService boardService;
	
	@Autowired(required = false)
	private PageMaker pm;
	
	@RequestMapping(value = "boardList.aws", method = RequestMethod.GET)
	public String boardList(SearchCriteria scri, Model model) {		
		// logger.info("board_List µé¾î¿È");
		
		int cnt = boardService.boardTatalCount(scri);
		
		pm.setScri(scri);		
		pm.setTotalCount(cnt);
		
		ArrayList<BoardVo> blist = boardService.boardSelectAll(scri);
		
		model.addAttribute("blist", blist);
		model.addAttribute("pm", pm);
		
		String path="WEB-INF/board/boardList";	
		
		return path;
	}
}