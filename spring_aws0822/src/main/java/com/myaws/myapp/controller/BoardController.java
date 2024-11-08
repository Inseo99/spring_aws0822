package com.myaws.myapp.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.InetAddress;
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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myaws.myapp.domain.BoardVo;
import com.myaws.myapp.domain.PageMaker;
import com.myaws.myapp.domain.SearchCriteria;
import com.myaws.myapp.service.BoardService;
import com.myaws.myapp.util.MediaUtils;
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
		// logger.info("board_List ����");
		
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
			@RequestParam("attachfile") MultipartFile attachfile,
			RedirectAttributes rttr,
			HttpServletRequest request
			) throws IOException, Exception {		
		// logger.info("boardWriteAction ����");
		
		MultipartFile file = attachfile;
		String uploadedFileName = "";
		
		if (! file.getOriginalFilename().equals("")) {	// ���Ͼ��ε�
			uploadedFileName = UploadFileUtiles.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes());
			
		}
		
		int midx = Integer.parseInt(request.getSession().getAttribute("midx").toString());
		String ip = getUserIp(request);
		
		bv.setUploadedFileName(uploadedFileName);
		bv.setMidx(midx);
		bv.setIp(ip);
		
		int value = boardService.boardInsert(bv);
		
		path = "redirect:/board/boardList.aws";	
		
		if (value == 2) {	// �Ѿ�� ȭ�鿡�ٰ� msg�� �߰� �Ѿ�� ȭ�鿡�ٰ� msg�ڵ带 �ۼ��ؾ��Ѵ�.
			rttr.addFlashAttribute("msg", "���� ��ϵǾ����ϴ�..");
			path = "redirect:/board/boardList.aws";			
		} else {			
			rttr.addFlashAttribute("msg", "�Է��� �߸��Ǿ����ϴ�.");
			path = "redirect:/board/boardWrite.aws";
		}
		
		return path;
	}
	
	@RequestMapping(value = "boardContents.aws", method = RequestMethod.GET)
	public String boardContents(
			@RequestParam("bidx") int bidx,
			Model model) {	
		
		boardService.boardViewCntUpdate(bidx);
		BoardVo bv = boardService.boardSelectOne(bidx);
		
		model.addAttribute("bv", bv);
		
		path = "WEB-INF/board/boardContents";

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
	
	@ResponseBody
	@RequestMapping(value = "boardRecom.aws", method = RequestMethod.GET)
	public JSONObject boardRecom(@RequestParam("bidx") int bidx) {	
		
		int value = boardService.boardRecomUpdate(bidx);
		
		JSONObject js = new JSONObject();
		js.put("recom", value);
		
		return js;
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