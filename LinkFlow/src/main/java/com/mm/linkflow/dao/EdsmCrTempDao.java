package com.mm.linkflow.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mm.linkflow.dto.EdocFormDto;
import com.mm.linkflow.dto.PageInfoDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class EdsmCrTempDao {
	private final SqlSessionTemplate sqlSessionTemplate;

	public int insertForm(EdocFormDto edsmForm) {
		return sqlSessionTemplate.insert("EdsmFormMapper.insertForm", edsmForm);
	}

	public int selectCrTempListCnt() {
		return sqlSessionTemplate.selectOne("EdsmFormMapper.selectCrTempListCnt");
	}

	public List<EdocFormDto> selectCrTempList(PageInfoDto pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return sqlSessionTemplate.selectList("EdsmFormMapper.selectCrTempList", null, rowBounds);
	}
}
