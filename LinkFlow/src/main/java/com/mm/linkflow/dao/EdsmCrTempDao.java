package com.mm.linkflow.dao;

import java.util.List;
import java.util.Map;

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
		return sqlSessionTemplate.insert("edsmFormMapper.insertForm", edsmForm);
	}

	public int selectCrTempListCnt() {
		return sqlSessionTemplate.selectOne("edsmFormMapper.selectCrTempListCnt");
	}

	public List<EdocFormDto> selectCrTempList(PageInfoDto pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return sqlSessionTemplate.selectList("edsmFormMapper.selectCrTempList", null, rowBounds);
	}

	public int selectSearchListCnt(Map<String, String> search) {
		return sqlSessionTemplate.selectOne("edsmFormMapper.selectSearchListCnt", search);
	}

	public List<EdocFormDto> selectSearchList(Map<String, String> search, PageInfoDto pi) {
		RowBounds rowBounds = new RowBounds((pi.getCurrentPage() - 1) * pi.getBoardLimit(), pi.getBoardLimit());
		return sqlSessionTemplate.selectList("edsmFormMapper.selectSearchList", search, rowBounds);
	}

	public EdocFormDto selectCrTemp(String no) {
		return sqlSessionTemplate.selectOne("edsmFormMapper.selectCrTemp", no);
	}

	public int updateCrTemp(EdocFormDto edsmForm) {
		return sqlSessionTemplate.update("edsmFormMapper.updateCrTemp", edsmForm);
	}
}
