package com.mm.linkflow.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mm.linkflow.dto.EdocDto;
import com.mm.linkflow.dto.EdocHistDto;
import com.mm.linkflow.dto.EdocRefDto;
import com.mm.linkflow.dto.PageInfoDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class EdsmDocboxDao {
	private final SqlSessionTemplate sqlSessionTemplate;
	
	public int selectDocboxListCnt(String userId) {
		return sqlSessionTemplate.selectOne("edsmDocboxMapper.selectDocboxListCnt", userId);
	}

	public List<EdocDto> selectDocboxList(PageInfoDto pi, String userId) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return sqlSessionTemplate.selectList("edsmDocboxMapper.selectDocboxList", userId, rowBounds);
	}

	public int selectSearchListCnt(Map<String, String> search) {
		return sqlSessionTemplate.selectOne("edsmDocboxMapper.selectSearchListCnt", search);
	}

	public List<EdocDto> selectSearchList(Map<String, String> search, PageInfoDto pi) {
		RowBounds rowBounds = new RowBounds((pi.getCurrentPage()-1) * pi.getBoardLimit(), pi.getBoardLimit());

		return sqlSessionTemplate.selectList("edsmDocboxMapper.selectSearchList", search, rowBounds);
	}

	public EdocDto selectEdocDetail(String edNo) {
		return sqlSessionTemplate.selectOne("edsmDocboxMapper.selectEdocDetail", edNo);
	}

	public List<EdocHistDto> selectApprDetail(String edNo) {
		return sqlSessionTemplate.selectList("edsmDocboxMapper.selectApprDetail", edNo);
	}

	public List<EdocRefDto> selectRefDetail(String edNo) {
		return sqlSessionTemplate.selectList("edsmDocboxMapper.selectRefDetail", edNo);
	}

}
