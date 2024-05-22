package com.mm.linkflow.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.mm.linkflow.dao.HrDao;
import com.mm.linkflow.dto.BoardCategoryDto;
import com.mm.linkflow.dto.CommonTableDto;
import com.mm.linkflow.dto.DeptDto;
import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.service.service.HrService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class HrServiceImpl implements HrService {
	
	private final HrDao hDao;
	
	@Override
	public List<MemberDto> selectMemberList() {
		// TODO Auto-generated method stub
		return hDao.selectMemberList();
	}

	@Override
	public int insertMember(MemberDto m) {
		// TODO Auto-generated method stub
		return hDao.insertMember(m);
	}

	@Override
	public int modiflyMember(MemberDto m) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<MemberDto> searhMemberList(String keyword) {
		// TODO Auto-generated method stub
		return hDao.searhMemberList(keyword);
	}

	@Override
	public List<DeptDto> selectDeftList() {
		// TODO Auto-generated method stub
		return hDao.selectDeftList();
	}

	@Override
	public List<CommonTableDto> selectCommonTableList() {
		// TODO Auto-generated method stub
		return hDao.selectCommonTableList();
	}

	@Override
	public int checkId(String checkId) {
		return hDao.checkId(checkId);
	}

	@Override
	public MemberDto selectDatailMember(String id) {
		return hDao.selectDatailMember(id);
	}

	@Override
	public int updateInfoMember(MemberDto m) {
		return hDao.updateInfoMember(m);
	}

	@Override
	public int resetPasswoard(MemberDto m) {
		return hDao.resetPasswoard(m);
	}

	@Override
	public int goRetire(MemberDto m) {
		return hDao.goRetire(m);
	}

	@Override
	public int goJoinPathy(MemberDto m) {
		return hDao.goJoinPathy(m);
	}

	@Override
	public int insertDept(DeptDto d) {
		return hDao.insertDept(d);
	}
	
	@Override
	public int insertCategory(BoardCategoryDto bd) {
		return hDao.insertCategory(bd);
	}
	
	@Override
	public int updateDeptTable(DeptDto d) {
		return hDao.updateDeptTable(d);
	}

	
	@Override
	public int updateDept(BoardCategoryDto bd) {
		return hDao.updateDept(bd);
	}

	@Override
	public int deleteDept(BoardCategoryDto bd) {
		return hDao.deleteDept(bd);
	}

	@Override
	public int DeleteDeptTable(DeptDto d) {
		return hDao.DeleteDeptTable(d);
	}

	@Override
	public int checkCode(String deptCode) {
		return hDao.checkCode(deptCode);
	}

	

	

}
