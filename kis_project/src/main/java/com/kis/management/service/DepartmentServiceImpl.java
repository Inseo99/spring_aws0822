package com.kis.management.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kis.management.domain.DepartmentVo;
import com.kis.management.domain.SearchCriteria;
import com.kis.management.persistance.DepartmentMapper;

@Service
public class DepartmentServiceImpl implements DepartmentService{
   
	private DepartmentMapper dm;

	@Autowired
	   public DepartmentServiceImpl(SqlSession sqlSession) {
	      this.dm = sqlSession.getMapper(DepartmentMapper.class);      
	   }
	
	@Override
	public int departmentTatalCount(SearchCriteria scri) {
		int cnt = dm.departmentTatalCount(scri);		
		return cnt;
	}

	@Override
	public ArrayList<DepartmentVo> departmentSelectAll(SearchCriteria scri) {
		HashMap<String, Object> hm = new HashMap<String, Object>(); // 알아보기
		hm.put("startPageNum", (scri.getPage()-1) * scri.getPerPageNum());
		hm.put("perPageNum", scri.getPerPageNum());
		hm.put("searchType", scri.getSearchType());
		hm.put("keyword", scri.getKeyword());
		
		ArrayList<DepartmentVo> dlist = dm.departmentSelectAll(hm);
		return dlist;
	}

	@Override
	public int departmentInsert(DepartmentVo dv) {
		int value = dm.departmentInsert(dv);
		return value;
	}

	@Override
	public DepartmentVo departmentSelectOne(int didx) {
		DepartmentVo dv = dm.departmentSelectOne(didx);
		return dv;
	}
   
	public int departmentUpdate(DepartmentVo dv) {
		int value = dm.departmentUpdate(dv);
		return value;
	}

	@Override
	public int departmentDelete(int didx) {
		int value = dm.departmentDelete(didx);
		return value;
	}
   
}