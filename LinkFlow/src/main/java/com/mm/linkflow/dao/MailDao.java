package com.mm.linkflow.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.dto.PageInfoDto;
import com.mm.linkflow.dto.ReceiveMailDto;
import com.mm.linkflow.dto.SendMailDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class MailDao {
	private final SqlSessionTemplate sqlSession;

	public int selectReceiveListCount(MemberDto loginUser) {
		return sqlSession.selectOne("mailMapper.selectReceiveMailListCount", loginUser);
	}

	public List<ReceiveMailDto> selectReceiveList(PageInfoDto pi, MemberDto loginUser) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1) * limit;
		
		RowBounds rowBounds= new RowBounds( offset, limit );
		
		return sqlSession.selectList("mailMapper.selectReceiveList", loginUser, rowBounds);
	}

	public int selectNonReadCount(MemberDto loginUser) {
		return sqlSession.selectOne("mailMapper.selectNonReadCount", loginUser);
	}

	public int selectTrashCount(MemberDto loginUser) {
		return sqlSession.selectOne("mailMapper.selectTrashCount", loginUser);
	}

	public int selectSendListCount(MemberDto loginUser) {
		return sqlSession.selectOne("mailMapper.selectSendListCount", loginUser);
	}

	public List<SendMailDto> selectSendList(PageInfoDto pi, MemberDto loginUser) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1) * limit;
		
		RowBounds rowBounds= new RowBounds( offset, limit );
		
		return sqlSession.selectList("mailMapper.selectSendList", loginUser, rowBounds);
	}

	public SendMailDto selectMail(int no) {
		return sqlSession.selectOne("mailMapper.selectMail", no);
	}

	public int updateMailRead(int no) {
		return sqlSession.update("mailMapper.updateMailRead", no);
	}

	public int insertSendMail(SendMailDto sendMail) {
		return sqlSession.insert("mailMapper.insertSendMail", sendMail);
	}

	public int insertReceiveeMail(String emailId) {
		return sqlSession.insert("mailMapper.insertReceiveeMail", emailId);
	}
}
