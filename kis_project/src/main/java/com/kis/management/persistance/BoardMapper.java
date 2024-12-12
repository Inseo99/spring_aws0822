package com.kis.management.persistance;

import java.util.ArrayList;
import java.util.HashMap;

import com.kis.management.domain.BoardVo;
import com.kis.management.domain.SearchCriteria;
import com.kis.management.domain.WorkBoardVo;

public interface BoardMapper {
	
	public BoardVo boardSelectOne(int bidx);
	
	public int boardInsert(BoardVo bv);	
	
	public int boardUpdate(BoardVo bv);
	
	public int boardDelete(int bidx);
	
	public int boardViewCntUpdate(int bidx);

	public int noticeTatalCount(SearchCriteria scri);

	public ArrayList<BoardVo> noticeSelectAll(HashMap<String, Object> hm);

	public ArrayList<BoardVo> noticeSelectdashboard();
	
	public int communityTatalCount(SearchCriteria scri);

	public ArrayList<BoardVo> communitySelectAll(HashMap<String, Object> hm);

	public int communityOriginbidxUpdate(int bidx);

	public void communityRecomUpdate(BoardVo bv);

	public void communityReplyUpdate(BoardVo bv);

	public void communityReplyInsert(BoardVo bv);

	public ArrayList<BoardVo> commynitySelectdashboard();
	
	public ArrayList<WorkBoardVo> workSelectdashboard();

	public int weekWorkTatalCount(SearchCriteria scri);

	public ArrayList<WorkBoardVo> weekWorkSelectAll(HashMap<String, Object> hm);

	public int monthWorkTatalCount(SearchCriteria scri);

	public ArrayList<WorkBoardVo> monthWorkSelectAll(HashMap<String, Object> hm);
}
