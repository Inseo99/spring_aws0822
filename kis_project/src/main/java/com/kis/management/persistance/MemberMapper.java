package com.kis.management.persistance;

import java.util.HashMap;

import com.kis.management.domain.MemberVo;

public interface MemberMapper {

   public int memberInsert(MemberVo mv);

   public MemberVo memberLoginCheck(HashMap<String, Object> hm);

   public int memberIdCheck(String member_id);
   
}