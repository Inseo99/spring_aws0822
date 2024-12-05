package com.kis.management.service;

import java.util.ArrayList;

import com.kis.management.domain.DepartmentVo;
import com.kis.management.domain.SearchCriteria;

public interface DepartmentService {

	public int departmentTatalCount(SearchCriteria scri);

	public ArrayList<DepartmentVo> departmentSelectAll(SearchCriteria scri);

	public int departmentInsert(DepartmentVo dv);

	public DepartmentVo departmentSelectOne(int didx);

	public int departmentUpdate(DepartmentVo dv);

	public int departmentDelete(int didx);
   
}