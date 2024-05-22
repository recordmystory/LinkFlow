package com.mm.linkflow.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.mm.linkflow.dao.HrDao;
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
	public List<DeptDto> selectApprLine() {
		return hDao.selectApprLine();
	}

}
