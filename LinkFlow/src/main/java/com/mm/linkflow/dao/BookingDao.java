package com.mm.linkflow.dao;

import java.time.LocalDateTime;
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
		return sql.selectOne("bkMapper.selectDetailMyBk",bkNo);
	}

	public int modifyBooking(BookingDto bk) {
		return sql.update("bkMapper.modifyBk",bk);
	}

	public int cancleBooking(BookingDto bk) {
		return sql.update("bkMapper.cancleBk",bk);
	}

	public int selectMySearchCount(Map<String, String> search) {
		return sql.selectOne("bkMapper.selectMySearchCount",search);
	}

	public List<BookingDto> selectMySearchList(Map<String, String> search, PageInfoDto pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() -1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset , limit);
		return sql.selectList("bkMapper.selectMySearchList",search, rowBounds);
	}

	public List<AssetsDto> selectDetailAssList(String supName) {
		return sql.selectList("bkMapper.selectDetailAssList",supName);
	}

	public int selectAssCount() {
		return sql.selectOne("bkMapper.selectAssCount");
	}

	public List<AssetsDto> selectAssetsList(PageInfoDto pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		return sql.selectList("bkMapper.selectAssetsList",null,rowBounds);
	}

	public int selectSearchAssCout(Map<String, String> search) {
		return sql.selectOne("bkMapper.selectSearchAssCount",search);
	}

	public List<AssetsDto> selectSearchAssList(PageInfoDto pi, Map<String, String> search) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1) *limit;
		
		RowBounds rowBounds= new RowBounds(offset,limit);
		return sql.selectList("bkMapper.selectSearchAssList",search,rowBounds);
	}

	public int delAssets(String assetsNo) {
		return sql.update("bkMapper.deleteAssets",assetsNo);
	}

	public int insertAssets(Map<String,Object> mp) {
		
		return sql.insert("bkMapper.insertAssets",mp);
	}

	public int modAssets(Map<String, Object> mp) {
		return sql.update("bkMapper.modifyAssets",mp);
	}

	public int selectSupWaitCount() {
		return sql.selectOne("bkMapper.selectBkWaitCount");
	}

	public List<BookingDto> selectSupWaitList(PageInfoDto pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1)*limit;
		RowBounds rowBounds = new RowBounds(offset,limit);
		return sql.selectList("bkMapper.selectBkWaitList",null, rowBounds);
	}

	public int selectSupStatusCount(Map<String, String> search) {
		return sql.selectOne("bkMapper.selectSupStatusCount",search);
	}

	public List<BookingDto> selectSupStatusList(Map<String, String> search, PageInfoDto pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1 )* limit;
		RowBounds rowBounds = new RowBounds(offset,limit);
		return sql.selectList("bkMapper.selectSupStatusList",search,rowBounds);
	}

	public int updateSupBkConfirm(Map<String, String> bk) {
		return sql.update("bkMapper.updateSupBkConfirm",bk);
	}

	public int updateSupBkReturn(Map<String, String> bk) {
		return sql.update("bkMapper.updateSupBkReturn",bk);
	}

	public List<AssetsDto> modalSetDtoList() {
		return sql.selectList("bkMapper.modalSetDtoList");
	}

	public int insertBooking(Map<String, String> bk) {
		return sql.insert("bkMapper.insertBooking",bk);
	}

	public List<BookingDto> selectRoomWaitList() {
		return sql.selectList("bkMapper.selectRoomWaitList");
	}

	public int updateRoomBooking(Map<String, String> bk) {
		return sql.update("bkMapper.updateRoomBooking",bk);
	}

	public List<BookingDto> selectRoomBooking(Map<String,Object> rooms) {
		return sql.selectList("bkMapper.selectRoomBooking",rooms);
	}

	public int autoRoomBkEnd() {
		
		return sql.update("bkMapper.autoRoomBkEnd");
	}

	public int autoCarBkUse() {
		return sql.update("bkMapper.autoCarBkUse");
	}

}
