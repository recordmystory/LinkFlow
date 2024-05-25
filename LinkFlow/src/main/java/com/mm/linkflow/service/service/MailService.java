package com.mm.linkflow.service.service;

import java.util.List;

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

	int updateMailRead(int no);

}
