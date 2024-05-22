package com.mm.linkflow.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mm.linkflow.dto.DeptDto;
import com.mm.linkflow.dto.EdocDto;
import com.mm.linkflow.dto.EdocFormDto;
import com.mm.linkflow.dto.EdocHistDto;
import com.mm.linkflow.dto.PageInfoDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class EdsmProgDao {
	private final SqlSessionTemplate sqlSessionTemplate;

	public List<EdocFormDto> selectFormList() {
		return sqlSessionTemplate.selectList("edsmFormMapper.selectFormList");
	}

	public List<EdocFormDto> selectEdFrContentList(String docType) {
		return sqlSessionTemplate.selectList("edsmFormMapper.selectEdFrContentList", docType);
	}

	public List<DeptDto> selectApprLine() {
		return sqlSessionTemplate.selectList("edsmProgMapper.selectApprLine");
	}

	public int insertDoc(EdocDto edocDto) {
		return sqlSessionTemplate.insert("edsmProgMapper.insertDoc", edocDto);
	}

	public int insertApprLine(EdocHistDto edocHistDto) {
		return sqlSessionTemplate.insert("edsmProgMapper.inserApprLine", edocHistDto);
	}

	public int selectAllListCnt(String userId) {
		return sqlSessionTemplate.selectOne("edsmProgMapper.selectAllListCnt", userId);
	}

	public List<EdocFormDto> selectAllList(PageInfoDto pi, String userId) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);

		return sqlSessionTemplate.selectList("edsmProgMapper.selectAllList", userId, rowBounds);
		
	}

	public int selectSearchListCnt(Map<String, String> search) {
		return sqlSessionTemplate.selectOne("edsmProgMapper.selectSearchListCnt", search);
	}

	public List<EdocDto> selectSearchList(Map<String, String> search, PageInfoDto pi) {
		RowBounds rowBounds = new RowBounds((pi.getCurrentPage()-1) * pi.getBoardLimit(), pi.getBoardLimit());
		return sqlSessionTemplate.selectList("edsmProgMapper.selectSearchList", search, rowBounds);
	}
	
//	public int selectAllListCount() {
//		return sqlSessionTemplate.selectOne("edsmProgMapper.selectAllListCount");
//	}
//
//	public List<EdocDto> selectAllList(PageInfoDto pi) {
//		int limit = pi.getBoardLimit();
//		int offset = (pi.getCurrentPage() - 1) * limit;
//		
//		RowBounds rowBounds = new RowBounds(offset, limit);
//		
//		return sqlSessionTemplate.selectList("edsmProgMapper.selectAllList", null, rowBounds);
//	}

}
