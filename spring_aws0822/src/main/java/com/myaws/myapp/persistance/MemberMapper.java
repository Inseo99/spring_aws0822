package com.myaws.myapp.persistance;

import com.myaws.myapp.domain.MemberVo;

// ���̹�Ƽ������ ����� �޼ҵ带 ������ ���� ��
// �������̽��� ���� - �ڵ尡 �����ϰ� ���꼺�� ��������
public interface MemberMapper {
	
	public int memberInsert(MemberVo mv);
	
	public int memberIdCheck(String memberid);

	public MemberVo memberLoginCheck(String memberid);
	
}
