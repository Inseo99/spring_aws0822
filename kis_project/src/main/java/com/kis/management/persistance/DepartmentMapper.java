package com.kis.management.persistance;

import java.util.ArrayList;
import java.util.HashMap;

import com.kis.management.domain.DepartmentVo;
import com.kis.management.domain.MemberVo;
import com.kis.management.domain.SearchCriteria;

public interface DepartmentMapper {

	public int departmentTatalCount(SearchCriteria scri);

	public ArrayList<DepartmentVo> departmentSelectAll(HashMap<String, Object> hm);
	
	public int departmentInsert(DepartmentVo dv);
	
	public DepartmentVo departmentSelectOne(int didx);
	
	public int departmentUpdate(DepartmentVo dv);
	
	public int departmentDelete(int didx);

}