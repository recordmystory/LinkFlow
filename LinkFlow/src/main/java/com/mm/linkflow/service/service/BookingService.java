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
	
	int selectMySearchCount(Map<String,String> search);
	List<BookingDto> selectMySearchList(Map<String,String> search, PageInfoDto pi);
	
	List<AssetsDto> selectDetailAssList(String supName);
	BookingDto selectDetailMyBk(String bkNo); // 나의 예약 상세보기
	
	int modifyBooking(BookingDto bk); // 예약 수정
	
	int cancleBooking(BookingDto bk); // 예약 취소
	
	int selectSupCount(); // 비품페이징 
	List<AssetsDto> selectSuppliesList(PageInfoDto pi); // 비품 리스트
	
	int searchBkCount(Map<String,String> search); // 검색한 비품 페이징
    List<AssetsDto> selectSearchSupList(PageInfoDto pi,Map<String,String> search); // 검색한 비품 리스트 
    
    int selectAssCount();
	List<AssetsDto> selectAssetsList(PageInfoDto pi); // 자산 리스트 
	
	int selectSearchAssCount(Map<String,String> search);
	List<AssetsDto> selectSearchAssetsList(PageInfoDto pi,Map<String,String> search); // 자산 리스트 
	
	int insertAssets(Map<String,Object> mp); // 자산 추가 
	
	int modAssets(Map<String,Object> mp); // 자산 수정 
	
	int delAssets(String assetsNo); // 자산 삭제
    
    
    int insertBooking(BookingDto bk); // 예약하기 
    
    int modBooking(BookingDto bk); // 예약 수정 
    
    int selectSupWaitCount();  // 비품 예약 신청 리스트 
    List<BookingDto> selectSupWaitList(PageInfoDto pi);
    
    int selectSupStatusCount(Map<String,String> search); // 비품 예약 완료 리스트 + 검색  
    List<BookingDto> selectSipStatusList(PageInfoDto pi, Map<String,String> search);
    
    
    
}
