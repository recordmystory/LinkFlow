package com.mm.linkflow.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.mm.linkflow.dao.HrDao;
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
		return 0;
	}

	@Override
	public int modiflyMember(MemberDto m) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<MemberDto> searhMemberList(String keyword) {
		// TODO Auto-generated method stub
		return null;
	}

}
