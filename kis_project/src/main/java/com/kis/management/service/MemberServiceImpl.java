package com.kis.management.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kis.management.domain.MemberVo;
import com.kis.management.domain.SearchCriteria;
import com.kis.management.persistance.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService{
   
private MemberMapper mm;
   
   @Autowired
   public MemberServiceImpl(SqlSession sqlSession) {
      this.mm = sqlSession.getMapper(MemberMapper.class);      
   }
   
   @Override
   public int adminInsert(MemberVo mv) {
      int value = mm.adminInsert(mv);
      return value;
   }

   @Override
   public MemberVo memberLoginCheck(String member_id, String grade) {
      
      HashMap<String, Object> hm = new HashMap<String, Object>();
      hm.put("member_id", member_id);
      hm.put("grade", grade);
      
      MemberVo mv = mm.memberLoginCheck(hm);
      return mv;
   }

	@Override
	public int memberIdCheck(String member_id) {
		int value = mm.memberIdCheck(member_id);
		return value;
	}

	@Override
	public int employeeInsert(MemberVo mv) {
		int value = mm.employeeInsert(mv);
	    return value;
	}
	
	@Override
	public int memeberTatalCount(SearchCriteria scri) {
		int cnt = mm.memeberTatalCount(scri);		
		return cnt;
	}

	@Override
	public ArrayList<MemberVo> memberSelectAll(SearchCriteria scri) {
		
		HashMap<String, Object> hm = new HashMap<String, Object>(); // 알아보기
		hm.put("startPageNum", (scri.getPage()-1) * scri.getPerPageNum());
		hm.put("perPageNum", scri.getPerPageNum());
		hm.put("searchType", scri.getSearchType());
		hm.put("keyword", scri.getKeyword());
		
		ArrayList<MemberVo> mlist = mm.memberSelectAll(hm);
		return mlist;
	}

	@Override
	public MemberVo memberSelectOne(int midx) {
		MemberVo mv = mm.memberSelectOne(midx);
		return mv;
	}

	@Override
	public int memberUpdate(MemberVo mv) {
		int value = mm.memberUpdate(mv);
	    return value;
	}

	@Override
	public int memberDelete(int midx) {
		int value = mm.memberDelete(midx);
		return value;
	}

	@Override
	public int informationUpdate(MemberVo mv) {
		int value = mm.informationUpdate(mv);
	    return value;
	}
}