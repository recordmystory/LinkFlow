package com.mm.linkflow.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mm.linkflow.dto.MemberDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class EdsmSignDao {
	private final SqlSessionTemplate sqlSessionTemplate;
	
	public int uploadSignImg(MemberDto m) {
		return sqlSessionTemplate.update("memberMapper.uploadSignImg", m);
	}

}
