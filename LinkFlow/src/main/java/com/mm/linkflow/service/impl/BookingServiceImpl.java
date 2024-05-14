package com.mm.linkflow.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.mm.linkflow.dao.BookingDao;
import com.mm.linkflow.dto.AssetsDto;
import com.mm.linkflow.dto.BookingDto;
import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.dto.PageInfoDto;
import com.mm.linkflow.service.service.BookingService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class BookingServiceImpl implements BookingService {
	
	private final BookingDao bkDao;

	@Override
	public int selectBkCount() {
		return 0;
	}

	@Override
	public List<BookingDto> selectMyBkList(PageInfoDto pi, MemberDto m) {
		return null;
	}

	@Override
	public List<AssetsDto> selectSuppliesList(PageInfoDto pi) {
		return null;
	}

	@Override
	public List<AssetsDto> selectAssetsList(PageInfoDto pi) {
		return null;
	}

	@Override
	public int insertAssets(AssetsDto ass) {
		return 0;
	}

	@Override
	public int modssets(AssetsDto ass) {
		return 0;
	}

	@Override
	public int delAssets(int assetsNo) {
		return 0;
	}

	@Override
	public int selectBkUseCount() {
		return 0;
	}

	@Override
	public List<AssetsDto> selectSupUse(PageInfoDto pi) {
		return null;
	}

	@Override
	public int searchBkCount(String type, String keyword) {
		return 0;
	}

	@Override
	public List<AssetsDto> selectSearchSup(PageInfoDto pi) {
		return null;
	}

	@Override
	public int insertBooking(BookingDto bk) {
		return 0;
	}

	@Override
	public int modBooking(BookingDto bk) {
		return 0;
	}

	@Override
	public BookingDto selectDetailBk(BookingDto bk) {
		return null;
	}

}
