package com.mm.linkflow.service.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.mm.linkflow.dto.AssetsDto;
import com.mm.linkflow.dto.BookingDto;
import com.mm.linkflow.dto.PageInfoDto;

public interface BookingService {

	
	int selectBkCount(String userId); //예약리스트 페이징 
	List<BookingDto> selectMyBkList(PageInfoDto pi, String userId); // 나의 예약 리스트
	
	int selectSupCount(); // 비품페이징 
	List<AssetsDto> selectSuppliesList(PageInfoDto pi); // 비품 리스트
	
	List<AssetsDto> selectAssetsList(PageInfoDto pi); // 자산 리스트 
	
	int insertAssets(AssetsDto ass); // 자산 추가 
	
	int modssets(AssetsDto ass); // 자산 수정 
	
	int delAssets(int assetsNo); // 자산 삭제
	
    int selectBkUseCount(); // 사용가능 비품 페이징 
    List<AssetsDto> selectSupUse(PageInfoDto pi); // 사용가능 비품 리스트  
    
    int searchBkCount(Map<String,String> search); // 검색한 비품 페이징
    List<AssetsDto> selectSearchSupList(PageInfoDto pi,Map<String,String> search); // 검색한 비품 리스트 
    
    int insertBooking(BookingDto bk); // 예약하기 
    
    int modBooking(BookingDto bk); // 예약 수정 
    
    BookingDto selectDetailBk(BookingDto bk); // 예약 상세보기
    
}
