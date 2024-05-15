package com.mm.linkflow.service.service;


import java.util.List;

import com.mm.linkflow.dto.EdocFormDto;
import com.mm.linkflow.dto.PageInfoDto;

public interface EdsmCrTempService {
	// 양식 등록
	int insertForm(EdocFormDto edsmForm);

	int selectCrTempListCnt();

	List<EdocFormDto> selectCrTempList(PageInfoDto pi);
}
