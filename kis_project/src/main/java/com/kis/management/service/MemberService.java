package com.kis.management.service;

import com.kis.management.domain.MemberVo;

public interface MemberService {
   
   public int adminInsert(MemberVo mv);

   public MemberVo memberLoginCheck(String member_id, String grade);
   
   public int memberIdCheck(String member_id);

   public int employeeInsert(MemberVo mv);
}