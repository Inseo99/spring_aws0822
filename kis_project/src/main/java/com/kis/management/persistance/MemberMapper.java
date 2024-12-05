package com.kis.management.persistance;

import java.util.ArrayList;
import java.util.HashMap;

import com.kis.management.domain.MemberVo;
import com.kis.management.domain.SearchCriteria;

public interface MemberMapper {

   public int adminInsert(MemberVo mv);

   public MemberVo memberLoginCheck(HashMap<String, Object> hm);

   public int memberIdCheck(String member_id);

   public int employeeInsert(MemberVo mv);

   public int memeberTatalCount(SearchCriteria scri);

   public ArrayList<MemberVo> memberSelectAll(HashMap<String, Object> hm);

   public MemberVo memberSelectOne(int midx);

   public int memberUpdate(MemberVo mv);

   public int memberDelete(int midx);

   public int informationUpdate(MemberVo mv);
   
}