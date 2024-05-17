package com.mm.linkflow.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.mm.linkflow.dao.GroupDao;
import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.service.service.GroupService;

import lombok.RequiredArgsConstructor;
@RequiredArgsConstructor
@Service
public class GroupServiceImpl implements GroupService {
		private final GroupDao gDao;
		
	@Override
	public List<MemberDto> groupList() {
		return gDao.groupList();
	}

}
