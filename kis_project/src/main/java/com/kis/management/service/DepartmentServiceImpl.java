package com.kis.management.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kis.management.domain.MemberVo;
import com.kis.management.domain.SearchCriteria;
import com.kis.management.persistance.DepartmentMapper;
import com.kis.management.persistance.MemberMapper;

@Service
public class DepartmentServiceImpl implements DepartmentService{
   
	private DepartmentMapper dm;
   
   
}