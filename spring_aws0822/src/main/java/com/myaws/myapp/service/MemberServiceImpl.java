package com.myaws.myapp.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myaws.myapp.domain.MemberVo;
import com.myaws.myapp.persistance.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService{

	private MemberMapper mm;
	
	@Autowired // ��Ȯ���ǹ� ã�ƺ���
	public MemberServiceImpl(SqlSession sqlSession) {
		this.mm = sqlSession.getMapper(MemberMapper.class);
		
	}
	
	@Override
	public int memberInsert(MemberVo mv) {
		int value = mm.memberInsert(mv);
		return value;
	}

	@Override
	public int memberIdCheck(String memberid) {
		int value = mm.memberIdCheck(memberid);
		return value;
	}
	
	
}
