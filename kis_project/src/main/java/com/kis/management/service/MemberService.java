package com.kis.management.service;

import com.kis.management.domain.MemberVo;

public interface MemberService {
   
   public int memberInsert(MemberVo mv);

   public MemberVo memberLoginCheck(String member_id, String grade);
}