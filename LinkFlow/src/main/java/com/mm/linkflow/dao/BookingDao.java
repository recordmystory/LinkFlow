package com.mm.linkflow.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mm.linkflow.dto.AssetsDto;
import com.mm.linkflow.dto.BookingDto;
import com.mm.linkflow.dto.PageInfoDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Repository
public class BookingDao {

	private final SqlSessionTemplate sql;
	
	public int selectSupCount() {
		return sql.selectOne("bkMapper.selectSupCount");
	}

	public List<AssetsDto> selectSuppliesList(PageInfoDto pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() -1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset , limit);
		return sql.selectList("bkMapper.selectSuppliesList", null , rowBounds);
	}

	public int selectSearchBkCount(Map<String,String> search) {
		return sql.selectOne("bkMapper.selectSearchBkCount",search);
	}

	public List<AssetsDto> selectSearchSupList(Map<String,String> search, PageInfoDto pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() -1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset , limit);
		return sql.selectList("bkMapper.selectSearchSupList", search , rowBounds);
	}

	public int selectBkCount(String userId) {
		return sql.selectOne("bkMapper.selectBkCount",userId);
	}

	public List<BookingDto> selectMyBkList(PageInfoDto pi, String userId) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() -1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset , limit);
		return sql.selectList("bkMapper.selectMyBkList", userId , rowBounds);
	}

	public BookingDto selectDetailMyBk(String bkNo) {
		BookingDto bk = sql.selectOne("bkMapper.selectDetailMyBk",bkNo);
		System.out.println(bk);
		return sql.selectOne("bkMapper.selectDetailMyBk",bkNo);
	}

}
