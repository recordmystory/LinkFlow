package com.mm.linkflow.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mm.linkflow.dto.EdocDto;
import com.mm.linkflow.dto.PageInfoDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class EdsmProgDao {
	private final SqlSessionTemplate sqlSessionTemplate;
	
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