package com.mm.linkflow.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.SuperBuilder;

@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class MemberDto extends CommonDto {
	private String userId; //아이디
	private String userPwd; //비밀번호
	private String deptCode; //부서코드
	private String position; //직급
	private String userName; //이름
	private String phone; //연락처
	private String birthDate; //생년월일
	private String education; // 최종학력
    private String address; // 주소 
	private String zipCode; // 우편번호
	private String detailAdd; // 상세주소(EX: 몇호)
	private String hireDate; //입사일
	private String retireDate; //퇴사일 
	private String superRight; // 슈퍼권한 
	private String hrRight; //인사권한 
	private String spRight; //경영권한 
    private String boardRight; //게시판 권한 
	private String deptRight; // 부서권한 
	private String profileUrl; // 프로필이미지 경로 
	private String signUrl; // 전자결제 서명 경로 
	private int dayOff; // 연차갯수
	private String secondaryCode; // 2차인증 사용코드  
	private String secondaryUsese; //2차 인증 사용 여부 
	private String rankBcode; // 직급대분류 코드 
	private String rankScode; //직급소분류 코드 
	private int serviceYear; // 근속년수
	private String deptName; // 부서이름
	private String yearWalkDay; // 올해 근무 일수 
	private String yearWalktime; // 올해 근무시간 
	private int yearlateCount; // 올해 지각횟수
	private int yearAbsentCount; // 올해 결석횟수
	private String monthWalkDay; //이번달 근무 일수 
	private String monthWalktime; // 이번달 근무시간 
	private int monthlateCount; // 이번달 지각횟수
	private int monthAbsentCount; // 이번달 결석횟수
	private String dayoffStartsearch; // 연차사용 검색 시작날
	private String dayoffendsearch; // 연차사용 검색 끝날
	private int dayOffCount; //휴가 일수
	
}
