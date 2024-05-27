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
import org.springframework.web.bind.annotation.ResponseBody;
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
	
	@ResponseBody
	@GetMapping(value="/mylist.search", produces="application/json; charset=utf-8") // 나의 예약리스트 검색
	public Map<String,Object> myListSearch(@RequestParam Map<String, String> search, @RequestParam(value = "page", defaultValue = "1") int currentPage, HttpSession session) {

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
		
		Map<String,Object> mp = new HashMap<>();
		mp.put("pi",pi);
		mp.put("bkList", bkList);
		mp.put("search", search);
		
		return mp;

	}
	
	
	@GetMapping("/detail.bk") // 나의 예약 상세보기 
	public ModelAndView selectDetailMyBk(@RequestParam(value="no")String bkNo, ModelAndView mv, @RequestParam(value="sup")String supName) {
		
		BookingDto bk =  bkServiceImpl.selectDetailMyBk(bkNo);
		List<AssetsDto> assList = bkServiceImpl.selectDetailAssList(supName);
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
		
		mv.addObject("bk", bk)
		  .addObject("assList",assList)
		  .setViewName("booking/myBookingDetail");
		return mv ;
	}
	
	@ResponseBody // 예약 수정
	@PostMapping(value="/modify.bk", produces="application/json; charset=utf-8") 
	public BookingDto modifyBooking(@RequestParam Map<String,String> map) {
		BookingDto bk = new BookingDto().builder()
										.assetsName(map.get("assetsName"))
										.bkContent(map.get("bkContent"))
										.bkStartDate(map.get("bkStartDate"))
										.bkStartTime(map.get("bkStartTime"))
										.bkEndDate(map.get("bkEndDate"))
										.bkEndTime(map.get("bkEndTime"))
										.bookingNo(map.get("bookingNo"))
										.subName(map.get("subName"))
										.build();
		int result = bkServiceImpl.modifyBooking(bk);
		if(result>0) {
			return bk;
		}else {
			return null;
		}
		
	}
	
	@PostMapping("/cancle.bk") // 예약 취소
	public String cancleBooking(BookingDto bk, Model model) {
		int result = bkServiceImpl.cancleBooking(bk);
		log.debug("result:{}",result);
		
		if (result > 0) {
//			model.addAttribute("message", "삭제가 완료되었습니다.");
			return "redirect:/booking/mylist.bk";
		} else {
			return "redirect:/booking/detail.bk?no=" + bk.getBookingNo();
		}
	}
	
	@GetMapping("/ass.list") // 자산리스트 조회 
	public ModelAndView selectAssetsList(@RequestParam(value="page", defaultValue="1") int currentPage, ModelAndView mv) {
		int listCount = bkServiceImpl.selectAssCount();
		PageInfoDto pi = paging.getPageInfoDto(listCount, currentPage, 5, 10);
		List<AssetsDto> assList = bkServiceImpl.selectAssetsList(pi);
		
		mv.addObject("pi",pi)
		  .addObject("assList",assList)
		  .setViewName("booking/assetsList");
		
		return mv;
	}
	
	@ResponseBody
	@GetMapping(value="/ass.search", produces="application/json; charset=utf-8") // 자산리스트 검색
	public Map<String,Object> selectSearchAssList(@RequestParam Map<String, String> search, @RequestParam(value="page", defaultValue="1") int currentPage){
		int listCount = bkServiceImpl.selectSearchAssCount(search);
		PageInfoDto pi = paging.getPageInfoDto(listCount, currentPage, 5, 10);
		List<AssetsDto> assList = bkServiceImpl.selectSearchAssetsList(pi,search);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("pi", pi);
		map.put("assList",assList);
		
		return map;
	}
	
	@PostMapping("/ass.in") // 자산 추가 
	public String insertAssets(@RequestParam Map<String,String> assets, HttpSession session) {
		String mainCode = assets.get("updateMainCode");
		AssetsDto ass = AssetsDto.builder()
								   .assetsName(assets.get("assetsName"))
								   .mainCode(assets.get("updateMainCode"))
								   .subName(assets.get("subName"))
								   .build();
		String userId = ((MemberDto) session.getAttribute("loginUser")).getUserId();
		Map<String, Object> mp = new HashMap<>();
		mp.put("ass", ass);
		mp.put("userId", userId);
		int result = bkServiceImpl.insertAssets(mp);
		
		if(result >0) {
			return "redirect:/booking/ass.list?ain=true";
		}else {
			return "redirect:/booking/ass.list";
		}
		
	}
	@PostMapping("/ass.mod") // 자산 수정 
	public String modAssets(@RequestParam Map<String,String> assets, HttpSession session) {
		String mainCode = assets.get("updateMainCode");
		AssetsDto ass = AssetsDto.builder()
								   .assetsNo(assets.get("assetsNo"))
								   .mainCode(assets.get("updateMainCode"))
								   .assetsName(assets.get("assetsName"))
								   .subName(assets.get("subName"))
								   .build();
		String userId = ((MemberDto) session.getAttribute("loginUser")).getUserId();
		Map<String, Object> mp = new HashMap<>();
		mp.put("ass", ass);
		mp.put("userId", userId);
		
		int result = bkServiceImpl.modAssets(mp);
		log.debug("result dssadass :{}",result);
		
		if(result >0) {
			return "redirect:/booking/ass.list";
		}else {
			System.out.println("응 안 돼 돌아가~");
			return "redirect:/booking/ass.list";
		}
	}
	
	@ResponseBody // 자산 삭제
	@GetMapping(value="/ass.del", produces="application/json; charset=utf-8")
	public int deleteAssets(@RequestParam(value="assetsNo")String assetsNo) {
		return bkServiceImpl.delAssets(assetsNo);
	}
	
	@GetMapping("/sup.mng") //비품관리페이지  
	public String supBookingManager() {
		return "booking/supBookingManager";
	}
	
	@ResponseBody // 비품 예약 대기 리스트
	@GetMapping(value="/supWait.list", produces="application/json; charset=utf-8")
	public Map<String, Object> selectSupWaitList(@RequestParam(value="page", defaultValue="1") int currentPage){
		int listCount = bkServiceImpl.selectSupWaitCount();
		PageInfoDto pi = paging.getPageInfoDto(listCount, currentPage, 5, 5);
		List<BookingDto> bkWaitList = bkServiceImpl.selectSupWaitList(pi);
		
		Map<String, Object> mp = new HashMap<>();
		mp.put("pi",pi);
		mp.put("bkWaitList",bkWaitList);
		
		return mp;
	}
	
	@ResponseBody // 비품 예약 완료 리스트 + 검색
	@GetMapping(value="/supStat.list", produces="application/json; charset=utf-8")
	public Map<String, Object> selectSupStatList(@RequestParam Map<String,String> search,@RequestParam(value="page", defaultValue="1") int currentPage){
		
		int listCount = bkServiceImpl.selectSupStatusCount(search);
		PageInfoDto pi = paging.getPageInfoDto(listCount, currentPage, 5, 5);
		List<BookingDto> bkStatusList = bkServiceImpl.selectSupStatusList(pi,search);
		
		Map<String, Object> mp = new HashMap<>();
		mp.put("pi",pi);
		mp.put("bkStatusList",bkStatusList);
		
		return mp;
	}
	
	@PostMapping("/supCon.bk") // 비품예약 승인,반려 
	public String updateSupBkConfirm(@RequestParam Map<String,String> bk, HttpSession session) {
		String userId = ((MemberDto) session.getAttribute("loginUser")).getUserId();
		bk.put("userId", userId);
		log.debug("bk:{}", bk);
		int result = bkServiceImpl.updateSupBkConfirm(bk);
		
		return "redirect:/booking/sup.mng";
	}
	
	@PostMapping("/supEnd.bk") // 비품예약 승인,반려 
	public String updateSupBkReturn(@RequestParam Map<String,String> bk, HttpSession session) {
		String userId = ((MemberDto) session.getAttribute("loginUser")).getUserId();
		bk.put("userId", userId);
		log.debug("bk:{}", bk);
		int result = bkServiceImpl.updateSupBkReturn(bk);
		
		return "redirect:/booking/sup.mng";
	}
	
	
	@GetMapping("/room.mng")
	public String roomBookingManager() {
		return "booking/roomBookingManager";
	}
	
}
