package com.mm.linkflow.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.mm.linkflow.dao.AttachDao;
import com.mm.linkflow.dao.MailDao;
import com.mm.linkflow.dto.AttachDto;
import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.dto.PageInfoDto;
import com.mm.linkflow.dto.ReceiveMailDto;
import com.mm.linkflow.dto.SendMailDto;
import com.mm.linkflow.service.service.MailService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class MailServiceImpl implements MailService {
	
	private final MailDao mailDao;
	private final AttachDao attachDao;
	
	@Override
	public int selectReceiveListCount(MemberDto loginUser) {
		return mailDao.selectReceiveListCount(loginUser);
	}

	@Override
	public List<ReceiveMailDto> selectReceiveList(PageInfoDto pi, MemberDto loginUser) {
		return mailDao.selectReceiveList(pi, loginUser);
	}

	@Override
	public int selectNonReadCount(MemberDto loginUser) {
		return mailDao.selectNonReadCount(loginUser);
	}

	@Override
	public int selectTrashCount(MemberDto loginUser) {
		return mailDao.selectTrashCount(loginUser);
	}

	@Override
	public int selectSendListCount(MemberDto loginUser) {
		return mailDao.selectSendListCount(loginUser);
	}

	@Override
	public List<SendMailDto> selectSendList(PageInfoDto pi, MemberDto loginUser) {
		return mailDao.selectSendList(pi, loginUser);
	}

	@Override
	public SendMailDto selectMail(int no) {
		return mailDao.selectMail(no);
	}

	@Override
	public int updateMailRead(int no) {
		return mailDao.updateMailRead(no);
	}

	@Override
	public int insertSendMail(SendMailDto sendMail) {

		int result1 = mailDao.insertSendMail(sendMail);
		
		int result2 = 1;
		List<AttachDto> attachList = sendMail.getAttachList();
		if(!attachList.isEmpty()) {
			result2 = 0;
			for(AttachDto at : attachList) {
				result2 += attachDao.insertAttach(at);
			}
		}
		return result1 * result2;
	}

	@Override
	public int insertReceiveeMail(String[] receivceEmailId) {
		int result=0;
		for(int i=0; i< receivceEmailId.length; i++) {
			result += mailDao.insertReceiveeMail(receivceEmailId[i]);
		}
		
		return result;
	}
}
