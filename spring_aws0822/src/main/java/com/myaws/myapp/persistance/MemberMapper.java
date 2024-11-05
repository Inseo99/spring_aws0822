package com.myaws.myapp.persistance;

import java.util.ArrayList;

import com.myaws.myapp.domain.MemberVo;

// 마이바티스에서 사용할 메소드를 정의해 놓는 곳
// 인터페이스로 생성 - 코드가 간결하고 생산성이 높아진다
public interface MemberMapper {
	
	public int memberInsert(MemberVo mv);
	
	public int memberIdCheck(String memberId);

	public MemberVo memberLoginCheck(String memberId);

	
}
