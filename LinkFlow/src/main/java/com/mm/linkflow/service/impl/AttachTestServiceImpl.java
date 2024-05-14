package com.mm.linkflow.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.mm.linkflow.dao.AttachTestDao;
import com.mm.linkflow.dto.AttachDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class AttachTestServiceImpl implements com.mm.linkflow.service.service.AttachTestService {
	
	private final AttachTestDao attachTestDao;
	

	@Override
	public int insertAttach(List<AttachDto> list) {
		int result = 0;
		// attachment insert
		if(!list.isEmpty()) {
			for(AttachDto at : list) {
				result += attachTestDao.insertAttach(at);
			}
		}
		return result;
	}


	@Override
	public List<AttachDto> selectAttach(int refNo, String refCategory) {
	 	AttachDto at = AttachDto.builder()
		         				.refNo(refNo)
		         				.refCategory(refCategory)
		         				.build();
		return attachTestDao.list(at);
	}


	@Override
	public int delete(String[] delFileNo) {
		return attachTestDao.delete(delFileNo);
	}

}
