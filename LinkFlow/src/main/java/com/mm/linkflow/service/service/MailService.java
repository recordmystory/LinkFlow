package com.mm.linkflow.service.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.mm.linkflow.dto.BoardDto;
import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.dto.PageInfoDto;
import com.mm.linkflow.dto.ReceiveMailDto;
import com.mm.linkflow.dto.SendMailDto;

public interface MailService {

	int selectReceiveListCount(MemberDto loginUser);

	List<ReceiveMailDto> selectReceiveList(PageInfoDto pi, MemberDto loginUser);

	int selectNonReadCount(MemberDto loginUser);

	int selectTrashCount(MemberDto loginUser);

	int selectSendListCount(MemberDto loginUser);

	List<SendMailDto> selectSendList(PageInfoDto pi, MemberDto loginUser);

	SendMailDto selectMail(int no);

	int updateMailRead(Map<String, Object> map);

	int insertSendMail(SendMailDto sendMail);

	int insertReceiveMail(String[] receivceEmailId);

	int selectCurrnetTempSave();

	int updateTempSaveMail(SendMailDto mail, String[] delFileNo);

	int selectTempSaveListCount(String userId);

	List<BoardDto> selectTempSaveList(PageInfoDto pi, String userId);

	int insertTempSaveReceiveMail(int mailNo, String[] receivceEmailId);

	int deleteMail(HashMap <String, Object> map);

	List<ReceiveMailDto> selectTrashList(PageInfoDto pi, String userId);

	int reStoreMail(HashMap<String, Object> map);

	int removeMail(List<Integer> no);

	int removeTempSave(List<Integer> no);

	int selectSearchCount(Map<String, String> search);

	List<SendMailDto> selectSearchList(PageInfoDto pi, Map<String, String> search);

}
