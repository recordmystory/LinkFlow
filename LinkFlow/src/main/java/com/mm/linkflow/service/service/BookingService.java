package com.mm.linkflow.service.service;

import java.time.LocalDateTime;
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
    
    
    int insertBooking(Map<String,String> bk); // 예약하기 
    
    int selectSupWaitCount();  // 비품 예약 신청 리스트 
    List<BookingDto> selectSupWaitList(PageInfoDto pi);
    
    int selectSupStatusCount(Map<String,String> search); // 비품 예약 완료 리스트 + 검색  
    List<BookingDto> selectSupStatusList(PageInfoDto pi, Map<String,String> search);
    
    int updateSupBkConfirm(Map<String,String> bk); // 비품예약신청 승인반려 
    
    int updateSupBkReturn(Map<String,String> bk); // 비품 반납
    
    List<AssetsDto> modalSetDtoList(); // 예약하기 모달 세팅
    
    List<BookingDto> selectRoomWaitList(); // 시설예약 대기 리스트
    
    int updateRoomBooking(Map<String,String> bk); // 시설예약 승인,반려
    
    List<BookingDto> selectRoomBooking(Map<String,Object> rooms); // 시설예약 조회 및 필터링조회
    
    int autoRoomBkEnd(); // 시설예약 관련 스케줄러
    
    int autoCarBkUse(); // 차량예약 관련 스케줄러
}
