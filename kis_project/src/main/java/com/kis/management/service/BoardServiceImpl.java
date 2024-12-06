package com.kis.management.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kis.management.domain.BoardVo;
import com.kis.management.domain.SearchCriteria;
import com.kis.management.persistance.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService{
   
	private BoardMapper bm;

	@Autowired
	   public BoardServiceImpl(SqlSession sqlSession) {
	      this.bm = sqlSession.getMapper(BoardMapper.class);      
	   }
	
	@Override
	public BoardVo boardSelectOne(int bidx) {
		BoardVo bv = bm.boardSelectOne(bidx);
		return bv;
	}
	
	@Override
	public int boardUpdate(BoardVo bv) {
		int value = bm.boardUpdate(bv);
		return value;
	}
	
	@Override
	public int boardDelete(int bidx) {
		int value = bm.boardDelete(bidx);
		return value;
	}
	
	@Override
	public int noticeTatalCount(SearchCriteria scri) {
		int cnt = bm.noticeTatalCount(scri);
		return cnt;
	}

	@Override
	public ArrayList<BoardVo> noticeSelectAll(SearchCriteria scri) {
		
		HashMap<String, Object> hm = new HashMap<String, Object>(); // 알아보기
		hm.put("startPageNum", (scri.getPage()-1) * scri.getPerPageNum());
		hm.put("perPageNum", scri.getPerPageNum());
		hm.put("searchType", scri.getSearchType());
		hm.put("keyword", scri.getKeyword());
		
		ArrayList<BoardVo> blist = bm.noticeSelectAll(hm);
		return blist;
	}

	@Override
	public int noticeInsert(BoardVo bv) {
		int value = bm.boardInsert(bv);
		return value;
	}

	
}