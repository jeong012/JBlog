package com.javaex.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.CateDao;
import com.javaex.vo.CateVo;

@Service
public class CateService {
	
	@Autowired
	private CateDao cateDao;

	public List<CateVo> getCate(String cateId) {
		List<CateVo> cateList = cateDao.selectCateVo(cateId);
		return cateList;
	}

	public boolean insertCate(CateVo cateVo) {
		int isInserted = cateDao.insertCate(cateVo);
		return isInserted == 1;
	}

	public boolean deleteCate(int cateNo) {
		int isDeleted = cateDao.deleteCate(cateNo);
		return isDeleted == 1;
	}
}
