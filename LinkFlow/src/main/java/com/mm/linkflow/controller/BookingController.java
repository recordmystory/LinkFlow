package com.mm.linkflow.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mm.linkflow.dto.AssetsDto;
import com.mm.linkflow.dto.PageInfoDto;
import com.mm.linkflow.service.impl.BookingServiceImpl;
import com.mm.linkflow.util.PagingUtil;

import lombok.RequiredArgsConstructor;

@RequestMapping("/booking")
@Controller
@RequiredArgsConstructor
public class BookingController {
	
	private final BookingServiceImpl bkServiceImpl;
	private final PagingUtil paging;

	@GetMapping("/room.bk") // 시설예약조회 
	public String bkRoomPage() {
		return "booking/bookingRoom";
	}
	
	@GetMapping("/supplies.bk") // 비품리스트조
	public ModelAndView bkSuppliesPage(@RequestParam(value="page", defaultValue="1") int currentPage, ModelAndView mv) {
		int listCount = bkServiceImpl.selectBkCount();
		
		PageInfoDto pi = paging.getPageInfoDto(listCount, currentPage, 5, 10);
		List<AssetsDto> asslist = bkServiceImpl.selectSuppliesList(pi);
		
		return null;
	}
	
	@GetMapping("/mylist.bk") // 나의 예약 리스트 
	public String myBookingPage() {
		return "booking/myBookingList";
	}
	
	@GetMapping("/supplies.use") //사용가능한비품 
	public void selectSupUse() {
		
	}
	
	@GetMapping("/supplies.search") // 비품검색 
	public void selectSupSearch() {
		
	}

	@GetMapping("/assets.list") // 자산리스트 조회 
	public void selectAssetsList() {
		
	}
	
	@PostMapping("/insert.ass") // 자산 추가 
	public void insertAssets() {
		
	}
	
}
