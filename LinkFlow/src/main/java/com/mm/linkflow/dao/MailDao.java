package com.mm.linkflow.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mm.linkflow.dto.BoardDto;
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

	public int updateMailRead(Map<String, Object> map) {
		return sqlSession.update("mailMapper.updateMailRead", map);
	}

	public int insertSendMail(SendMailDto sendMail) {
		return sqlSession.insert("mailMapper.insertSendMail", sendMail);
	}

	public int insertReceiveMail(String emailId) {
		return sqlSession.insert("mailMapper.insertReceiveeMail", emailId);
	}

	public int selectCurrnetTempSave() {
		return sqlSession.selectOne("mailMapper.selectCurrnetTempSave");
	}

	public int updateTempSaveMail(SendMailDto mail) {
		return sqlSession.update("mailMapper.updateTempSaveMail", mail);
	}

	public int selectTempSaveListCount(String userId) {
		return sqlSession.selectOne("mailMapper.selectTempSaveListCount", userId);
	}

	public List<BoardDto> selectTempSaveList(PageInfoDto pi, String userId) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1) * limit;
		
		RowBounds rowBounds= new RowBounds( offset, limit );
		
		return sqlSession.selectList("mailMapper.selectTempSaveList", userId, rowBounds);
	}

	public int insertTempSaveReceiveMail(int mailNo, String emailId) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("mailNo", mailNo);
		map.put("emailId", emailId);		
		return sqlSession.insert("mailMapper.insertTempSaveReceiveMail", map);
	}


	public int deleteMail(HashMap <String, Object> map) {
		return sqlSession.update("mailMapper.deleteMail", map);
	}

	public List<ReceiveMailDto> selectTrashList(PageInfoDto pi, String userId) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1) * limit;
		
		RowBounds rowBounds= new RowBounds( offset, limit );
		
		return sqlSession.selectList("mailMapper.selectTrashList", userId, rowBounds);
	}

	public int insertSendReMail(SendMailDto sendMail) {
		return sqlSession.insert("mailMapper.insertSendReMail", sendMail);
	}

	public int reStoreMail(HashMap<String, Object> map) {
		return sqlSession.update("mailMapper.reStoreMail", map);
	}

	public int removeMail(List<Integer> no) {
		return sqlSession.delete("mailMapper.removeMailList", no);
	}

	public int removeTempSave(List<Integer> no) {
		return sqlSession.delete("mailMapper.removeTempSaveList", no);
	}

	public int removeTempSaveChild(List<Integer> no) {
		return sqlSession.delete("mailMapper.removeTempSaveChild", no);
	}

	public int selectSearchCount(Map<String, String> search) {
		return sqlSession.selectOne("mailMapper.selectSearchCount", search);
	}

	public List<SendMailDto> selectSearchList(PageInfoDto pi, Map<String, String> search) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1) * limit;
		
		RowBounds rowBounds= new RowBounds( offset, limit );
		
		return sqlSession.selectList("mailMapper.selectSearchList", search, rowBounds);
	}

}
