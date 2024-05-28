package com.mm.linkflow.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mm.linkflow.dto.AttachDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class AttachDao {
	private final SqlSessionTemplate sqlSession;
	
	public int insertAttach(AttachDto at) {
		return sqlSession.insert("attachMapper.insertAttach", at);
	}
	
	public List<AttachDto> list(AttachDto at){
		return sqlSession.selectList("attachMapper.selectAttach", at);
	}
	
	public List<AttachDto> selectDelFileList(String[] delFileNo) {
		
		return sqlSession.selectList("attachMapper.selectDelFileList", delFileNo);
	}
	
	public int deleteAttach(String[] delFileNo) {
		return sqlSession.delete("attachMapper.deleteAttach", delFileNo);
	}

	public List<String> selectDelBoardFileNo(int no) {
		return sqlSession.selectList("attachMapper.selectDelBoardFileNo", no);
	}

	public List<String> selectDelMailFileNo(int no) {
		return sqlSession.selectList("attachMapper.selectDelMailFileNo", no);
	}

}
