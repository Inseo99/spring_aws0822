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
import org.springframework.security.web.header.Header;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
import com.myaws.myapp.util.UserIp;

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
	
	@Autowired(required = false)
	private UserIp userIp;
	
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
			@RequestParam("attachfile") MultipartFile attachfile,
			RedirectAttributes rttr,
			HttpServletRequest request
			) throws IOException, Exception {		
		// logger.info("boardWriteAction 들어옴");
		
		MultipartFile file = attachfile;
		String uploadedFileName = "";
		
		if (! file.getOriginalFilename().equals("")) {	// 파일업로드
			uploadedFileName = UploadFileUtiles.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes());
			
		}
		
		int midx = Integer.parseInt(request.getSession().getAttribute("midx").toString());
		String ip = userIp.getUserIp(request);
		
		bv.setUploadedFileName(uploadedFileName);
		bv.setMidx(midx);
		bv.setIp(ip);
		
		int value = boardService.boardInsert(bv);
		
		path = "redirect:/board/boardList.aws";	
		
		if (value == 2) {	// 넘어가는 화면에다가 msg가 뜨게 넘어가는 화면에다가 msg코드를 작성해야한다.
			rttr.addFlashAttribute("msg", "글이 등록되었습니다.");
			path = "redirect:/board/boardList.aws";			
		} else {			
			rttr.addFlashAttribute("msg", "입력이 잘못되었습니다.");
			path = "redirect:/board/boardWrite.aws";
		}
		
		return path;
	}
	
	@ResponseBody
	@PostMapping("/boardWriteActionReact.aws")	// 리퀘스트 맵핑에서 메소드가 포스트방식을 뜻하는 어노테이션
	public JSONObject boardWriteActionReact(@RequestBody BoardVo bv) {
		
		JSONObject js = new JSONObject();
		int value = boardService.boardInsert(bv);
		
		if(value == 2) {
			js.put("result", "success");
		} else {
			js.put("result", "fail");
		}
		
		return js; 
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
		
		ResponseEntity<byte[]> entity = null;	// byte타입 객체를 담는거
		InputStream in = null;	// 데이터를 처음에 읽어주는 역할
		
		try{
			String formatName = fileName.substring(fileName.lastIndexOf(".")+1);	// 확장자이름 추출
			MediaType mType = MediaUtils.getMediaType(formatName);	// 확장자 타입 추출
			
			HttpHeaders headers = new HttpHeaders();		
			 
			in = new FileInputStream(uploadPath+fileName);	// 파일경로 읽어드리면서 객체 생성
			
			if(mType != null){ // 지정된 타입을 다운 받을것인지 표시할것인지 선택
				
				if (down==1) {
					fileName = fileName.substring(fileName.indexOf("_")+1);
					headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
					headers.add("Content-Disposition", "attachment; filename=\""+
							new String(fileName.getBytes("UTF-8"),"ISO-8859-1")+"\"");	
					
				}else {
					headers.setContentType(mType);	// 헤더에 이미지를 담고 화면에 띄우기
				}
				
			}else{	// 지정된 타입이 아닐때 다운
				
				fileName = fileName.substring(fileName.indexOf("_")+1);
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				headers.add("Content-Disposition", "attachment; filename=\""+
						new String(fileName.getBytes("UTF-8"),"ISO-8859-1")+"\"");				
			}
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in),
					headers,
					HttpStatus.CREATED);	// 상태들을 담기
			
		}catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);	// 오류라고 리턴
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
	
	@RequestMapping(value = "boardDelete.aws", method = RequestMethod.GET)
	public String boardDelete(@RequestParam("bidx") int bidx, Model model) {
		
		model.addAttribute("bidx", bidx);
		
		path = "WEB-INF/board/boardDelete";
		
		return path;
	}
	
	@RequestMapping(value = "boardDeleteAction.aws", method = RequestMethod.POST)
	public String boardDeleteAction(
			@RequestParam("bidx") int bidx,
			@RequestParam("password") String password,
			RedirectAttributes rttr,
			HttpSession session
			) {		
		// logger.info("boardDeleteAction 들어옴");
		
		int midx = Integer.parseInt(session.getAttribute("midx").toString());
		
		int value = boardService.boardDelete(bidx, midx, password);
		
		if (value == 1) {
			rttr.addFlashAttribute("msg", "글이 삭제되었습니다.");
			path = "redirect:/board/boardList.aws";			
		} else {			
			rttr.addFlashAttribute("msg", "삭제가 실패하였습니다.");
			path = "redirect:/board/boardDelete.aws?bidx=" + bidx;
		}
		
		return path;
	}
	
	@RequestMapping(value = "boardModify.aws", method = RequestMethod.GET)
	public String boardModify(@RequestParam("bidx") int bidx, Model model) {

		BoardVo bv = boardService.boardSelectOne(bidx);
		
		model.addAttribute("bv", bv);		
		
		path = "WEB-INF/board/boardModify";
		
		return path;
	}
	
	@RequestMapping(value = "boardModifyAction.aws", method = RequestMethod.POST)
	public String boardModifyAction(
			BoardVo bv,
			@RequestParam("attachfile") MultipartFile attachfile,
			RedirectAttributes rttr,
			HttpServletRequest request,
			HttpSession session
			) throws Exception {		
		// logger.info("boardModifyAction 들어옴");
		MultipartFile file = attachfile;
		String uploadedFileName = "";
		
		if (! file.getOriginalFilename().equals("")) {	// 파일업로드
			uploadedFileName = UploadFileUtiles.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes());			
		}
		int midx = Integer.parseInt(session.getAttribute("midx").toString());
		String ip = userIp.getUserIp(request);

		bv.setMidx(midx);
		bv.setUploadedFileName(uploadedFileName);
		bv.setIp(ip);
		
		int value = boardService.boardUpdate(bv);
		
		if (value == 1) {
			rttr.addFlashAttribute("msg", "글이 수정되었습니다.");
			path = "redirect:/board/boardList.aws";			
		} else {			
			rttr.addFlashAttribute("msg", "수정이 안되었습니다.");
			path = "redirect:/board/boardModify.aws?bidx=" + bv.getBidx(); 
		}
		
		return path;
	}
	
	@RequestMapping(value = "boardReply.aws", method = RequestMethod.GET)
	public String boardReply(@RequestParam("bidx") int bidx, Model model) {

		BoardVo bv = boardService.boardSelectOne(bidx);
		
		model.addAttribute("bv", bv);		
		
		path = "WEB-INF/board/boardReply";
		
		return path;
	}
	
	@RequestMapping(value = "boardReplyAction.aws", method = RequestMethod.POST)
	public String boardReplyAction(
			BoardVo bv,
			@RequestParam("attachfile") MultipartFile attachfile,
			RedirectAttributes rttr,
			HttpServletRequest request
			) throws Exception {		
		// logger.info("boardReplyAction 들어옴");
		MultipartFile file = attachfile;
		String uploadedFileName = "";
		
		if (!file.getOriginalFilename().equals("")) {	// 파일업로드
			uploadedFileName = UploadFileUtiles.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes());			
		}
		int midx = Integer.parseInt(request.getSession().getAttribute("midx").toString());
		String ip = userIp.getUserIp(request);

		bv.setMidx(midx);
		bv.setUploadedFileName(uploadedFileName);
		bv.setIp(ip);
		
		int maxBidx = 0;
		maxBidx = boardService.boardReply(bv);
		
		if (maxBidx == 0) {
			rttr.addFlashAttribute("msg", "답변이 등록되지 않았습니다.");
			path = "redirect:/board/boardReply.aws?bidx=" + bv.getBidx(); 
		} else {			
			rttr.addFlashAttribute("msg", "글이 등록되었습니다.");
			path = "redirect:/board/boardList.aws";			
			}
		
		return path;
	}

}