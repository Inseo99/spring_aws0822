package com.kis.management.persistance;

import java.util.ArrayList;
import java.util.HashMap;

import com.kis.management.domain.BoardVo;
import com.kis.management.domain.SearchCriteria;

public interface BoardMapper {
	
	public BoardVo boardSelectOne(int bidx);
	
	public int boardInsert(BoardVo bv);	
	
	public int boardUpdate(BoardVo bv);
	
	public int boardDelete(int bidx);

	public int noticeTatalCount(SearchCriteria scri);

	public ArrayList<BoardVo> noticeSelectAll(HashMap<String, Object> hm);	
	
}
