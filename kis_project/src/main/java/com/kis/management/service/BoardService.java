package com.kis.management.service;

import java.util.ArrayList;

import com.kis.management.domain.BoardVo;
import com.kis.management.domain.SearchCriteria;
import com.kis.management.domain.WorkBoardVo;

public interface BoardService {
	
	public BoardVo boardSelectOne(int bidx);
	
	public int boardUpdate(BoardVo bv);
	
	public int boardDelete(int bidx);

	public int noticeTatalCount(SearchCriteria scri);

	public ArrayList<BoardVo> noticeSelectAll(SearchCriteria scri);

	public int noticeInsert(BoardVo bv);
	
	public ArrayList<BoardVo> noticeSelectdashboard();

	public int communityTatalCount(SearchCriteria scri);

	public ArrayList<BoardVo> communitySelectAll(SearchCriteria scri);

	public int communityInsert(BoardVo bv);

	public int boardViewCntUpdate(int bidx);

	public int communityRecomUpdate(int bidx);

	public int communityReply(BoardVo bv);

	public ArrayList<BoardVo> commynitySelectdashboard();
	
	public ArrayList<WorkBoardVo> workSelectdashboard();

	public int weekWorkTatalCount(SearchCriteria scri);

	public ArrayList<WorkBoardVo> weekWorkSelectAll(SearchCriteria scri);

	public int monthWorkTatalCount(SearchCriteria scri);

	public ArrayList<WorkBoardVo> monthWorkSelectAll(SearchCriteria scri);
   
}