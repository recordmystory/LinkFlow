package com.mm.linkflow.service.service;

import java.util.List;
import java.util.Map;

import com.mm.linkflow.dto.AttachDto;

public interface AttachTestService {
	
	int insertAttach(List<AttachDto> list);
	
	List<AttachDto> selectAttach(int refNo, String refCategory);
	
	int delete(String[] delFileNo);
}
