package com.kis.management.service;

import java.util.ArrayList;

import com.kis.management.domain.MemberVo;
import com.kis.management.domain.SearchCriteria;

public interface MemberService {
   
   public int adminInsert(MemberVo mv);

   public MemberVo memberLoginCheck(String member_id, String grade);
   
   public int memberIdCheck(String member_id);

   public int employeeInsert(MemberVo mv);
   
   public int memeberTatalCount(SearchCriteria scri);

   public ArrayList<MemberVo> memberSelectAll(SearchCriteria scri);

   public MemberVo memberSelectOne(int midx);
}