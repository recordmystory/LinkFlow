package com.mm.linkflow.service.impl;


import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;

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
import lombok.extern.slf4j.Slf4j;

@Slf4j
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
	public int updateMailRead(Map<String, Object> map) {
		return mailDao.updateMailRead(map);
	}

	@Override
	public int insertSendMail(SendMailDto sendMail) {

		int result1 = mailDao.insertSendMail(sendMail);
		int result2 = mailDao.insertSendReMail(sendMail);
		int result3 = 1;
		List<AttachDto> attachList = sendMail.getAttachList();
		if(!ObjectUtils.isEmpty(attachList)) {
			result3 = 0;
			for(AttachDto at : attachList) {
				result3 += attachDao.insertAttach(at);
			}
		}
		return result1 * result2 * result3;
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
	public int insertTempSaveReceiveMail(int mailNo, String[] receivceEmailId) {
		int result=0;
		for(int i=0; i< receivceEmailId.length; i++) {
			result += mailDao.insertTempSaveReceiveMail(mailNo, receivceEmailId[i]);
		}
		return result;
	}

	@Override
	public int deleteMail(HashMap <String, Object> map) {
		return mailDao.deleteMail(map);
	}

	@Override
	public List<ReceiveMailDto> selectTrashList(PageInfoDto pi, String userId) {
		return mailDao.selectTrashList(pi, userId);
	}

	@Override
	public int reStoreMail(HashMap<String, Object> map) {
		return mailDao.reStoreMail(map);
	}

	@Override
	public int removeMail(List<Integer> no) {
		int result1 = mailDao.removeMail(no);
		return result1;
	}

	@Override
	public int removeTempSave(List<Integer> no) {
		int result2 = 1;
		for(int index : no) {
			List<String> delFileNo = attachDao.selectDelMailFileNo(index); 
			
			if(delFileNo != null && delFileNo.size() > 0) {
				
				String[] delFileNoArray = new String[delFileNo.size()];
				delFileNo.toArray(delFileNoArray);
				
				for(int i=0; i<delFileNoArray.length; i++) {
					log.debug("delFileNoArray[{}] : {}", i, delFileNoArray[i]);
				}
				
				result2 = attachDao.deleteAttach(delFileNoArray);	
				
				List<AttachDto> delFileList = attachDao.selectDelFileList(delFileNoArray);
				for(AttachDto at : delFileList) {
					new File(at.getFilePath() + "/" + at.getFilesystemName()).delete();
				}
			}
		}
		int result3 = mailDao.removeTempSaveChild(no);
		int result1 = mailDao.removeTempSave(no);
		return result1 * result2 * result3;
	}

	@Override
	public int selectSearchCount(Map<String, String> search) {
		return mailDao.selectSearchCount(search);
	}

	@Override
	public List<SendMailDto> selectSearchList(PageInfoDto pi, Map<String, String> search) {
		return mailDao.selectSearchList(pi, search);
	}
}
