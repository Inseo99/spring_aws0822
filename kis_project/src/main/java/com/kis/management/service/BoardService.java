package com.kis.management.service;

import java.util.ArrayList;

import com.kis.management.domain.BoardVo;
import com.kis.management.domain.SearchCriteria;

public interface BoardService {
	
	public BoardVo boardSelectOne(int bidx);
	
	public int boardUpdate(BoardVo bv);
	
	public int boardDelete(int bidx);

	public int noticeTatalCount(SearchCriteria scri);

	public ArrayList<BoardVo> noticeSelectAll(SearchCriteria scri);

	public int noticeInsert(BoardVo bv);
   
}