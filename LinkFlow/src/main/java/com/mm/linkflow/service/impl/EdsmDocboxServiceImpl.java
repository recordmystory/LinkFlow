package com.mm.linkflow.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.mm.linkflow.dao.EdsmDocboxDao;
import com.mm.linkflow.dto.EdocDto;
import com.mm.linkflow.dto.PageInfoDto;
import com.mm.linkflow.service.service.EdsmDocboxService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class EdsmDocboxServiceImpl implements EdsmDocboxService {
	private final EdsmDocboxDao edsmDocboxDao;

	@Override
	public int selectDocboxListCnt(String userId) {
		return edsmDocboxDao.selectDocboxListCnt(userId);
	}

	@Override
	public List<EdocDto> selectDocboxList(PageInfoDto pi, String userId) {
		return edsmDocboxDao.selectDocboxList(pi, userId);
	}

	@Override
	public int selectSearchListCnt(Map<String, String> search) {
		return edsmDocboxDao.selectSearchListCnt(search);
	}

	@Override
	public List<EdocDto> selectSearchList(Map<String, String> search, PageInfoDto pi) {
		return edsmDocboxDao.selectSearchList(search, pi);
	}

	@Override
	public EdocDto selectEdocDetail(String edNo) {
		EdocDto doc = edsmDocboxDao.selectEdocDetail(edNo); // 2. 결재이력리스트조회하는 dao호출

		// (List<EdocHistDto>) => doc.setEdocHistList(담기);
		doc.setDocHistList(edsmDocboxDao.selectApprDetail(edNo));

		// dao호출 (List<ㅠㅠㅠ>) => doc.setEdocRefList(담기);
		doc.setDocRefList(edsmDocboxDao.selectRefDetail(edNo)); // 4. 첨부파일리스트조회하는 dao호출

		return doc;
	}
}
