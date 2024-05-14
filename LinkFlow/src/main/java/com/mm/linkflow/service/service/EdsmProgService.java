package com.mm.linkflow.service.service;

import java.util.List;

import com.mm.linkflow.dto.EdocDto;
import com.mm.linkflow.dto.PageInfoDto;

public interface EdsmProgService {

	int selectAllListCount();

	List<EdocDto> selectAllList(PageInfoDto pi);

}
