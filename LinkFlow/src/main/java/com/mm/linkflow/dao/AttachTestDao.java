package com.mm.linkflow.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mm.linkflow.dto.AttachDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class AttachTestDao {
	private final SqlSessionTemplate sqlSession;
	
	public int insertAttach(AttachDto at) {
		return sqlSession.insert("attachMapper.insertAttach", at);
	}
	
	public List<AttachDto> list(AttachDto at){
		return sqlSession.selectList("attachMapper.selectAttach", at);
	}
	
	public int delete(String[] delFileNo) {
		return sqlSession.delete("attachMapper.deleteAttach", delFileNo);
	}

}
