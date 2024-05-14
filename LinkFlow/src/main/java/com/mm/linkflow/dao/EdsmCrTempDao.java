package com.mm.linkflow.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mm.linkflow.dto.EdocFormDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class EdsmCrTempDao {
	private final SqlSessionTemplate sqlSessionTemplate;

	public int insertForm(EdocFormDto edsmForm) {
		return sqlSessionTemplate.insert("EdsmFormMapper.insertForm", edsmForm);
	}
}
