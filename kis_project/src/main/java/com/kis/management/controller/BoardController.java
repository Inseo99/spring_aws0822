package com.kis.management.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

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

import com.kis.management.domain.BoardVo;
import com.kis.management.domain.PageMaker;
import com.kis.management.domain.SearchCriteria;
import com.kis.management.domain.WorkBoardVo;
import com.kis.management.service.BoardService;
import com.kis.management.util.MediaUtils;
import com.kis.management.util.UploadFileUtiles;
import com.kis.management.util.UserIp;

@Controller
@RequestMapping(value="/board/")
public class BoardController {
   
   private static final Logger logger = LoggerFactory.getLogger(BoardController.class);   
   
   String path = "";
   
   @Autowired
   private BoardService boardService;
   
   @Autowired(required = false)
   private PageMaker pm;
   
   @Resource(name = "uploadPath")
   private String uploadPath;
   
   @Autowired(required = false)
	private UserIp userIp;
   
   @RequestMapping(value = "dashboard.aws", method = RequestMethod.GET)
   public String dashboard(Model model) {   
	   
	  ArrayList<BoardVo> nlist = boardService.noticeSelectdashboard();
	  ArrayList<BoardVo> clist = boardService.commynitySelectdashboard();
	  ArrayList<WorkBoardVo> wlist = boardService.workSelectdashboard();
		  
	  model.addAttribute("nlist", nlist);
	  model.addAttribute("clist", clist);
	  model.addAttribute("wlist", wlist);
	   
      return "WEB-INF/board/dashboard";
   }
   
   @RequestMapping(value = "noticeList.aws", method = RequestMethod.GET)
   public String noticeList(SearchCriteria scri, Model model) {   
	  
	  int cnt = boardService.noticeTatalCount(scri);
	  
	  pm.setScri(scri);		
	  pm.setTotalCount(cnt);
	  
	  ArrayList<BoardVo> blist = boardService.noticeSelectAll(scri);
	  
	  model.addAttribute("blist", blist);
	  model.addAttribute("pm", pm);
	   
      return "WEB-INF/board/noticeList";
   }
   
   @RequestMapping(value = "noticeWrite.aws", method = RequestMethod.GET)
   public String noticeWrite() {   
      return "WEB-INF/board/noticeWrite";
   }
   
   @RequestMapping(value = "noticeWriteAction.aws", method = RequestMethod.POST)
   public String noticeWriteAction(
		   BoardVo bv,
		   @RequestParam("attachfile") MultipartFile attachfile,
		   RedirectAttributes rttr,
		   HttpServletRequest request
		   ) throws IOException, Exception { 
	   
	  MultipartFile file = attachfile;
	  String uploadedFileName = "";
		
	  if (! file.getOriginalFilename().equals("")) {	// ���Ͼ��ε�
		  uploadedFileName = UploadFileUtiles.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes());			
	  }
	  
	  int midx = Integer.parseInt(request.getSession().getAttribute("midx").toString());
	  String ip = userIp.getUserIp(request);
		
	  bv.setUploadedFileName(uploadedFileName);
	  bv.setMidx(midx);
	  bv.setIp(ip);
	  
	  int value = boardService.noticeInsert(bv);
	  
	  if (value == 1) {	// �Ѿ�� ȭ�鿡�ٰ� msg�� �߰� �Ѿ�� ȭ�鿡�ٰ� msg�ڵ带 �ۼ��ؾ��Ѵ�.
			rttr.addFlashAttribute("msg", "���� ��ϵǾ����ϴ�.");
			path = "redirect:/board/noticeList.aws";			
		} else {			
			rttr.addFlashAttribute("msg", "�Է��� �߸��Ǿ����ϴ�.");
			path = "redirect:/board/noticeWrite.aws";
		}
		
