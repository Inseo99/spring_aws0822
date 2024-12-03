package com.kis.management.service;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kis.management.domain.MemberVo;
import com.kis.management.persistance.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService{
   
private MemberMapper mm;
   
   @Autowired
   public MemberServiceImpl(SqlSession sqlSession) {
      this.mm = sqlSession.getMapper(MemberMapper.class);      
   }
   
   @Override
   public int memberInsert(MemberVo mv) {
      int value = mm.memberInsert(mv);
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
}