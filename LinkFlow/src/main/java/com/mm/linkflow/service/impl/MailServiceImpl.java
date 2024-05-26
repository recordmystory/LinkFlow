package com.mm.linkflow.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.mm.linkflow.dao.AttachDao;
import com.mm.linkflow.dao.MailDao;
import com.mm.linkflow.dto.AttachDto;
import com.mm.linkflow.dto.BoardDto;
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
	public int insertReceiveMail(String[] receivceEmailId) {
		int result=0;
		for(int i=0; i< receivceEmailId.length; i++) {
			result += mailDao.insertReceiveMail(receivceEmailId[i]);
		}
		
		return result;
	}

	@Override
	public int selectCurrnetTempSave() {
		return mailDao.selectCurrnetTempSave();
	}

	@Override
	public int updateTempSaveMail(SendMailDto mail, String[] delFileNo) {
		int result1 = mailDao.updateTempSaveMail(mail);
		int result2 = delFileNo == null ? 1
										: attachDao.deleteAttach(delFileNo);
		
		List<AttachDto> list = mail.getAttachList();
		int result3 = 0;
		if(list != null) {
			for(AttachDto at : list) {
				result3 += attachDao.insertAttach(at);
			}
		}else {
			list = new ArrayList<>();
		}
		
		return result1 == 1
				&& result2 > 0
					&& result3 == list.size() 
						? 1 : -1 ;
	}

	@Override
	public int selectTempSaveListCount(String userId) {
		return mailDao.selectTempSaveListCount(userId);
	}

	@Override
	public List<BoardDto> selectTempSaveList(PageInfoDto pi, String userId) {
		return mailDao.selectTempSaveList(pi, userId);
	}

	@Override
	public int insertTempSaveMail(int mailNo, String[] receivceEmailId) {
		int result=0;
		for(int i=0; i< receivceEmailId.length; i++) {
			result += mailDao.insertTempSaveMail(mailNo, receivceEmailId[i]);
		}
		return result;
	}
}
