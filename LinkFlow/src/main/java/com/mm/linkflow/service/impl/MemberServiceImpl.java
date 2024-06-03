package com.mm.linkflow.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

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
		
		if(m.getProfileUrl() != null) {
			return mDao.updateMember(m);
		}else {
			return mDao.updatInfoeMember(m);
		}
	}
	
	@Override
	public int updatePwd(MemberDto m) {
		
		return mDao.updatePwd(m);
	}
	@Override
	public MemberDto myAttemdamce(String userId) {
		return mDao.myAttemdamce(userId);
	}
	@Override
	public List<MemberDto> searchDayoff(MemberDto m) {
		return mDao.searchDayoff(m);
	}
	
	@Override
	public int updatInfoeMember(MemberDto m) {
		// TODO Auto-generated method stub
		return mDao.updatInfoeMember(m);
	}
	@Override
	public int deleteProfill(MemberDto m) {
		// TODO Auto-generated method stub
		return mDao.deleteProfill(m);
	}
	@Override
	public String SerchPwd(String userId) {
		// TODO Auto-generated method stub
		return mDao.SerchPwd(userId);
	}
	@Override
	public int selectMale() {
		return mDao.selectMale();
	}
	@Override
	public int selectFemale() {
		return mDao.selectFemale();
	}
	@Override
	public int selectAllMember(String date) {
		return mDao.selectAllMember(date);
	}
	@Override
	public int selectHireMember(String date) {
		return mDao.selectHireMember(date);
	}
	@Override
	public int selectRetireMember(String date) {
		return mDao.selectRetireMember(date);
	}
	@Override
	public MemberDto selectCategoryMaster(String boardType) {
		return mDao.selectCategoryMaster(boardType);
	}
	@Override
	public int selectCheckUser(String[] email) {
		return mDao.selectCheckUser(email);
	}
	@Override
	public List<MemberDto> selectTeamMember(String title) {
		return mDao.selectTeamMember(title);
	}

}
