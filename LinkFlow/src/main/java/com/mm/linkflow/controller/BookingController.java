package com.mm.linkflow.controller;


import java.util.List;
import java.util.Map;

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
import lombok.extern.slf4j.Slf4j;

@Slf4j
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
	
	@GetMapping("/supplies.bk") // 비품리스트조회
	public ModelAndView bkSuppliesPage(@RequestParam(value="page", defaultValue="1") int currentPage, ModelAndView mv) {
		int listCount = bkServiceImpl.selectBkCount();
		
		PageInfoDto pi = paging.getPageInfoDto(listCount, currentPage, 5, 10);
		List<AssetsDto> assList = bkServiceImpl.selectSuppliesList(pi);
		
		mv.addObject("pi",pi)
		  .addObject("assList",assList)
		  .setViewName("booking/bookingSupplies");
		return mv;
	}
	
	@GetMapping("/mylist.bk") // 나의 예약 리스트 
	public String myBookingPage() {
		return "booking/myBookingList";
	}
	
	@GetMapping("/supplies.use") //사용가능한비품 
	public void selectSupUse() {
		
	}
	
	@GetMapping("/sup.search") // 비품검색 
	public ModelAndView selectSupSearch(@RequestParam Map<String, String> search , @RequestParam(value="page", defaultValue="1") int currentPage , ModelAndView mv) {
		int listCount = bkServiceImpl.searchBkCount(search);
		PageInfoDto pi = paging.getPageInfoDto(listCount, currentPage, 5, 10);
		
		List<AssetsDto> assList = bkServiceImpl.selectSearchSupList(pi, search);
		mv.addObject("pi",pi)
		  .addObject("assList",assList)
		  .addObject("search", search)
		  .setViewName("booking/bookingSupplies");
		
		return mv;
	}

	@GetMapping("/assets.list") // 자산리스트 조회 
	public void selectAssetsList() {
		
	}
	
	@PostMapping("/insert.ass") // 자산 추가 
	public void insertAssets() {
		
	}
	
}
