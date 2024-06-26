package com.mm.linkflow.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.mm.linkflow.dao.AttachDao;
import com.mm.linkflow.dto.AttachDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class AttachServiceImpl implements com.mm.linkflow.service.service.AttachService {
	
	private final AttachDao attachDao;
	
	
	// insert할 첨부파일 리스트 넘겨주기
	@Override
	public int insertAttach(List<AttachDto> list) {
		int result = 0;
		// attachment insert
		if(!list.isEmpty()) {
			for(AttachDto at : list) {
				result += attachDao.insertAttach(at);
			}
		}
		return result;
	}

	
	// 조회할 첨부파일의 참조번호, 참조타입 넘겨주기
	@Override
	public List<AttachDto> selectAttach(int refNo, String refCategory) {
	 	AttachDto at = AttachDto.builder()
		         				.refNo(refNo)
		         				.refCategory(refCategory)
		         				.build();
		return attachDao.list(at);
	}

	
	// 삭제할 첨부파일의 파일번호 넘겨주기
	@Override
	public List<AttachDto> selectDelFileList(String[] delFileNo) {
		return delFileNo != null ? attachDao.selectDelFileList(delFileNo)
				 : new ArrayList<AttachDto>();
	}


	@Override
	public int deleteAttach(String[] delFileNo) {
		return attachDao.deleteAttach(delFileNo);
	}

}
