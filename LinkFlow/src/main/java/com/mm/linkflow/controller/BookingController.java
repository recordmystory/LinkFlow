package com.mm.linkflow.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mm.linkflow.dto.AssetsDto;
import com.mm.linkflow.dto.BookingDto;
import com.mm.linkflow.dto.MemberDto;
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
		int listCount = bkServiceImpl.selectSupCount();
		
		PageInfoDto pi = paging.getPageInfoDto(listCount, currentPage, 5, 10);
		List<AssetsDto> assList = bkServiceImpl.selectSuppliesList(pi);
		
		mv.addObject("pi",pi)
		  .addObject("assList",assList)
		  .setViewName("booking/bookingSupplies");
		return mv;
	}
	

	@GetMapping("/sup.search") // 비품검색 
	public ModelAndView selectSupSearch(@RequestParam Map<String,String> search,@RequestParam(value="page", defaultValue="1") int currentPage , ModelAndView mv) {
		
		log.debug("search:{}",search);
		int listCount = bkServiceImpl.searchBkCount(search);
		PageInfoDto pi = paging.getPageInfoDto(listCount, currentPage, 5, 10);
		
		List<AssetsDto> assList = bkServiceImpl.selectSearchSupList(pi, search);
		mv.addObject("pi",pi)
		  .addObject("assList",assList)
		  .addObject("search", search)
		  .setViewName("booking/bookingSupplies");
		
		return mv;
	}

	
	@GetMapping("/mylist.bk") // 나의 예약 리스트 
	public ModelAndView myBookingPage(@RequestParam(value="page", defaultValue="1") int currentPage, ModelAndView mv, HttpSession session) {
		String userId = ((MemberDto)session.getAttribute("loginUser")).getUserId();
		
		int listCount = bkServiceImpl.selectBkCount(userId);
		PageInfoDto pi = paging.getPageInfoDto(listCount, currentPage, 5, 10);
		
		List<BookingDto> bkList = bkServiceImpl.selectMyBkList(pi, userId);
		
		for(int i = 0; i<bkList.size(); i++) {
			switch(bkList.get(i).getStatus()) {
				case "WAI" : bkList.get(i).setStatus("예약대기"); break;
				case "COM" : bkList.get(i).setStatus("예약완료"); break;
				case "USE" : bkList.get(i).setStatus("사용중"); break;
				case "END" : bkList.get(i).setStatus("사용완료"); break;
				case "REJ" : bkList.get(i).setStatus("반려"); break;
				case "CAN" : bkList.get(i).setStatus("취소"); break;
			}
		}
		
		mv.addObject("pi",pi)
		  .addObject("bkList",bkList)
		  .setViewName("booking/myBookingList");
		
		return mv;
	}
	
	
	@GetMapping("/mylist.search")
	public ModelAndView myListSearch(@RequestParam Map<String, String> search, @RequestParam(value = "page", defaultValue = "1") int currentPage, ModelAndView mv, HttpSession session) {

		String userId = ((MemberDto) session.getAttribute("loginUser")).getUserId();
		search.put("userId",userId);
		
		int listCount = bkServiceImpl.selectMySearchCount(search);
		PageInfoDto pi = paging.getPageInfoDto(listCount, currentPage, 5, 10);
		
		List<BookingDto> bkList = bkServiceImpl.selectMySearchList(search, pi);

		for (int i = 0; i < bkList.size(); i++) {
			switch (bkList.get(i).getStatus()) {
				case "WAI" : bkList.get(i).setStatus("예약대기"); break;
				case "COM" : bkList.get(i).setStatus("예약완료"); break;
				case "USE" : bkList.get(i).setStatus("사용중"); break;
				case "END" : bkList.get(i).setStatus("사용완료"); break;
				case "REJ" : bkList.get(i).setStatus("반려"); break;
				case "CAN" : bkList.get(i).setStatus("취소"); break;
			}
		}

		mv.addObject("pi", pi).addObject("bkList", bkList).setViewName("booking/myBookingList");

		return mv;

	}
	
	
	@GetMapping("/detail.bk") // 나의 예약 상세보기 
	public String selectDetailMyBk(@RequestParam(value="no")String bkNo, Model model) {
		
		BookingDto bk =  bkServiceImpl.selectDetailMyBk(bkNo);
		
		if(bk != null) {
			switch(bk.getStatus()) {
			case "WAI" : bk.setStatus("예약대기"); break;
			case "COM" : bk.setStatus("예약완료"); break;
			case "USE" : bk.setStatus("사용중"); break;
			case "END" : bk.setStatus("사용완료"); break;
			case "REJ" : bk.setStatus("반려"); break;
			case "CAN" : bk.setStatus("취소"); break;
			}
		}
		model.addAttribute("bk", bk);
		return "booking/myBookingDetail";
	}
	
	@PostMapping("/modify.bk")
	public String modifyBooking(BookingDto bk) {
		
		log.debug("bk: {}",bk);
		int result = bkServiceImpl.modifyBooking(bk);
		log.debug("result : {}", result);
		if(result>0) {
			
			return "redirect:booking/myBookingList";
		}else {
			return "redirect:booking/myBookingDetail?no="+bk.getBookingNo();
		}
		
	}
	
	@PostMapping("/cancle.bk")
	public String cancleBooking(BookingDto bk) {
		int result = bkServiceImpl.cancleBooking(bk);
		log.debug("result:{}",result);
		if (result > 0) {

			return "redirect:booking/myBookingList";
		} else {
			return "redirect:booking/myBookingDetail?no=" + bk.getBookingNo();
		}
	}
	
	@GetMapping("/assets.list") // 자산리스트 조회 
	public void selectAssetsList() {
		
	}
	
	@PostMapping("/insert.ass") // 자산 추가 
	public void insertAssets() {
		
	}
	
}
