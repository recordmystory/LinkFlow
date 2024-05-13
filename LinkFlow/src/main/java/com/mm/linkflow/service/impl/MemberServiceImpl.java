package com.mm.linkflow.service.impl;

import org.springframework.stereotype.Service;

import com.mm.linkflow.dao.MemberDao;
import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.service.service.MemberService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class MemberServiceImpl implements MemberService {
	
	private final MemberDao mDao;
	@Override
	public MemberDto loginMember(MemberDto m) {
		
		return mDao.loginMember(m);
	}

	@Override
	public int updateMember(MemberDto m) {
		
		return 0;
	}

}
