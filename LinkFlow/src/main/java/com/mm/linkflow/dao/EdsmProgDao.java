package com.mm.linkflow.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mm.linkflow.dto.DeptDto;
import com.mm.linkflow.dto.EdocFormDto;

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