      return path;
   }
   
   @RequestMapping(value = "noticeContents.aws", method = RequestMethod.GET)
   public String noticeContents(
		   @RequestParam("bidx") int bidx, 
		   Model model
		   ) {   
	   
	  boardService.boardViewCntUpdate(bidx);
	  BoardVo bv = boardService.boardSelectOne(bidx);
	  
	  model.addAttribute("bv", bv);
	  model.addAttribute("bidx", bidx);
	  
      return "WEB-INF/board/noticeContents";
   }
   
   @RequestMapping(value = "noticeModify.aws", method = RequestMethod.GET)
   public String noticeModify(
		   @RequestParam("bidx") int bidx, 
		   Model model
		   ) {   
	   
	   BoardVo bv = boardService.boardSelectOne(bidx);
	   
	   model.addAttribute("bv", bv);
	   model.addAttribute("bidx", bidx);
	   
	   return "WEB-INF/board/noticeModify";
   }
   
   @RequestMapping(value = "noticeModifyAction.aws", method = RequestMethod.POST)
   public String noticeModifyAction(
		   BoardVo bv,
		   @RequestParam("bidx") int bidx,
		   @RequestParam("attachfile") MultipartFile attachfile,
		   RedirectAttributes rttr,
		   HttpServletRequest request
		   ) throws IOException, Exception { 
	   
	  MultipartFile file = attachfile;
	  String uploadedFileName = "";
		
	  if (! file.getOriginalFilename().equals("")) {	// ���Ͼ��ε�
		  uploadedFileName = UploadFileUtiles.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes());			
	  }
	  
	  int midx = Integer.parseInt(request.getSession().getAttribute("midx").toString());
	  String ip = userIp.getUserIp(request);
		
	  bv.setUploadedFileName(uploadedFileName);
	  bv.setMidx(midx);
	  bv.setIp(ip);
	  
	  int value = boardService.boardUpdate(bv);
	  
	  if (value == 1) {	// �Ѿ�� ȭ�鿡�ٰ� msg�� �߰� �Ѿ�� ȭ�鿡�ٰ� msg�ڵ带 �ۼ��ؾ��Ѵ�.
			rttr.addFlashAttribute("msg", "���� �����Ǿ����ϴ�.");
			path = "redirect:/board/noticeList.aws";			
		} else {			
			rttr.addFlashAttribute("msg", "�Է��� �߸��Ǿ����ϴ�.");
			path = "redirect:/board/noticeModify.aws?bidx=" + bidx;
		}
		
      return path;
   }
   
   @RequestMapping(value = "noticeDeleteAction.aws", method = RequestMethod.POST)
   public String noticeDeleteAction(
		   @RequestParam("bidx") int bidx,
		   RedirectAttributes rttr
		   ) { 
	  
	  int value = boardService.boardDelete(bidx);
	  
	  if (value == 1) {
		  rttr.addFlashAttribute("msg", "���� �����Ǿ����ϴ�.");
		  path = "redirect:/board/noticeList.aws";		
	  } else {			
		  path = "redirect:/board/noticeContents.aws?bidx=" + bidx;
	  }
		
		
      return path;
   }
   
   @RequestMapping(value = "communityList.aws", method = RequestMethod.GET)
   public String communityList(
		   SearchCriteria scri, 
		   Model model
		   ) {   
	
	  int cnt = boardService.communityTatalCount(scri);
		  
	  pm.setScri(scri);		
	  pm.setTotalCount(cnt);
		  
	  ArrayList<BoardVo> blist = boardService.communitySelectAll(scri);
		  
	  model.addAttribute("blist", blist);
	  model.addAttribute("pm", pm);
		   
      return "WEB-INF/board/communityList";
   }
   
   @RequestMapping(value = "communityWrite.aws", method = RequestMethod.GET)
   public String communityWrite() {   
      return "WEB-INF/board/communityWrite";
   }
   
   @RequestMapping(value = "communityWriteAction.aws", method = RequestMethod.POST)
   public String communityWriteAction(
		   BoardVo bv,
		   @RequestParam("attachfile") MultipartFile attachfile,
		   RedirectAttributes rttr,
		   HttpServletRequest request
		   ) throws IOException, Exception { 
	   
	  MultipartFile file = attachfile;
	  String uploadedFileName = "";
		
	  if (! file.getOriginalFilename().equals("")) {	// ���Ͼ��ε�
		  uploadedFileName = UploadFileUtiles.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes());			
	  }
	  
	  int midx = Integer.parseInt(request.getSession().getAttribute("midx").toString());
	  String ip = userIp.getUserIp(request);
		
	  bv.setUploadedFileName(uploadedFileName);
	  bv.setMidx(midx);
	  bv.setIp(ip);
	  
	  int value = boardService.communityInsert(bv);
	  
	  if (value == 2) {	// �Ѿ�� ȭ�鿡�ٰ� msg�� �߰� �Ѿ�� ȭ�鿡�ٰ� msg�ڵ带 �ۼ��ؾ��Ѵ�.
			rttr.addFlashAttribute("msg", "���� ��ϵǾ����ϴ�.");
			path = "redirect:/board/communityList.aws";			
		} else {			
			rttr.addFlashAttribute("msg", "�Է��� �߸��Ǿ����ϴ�.");
			path = "redirect:/board/communityWrite.aws";
		}
		
      return path;
   }
   
   @RequestMapping(value = "communityContents.aws", method = RequestMethod.GET)
   public String communityContents(
		   @RequestParam("bidx") int bidx, 
		   Model model
		   ) {   
	   
	  boardService.boardViewCntUpdate(bidx);
	  BoardVo bv = boardService.boardSelectOne(bidx);
	  
	  model.addAttribute("bv", bv);
	  model.addAttribute("bidx", bidx);
	  
      return "WEB-INF/board/communityContents";
   }
   
   @ResponseBody
	@RequestMapping(value = "communityRecom.aws", method = RequestMethod.GET)
	public JSONObject communityRecom(@RequestParam("bidx") int bidx) {	
		
		int value = boardService.communityRecomUpdate(bidx);
		
		JSONObject js = new JSONObject();
		js.put("recom", value);
		
		return js;
	}
   
   @RequestMapping(value = "communityModify.aws", method = RequestMethod.GET)
   public String communityModify(
		   @RequestParam("bidx") int bidx, 
		   Model model
		   ) {   
	   
	   BoardVo bv = boardService.boardSelectOne(bidx);
	   
	   model.addAttribute("bv", bv);
	   model.addAttribute("bidx", bidx);
	   
	   return "WEB-INF/board/communityModify";
   }
   
   @RequestMapping(value = "communityModifyAction.aws", method = RequestMethod.POST)
   public String communityModifyAction(
		   BoardVo bv,
		   @RequestParam("bidx") int bidx,
		   @RequestParam("attachfile") MultipartFile attachfile,
		   RedirectAttributes rttr,
		   HttpServletRequest request
		   ) throws IOException, Exception { 
	   
	  MultipartFile file = attachfile;
	  String uploadedFileName = "";
		
	  if (! file.getOriginalFilename().equals("")) {	// ���Ͼ��ε�
		  uploadedFileName = UploadFileUtiles.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes());			
	  }
	  
	  int midx = Integer.parseInt(request.getSession().getAttribute("midx").toString());
	  String ip = userIp.getUserIp(request);
		
	  bv.setUploadedFileName(uploadedFileName);
	  bv.setMidx(midx);
	  bv.setIp(ip);
	  
	  int value = boardService.boardUpdate(bv);
	  
	  if (value == 1) {	// �Ѿ�� ȭ�鿡�ٰ� msg�� �߰� �Ѿ�� ȭ�鿡�ٰ� msg�ڵ带 �ۼ��ؾ��Ѵ�.
			rttr.addFlashAttribute("msg", "���� �����Ǿ����ϴ�.");
			path = "redirect:/board/communityList.aws";			
		} else {			
			rttr.addFlashAttribute("msg", "�Է��� �߸��Ǿ����ϴ�.");
			path = "redirect:/board/communityModify.aws?bidx=" + bidx;
		}
		
      return path;
   }
   
   @RequestMapping(value = "communityDeleteAction.aws", method = RequestMethod.POST)
   public String communityDeleteAction(
		   @RequestParam("bidx") int bidx,
		   RedirectAttributes rttr
		   ) { 
	  
	  int value = boardService.boardDelete(bidx);
	  
	  if (value == 1) {
		  rttr.addFlashAttribute("msg", "���� �����Ǿ����ϴ�.");
		  path = "redirect:/board/communityList.aws";		
	  } else {			
		  path = "redirect:/board/communityContents.aws?bidx=" + bidx;
	  }
	  
      return path;
   }
   
   @RequestMapping(value = "communityReply.aws", method = RequestMethod.GET)
	public String communityReply(@RequestParam("bidx") int bidx, Model model) {

		BoardVo bv = boardService.boardSelectOne(bidx);
		
		model.addAttribute("bv", bv);
		
		return "WEB-INF/board/communityReply";
	}
   
   @RequestMapping(value = "communityReplyAction.aws", method = RequestMethod.POST)
	public String communityReplyAction(
			BoardVo bv,
			@RequestParam("attachfile") MultipartFile attachfile,
			RedirectAttributes rttr,
			HttpServletRequest request
			) throws Exception {		
		// logger.info("boardReplyAction ����");
		MultipartFile file = attachfile;
		String uploadedFileName = "";
		
		if (!file.getOriginalFilename().equals("")) {	// ���Ͼ��ε�
			uploadedFileName = UploadFileUtiles.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes());			
		}
		int midx = Integer.parseInt(request.getSession().getAttribute("midx").toString());
		String ip = userIp.getUserIp(request);

		bv.setMidx(midx);
		bv.setUploadedFileName(uploadedFileName);
		bv.setIp(ip);
		
		int maxBidx = 0;
		maxBidx = boardService.communityReply(bv);
		
		if (maxBidx == 0) {
			rttr.addFlashAttribute("msg", "�亯�� ��ϵ��� �ʾҽ��ϴ�.");
			path = "redirect:/board/communityReply.aws?bidx=" + bv.getBidx(); 
		} else {			
			rttr.addFlashAttribute("msg", "���� ��ϵǾ����ϴ�.");
			path = "redirect:/board/communityList.aws";			
			}
		
		return path;
	}
   
   @RequestMapping(value = "weekWorkList.aws", method = RequestMethod.GET)
   public String weekWorkList(
		   SearchCriteria scri, 
		   Model model
		   ) {   
	
	  int cnt = boardService.weekWorkTatalCount(scri);
		  
	  pm.setScri(scri);		
	  pm.setTotalCount(cnt);
		  
	  ArrayList<WorkBoardVo> blist = boardService.weekWorkSelectAll(scri);
		  
	  model.addAttribute("blist", blist);
	  model.addAttribute("pm", pm);
	  
      return "WEB-INF/board/weekWorkList";
   }
   
   @RequestMapping(value = "weekWorkWrite.aws", method = RequestMethod.GET)
   public String weekWorkWrite() {   

      return "WEB-INF/board/weekWorkWrite";
   }
   
   @RequestMapping(value = "monthWorkList.aws", method = RequestMethod.GET)
   public String monthWorkList(
		   SearchCriteria scri, 
		   Model model
		   ) {   
	
	  int cnt = boardService.monthWorkTatalCount(scri);
		  
	  pm.setScri(scri);		
	  pm.setTotalCount(cnt);
		  
	  ArrayList<WorkBoardVo> blist = boardService.monthWorkSelectAll(scri);
		  
	  model.addAttribute("blist", blist);
	  model.addAttribute("pm", pm);  

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