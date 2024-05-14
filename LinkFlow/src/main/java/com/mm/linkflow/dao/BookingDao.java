package com.mm.linkflow.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mm.linkflow.dto.AssetsDto;
import com.mm.linkflow.dto.PageInfoDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class BookingDao {

	private final SqlSessionTemplate sql;
	
	public int selectBkCount() {
		return sql.selectOne("bkMapper.selectBkCount");
	}

	public List<AssetsDto> selectSuppliesList(PageInfoDto pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() -1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset , limit);
		return sql.selectList("bkMapper.selectSuppliesList", null , rowBounds);
	}

}
