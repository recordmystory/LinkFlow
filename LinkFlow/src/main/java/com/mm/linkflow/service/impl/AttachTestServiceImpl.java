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
		int result2 = 1;
		// attachment insert
		if(!list.isEmpty()) {
			result2 = 0;
			for(AttachDto at : list) {
				result2 += attachTestDao.insertAttach(at);
			}
		}
		return result2;
	}


	@Override
	public List<AttachDto> selectAttach(AttachDto at) {
		return attachTestDao.list(at);
	}

}
