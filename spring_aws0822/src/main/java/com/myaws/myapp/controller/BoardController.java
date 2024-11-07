package com.myaws.myapp.controller;

import java.io.IOException;
import java.net.InetAddress;
import java.util.ArrayList;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myaws.myapp.domain.BoardVo;
import com.myaws.myapp.domain.PageMaker;
import com.myaws.myapp.domain.SearchCriteria;
import com.myaws.myapp.service.BoardService;
import com.myaws.myapp.util.UploadFileUtiles;

@Controller
@RequestMapping(value="/board/")
public class BoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);	
	 
	@Autowired(required = false)
	private BoardService boardService;
	
	@Autowired(required = false)
	private PageMaker pm;
	
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	String path = "";
	
	@RequestMapping(value = "boardList.aws", method = RequestMethod.GET)
	public String boardList(SearchCriteria scri, Model model) {		
		// logger.info("board_List 들어옴");
		
		int cnt = boardService.boardTatalCount(scri);
		
		pm.setScri(scri);		
		pm.setTotalCount(cnt);
		
		ArrayList<BoardVo> blist = boardService.boardSelectAll(scri);
		
		model.addAttribute("blist", blist);
		model.addAttribute("pm", pm);
		
		path = "WEB-INF/board/boardList";
		
		return path;
	}
	
	@RequestMapping(value = "boardWrite.aws", method = RequestMethod.GET)
	public String boardWrite() {		
		path = "WEB-INF/board/boardWrite";
		
		return path;
	}
	
	@RequestMapping(value = "boardWriteAction.aws", method = RequestMethod.POST)
	public String boardWriteAction(
			BoardVo bv,
			@RequestParam("filename") MultipartFile filename,
			RedirectAttributes rttr,
			HttpServletRequest request
			) throws IOException, Exception {		
		// logger.info("boardWriteAction 들어옴");
		
		MultipartFile file = filename;
		String uploadedFileName = "";
		
		if (! file.getOriginalFilename().equals("")) {	// 파일업로드
			uploadedFileName = UploadFileUtiles.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes());
			
		}
		
		int midx = Integer.parseInt(request.getSession().getAttribute("midx").toString());
		String ip = getUserIp(request);
		
		bv.setUploadedFileName(uploadedFileName);
		bv.setMidx(midx);
		bv.setIp(ip);
		
		int value = boardService.boardInsert(bv);
		
		path = "redirect:/board/boardList.aws";	
		
		if (value == 2) {	// 넘어가는 화면에다가 msg가 뜨게 넘어가는 화면에다가 msg코드를 작성해야한다.
			rttr.addFlashAttribute("msg", "글이 등록되었습니다..");
			path = "redirect:/board/boardList.aws";			
		} else {			
			rttr.addFlashAttribute("msg", "입력이 잘못되었습니다.");
			path = "redirect:/board/boardWrite.aws";
		}
		
		return path;
	}
	
	@RequestMapping(value = "boardContents.aws", method = RequestMethod.GET)
	public String boardContents(
			@RequestParam("bidx") int bidx,
			Model model) {	
		
		BoardVo bv = boardService.boardViewCntUpdate(bidx);
		
		model.addAttribute("bv", bv);
		
		path = "WEB-INF/board/boardContents";

		return path;
	}
	
	public String getUserIp(HttpServletRequest request) throws Exception {
		
        String ip = null;
        // HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();

        ip = request.getHeader("X-Forwarded-For");
        
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("Proxy-Client-IP"); 
        } 
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("WL-Proxy-Client-IP"); 
        } 
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("HTTP_CLIENT_IP"); 
        } 
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("HTTP_X_FORWARDED_FOR"); 
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("X-Real-IP"); 
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("X-RealIP"); 
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("REMOTE_ADDR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getRemoteAddr(); 
        }
		
        if (ip.equals("0:0:0:0:0:0:0:1") || ip.equals("127.0.0.1")) {
        	InetAddress address = InetAddress.getLocalHost();
        	ip = address.getHostAddress();
        	
        }        
		return ip;
	}	
}