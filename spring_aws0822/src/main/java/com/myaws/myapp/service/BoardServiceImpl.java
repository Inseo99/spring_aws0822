package com.myaws.myapp.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myaws.myapp.domain.BoardVo;
import com.myaws.myapp.domain.SearchCriteria;
import com.myaws.myapp.persistance.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService{

	private BoardMapper bm;
	
	@Autowired(required = false) // 정확한의미 찾아보기
	public BoardServiceImpl(SqlSession sqlSession) {
		this.bm = sqlSession.getMapper(BoardMapper.class);
		
	}
	
	@Override
	public ArrayList<BoardVo> boardSelectAll(SearchCriteria scri) {
		
		HashMap<String, Object> hm = new HashMap<String, Object>(); // 알아보기
		hm.put("startPageNum", (scri.getPage()-1) * scri.getPerPageNum());
		hm.put("perPageNum", scri.getPerPageNum());
		hm.put("searchType", scri.getSearchType());
		hm.put("keyword", scri.getKeyword());
		
		ArrayList<BoardVo> blist = bm.boardSelectAll(hm);
		return blist;
	}

	@Override
	public int boardTatalCount(SearchCriteria scri) {						
		int cnt = bm.boardTatalCount(scri);		
		return cnt;
	}

	@Override
//	@Transactional
	public int boardInsert(BoardVo bv) {
		int value = bm.boardInsert(bv);
		int maxBidx = bv.getBidx();		
		int value2 = bm.boardOriginbidxUpdate(maxBidx);

		return value + value2;
	}

	@Override
	public BoardVo boardSelectOne(int bidx) {
		BoardVo bv = bm.boardSelectOne(bidx);
		return bv;
	}

	@Override
	public int boardViewCntUpdate(int bidx) {
		int value = bm.boardViewCntUpdate(bidx);
		return value;
	}

	@Override
	public int boardRecomUpdate(int bidx) {
		BoardVo bv = new BoardVo();
		
		bv.setBidx(bidx);
		bm.boardRecomUpdate(bv);
		
		int recom = bv.getRecom();
		
		return recom;
	}

	@Override
	public int boardDelete(int bidx, int midx, String password) {
		
		HashMap<String, Object> hm = new HashMap<String, Object>(); // 알아보기
		hm.put("bidx", bidx);
		hm.put("midx", midx);
		hm.put("password", password);
		
		int cnt = bm.boardDelete(hm);
		return cnt;
	}

	@Override
	public int boardUpdate(BoardVo bv) {
		int value = bm.boardUpdate(bv);
		return value;
	}

}
