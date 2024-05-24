package com.mm.linkflow.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mm.linkflow.dao.EdsmProgDao;
import com.mm.linkflow.dto.DeptDto;
import com.mm.linkflow.dto.EdocDto;
import com.mm.linkflow.dto.EdocFormDto;
import com.mm.linkflow.dto.EdocHistDto;
import com.mm.linkflow.dto.EdocRefDto;
import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.dto.PageInfoDto;
import com.mm.linkflow.service.service.EdsmProgService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class EdsmProgServiceImpl implements EdsmProgService {
	
	private final EdsmProgDao edsmProgDao;
	

//	@Override
//	public int selectAllListCount() {
//		return 0;
//	}
//
//	@Override
//	public List<EdocDto> selectAllList(PageInfoDto pi) {
//		return null;
//	}

	@Override
	public List<EdocFormDto> selectFormList() {
		return edsmProgDao.selectFormList();
	}

	@Override
	public List<EdocFormDto> selectEdFrContentList(String docType) {
		return edsmProgDao.selectEdFrContentList(docType);
	}

	@Override
	public List<DeptDto> selectApprLine() {
		return edsmProgDao.selectApprLine();
	}

	
	@Override
	public int selectAllListCnt(String userId) {
		return edsmProgDao.selectAllListCnt(userId);
	}

	@Override
	public List<EdocFormDto> selectAllList(PageInfoDto pi, String userId) {
		return edsmProgDao.selectAllList(pi, userId);
	}
	
	
	@Override
	public int insertDoc(EdocDto edocDto) {
		ArrayList<EdocHistDto> edocHistList = edocDto.getEdocHistList();
		ArrayList<EdocRefDto> EdocRefList = edocDto.getEdocRefList();
		int result = 0;
		int result1 = edsmProgDao.insertDoc(edocDto); 
		int result2 =0;
		int result3 =0;
		for(EdocHistDto EdocHistDto : edocHistList) {
			
			result2 += edsmProgDao.insertEdocHist(EdocHistDto);
		}
		
		for(EdocRefDto EdocRefDto : EdocRefList) {
			
			result3 += edsmProgDao.insertRef(EdocRefDto);
		}
		
		result = result1*result2*result3;
		
		return result;
	
	}
	

	

	@Override
	public int selectSearchListCnt(Map<String, String> search) {
		return edsmProgDao.selectSearchListCnt(search);
	}

	@Override
	public List<EdocDto> selectSearchList(Map<String, String> search, PageInfoDto pi) {
		return edsmProgDao.selectSearchList(search, pi);
	}
	
	  @Override 
	 public EdocDto selectEdocDetail(String edNo) {
	  
	  //1. 기안정보조회하는 dao 호출 (dao반환타입은 EdocDto) => EdocDto doc 변수로 받기 
	  EdocDto doc = edsmProgDao.selectEdocDetail(edNo); //2. 결재이력리스트조회하는 dao호출
	 
	  //(List<EdocHistDto>) => doc.setEdocHistList(담기);
	  doc.setDocHistList(edsmProgDao.selectApprDetail(edNo));
	  
	  // dao호출 (List<ㅠㅠㅠ>) => doc.setEdocRefList(담기);
	  doc.setDocRefList(edsmProgDao.selectRefDetail(edNo)); //4. 첨부파일리스트조회하는 dao호출
	  
	  //(List<ㄴㄴㄴ>) => doc.setAttachList(담기);
	  doc.setAttachList(edsmProgDao.selectAttachDetail(edNo));
	  
	  return doc; 
	}
	 

	



}
