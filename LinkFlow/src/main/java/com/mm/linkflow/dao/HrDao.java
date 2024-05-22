package com.mm.linkflow.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mm.linkflow.dto.BoardCategoryDto;
import com.mm.linkflow.dto.CommonTableDto;
import com.mm.linkflow.dto.DeptDto;
import com.mm.linkflow.dto.MemberDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class HrDao {
	private final SqlSessionTemplate sql;

	public List<MemberDto> selectMemberList() {
		// TODO Auto-generated method stub
		return sql.selectList("hrMapper.selectMemberList");
	}

	public List<MemberDto> searhMemberList(String keyword) {
		// TODO Auto-generated method stub
		return sql.selectList("hrMapper.searhMemberList",keyword);
	}

	public List<DeptDto> selectDeftList() {
		// TODO Auto-generated method stub
		return sql.selectList("hrMapper.selectDeftList");
	}

	public List<CommonTableDto> selectCommonTableList() {
		// TODO Auto-generated method stub
		return sql.selectList("hrMapper.selectCommonTableList");
	}

	public int insertMember(MemberDto m) {
		// TODO Auto-generated method stub
		return sql.insert("hrMapper.insertMember",m);
	}

	public int checkId(String checkId) {
		return sql.selectOne("hrMapper.checkId",checkId);
	}

	public MemberDto selectDatailMember(String id) {
		return sql.selectOne("hrMapper.selectDatailMember",id);
	}

	public int updateInfoMember(MemberDto m) {
		return sql.update("hrMapper.updateInfoMember",m);
	}

	public int resetPasswoard(MemberDto m) {
		return sql.update("hrMapper.resetPasswoard",m);
	}

	public int goRetire(MemberDto m) {
		return sql.update("hrMapper.goRetire",m);
	}

	public int goJoinPathy(MemberDto m) {
		return sql.update("hrMapper.goJoinPathy",m);
	}

	public int insertDept(DeptDto d) {
		return sql.insert("hrMapper.insertDept",d);
	}

	public int insertCategory(BoardCategoryDto bd) {
		return sql.insert("hrMapper.insertCategory",bd);
	}

	public int updateDeptTable(DeptDto d) {
		return sql.update("hrMapper.updateDeptTable",d);
	}

	public int updateDept(BoardCategoryDto bd) {
		return sql.update("hrMapper.updateDept",bd);
	}

	public int deleteDept(BoardCategoryDto bd) {
		return sql.update("hrMapper.deleteDept",bd);
	}

	public int DeleteDeptTable(DeptDto d) {
		return sql.update("hrMapper.DeleteDeptTable",d);
	}

	public int checkCode(String deptCode) {
		return sql.selectOne("hrMapper.checkCode",deptCode);
	}

	
	
	
}
