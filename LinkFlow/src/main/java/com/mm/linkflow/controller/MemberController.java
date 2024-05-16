package com.mm.linkflow.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.service.service.MemberService;
import com.mm.linkflow.util.FileUtil;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/member")
@RequiredArgsConstructor
public class MemberController {
	
	private final MemberService mService;
	private final FileUtil fileUtil;
	//로그아웃
	@RequestMapping("/loginout.me")
	public String signout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	//마이페이지 유저 정보 조회 포워딩 
	@RequestMapping("/myinfo.page")
	public String mypage() {
		return "member/mypage";
	}
	//마이페이지 유저 정보 수정페이지 포워딩 
	@RequestMapping("/myinfoUpdate.page")
	public String mypageUpdate() {
		return "member/mypageUpdate";
	}
	
	//마이페이지 유저 근태현황 조회 포워딩 
	@RequestMapping("/myAttendance.page")
	public String myAttendance(Model model,HttpSession session) {
		
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		String userId = loginUser.getUserId();
		model.addAttribute("att",mService.myAttemdamce(userId));

		return "member/myAttendance";
	}
	
	//비밀번호 변경 페이지 포워딩
	@RequestMapping("/myPageUpdatePwd")
	public String myPageUpdatePwd() {
		return "member/UpdatePwd";
	}
	
	//마이페이지 정보 수정 
	@PostMapping("/updateInfo.do")
	public void update(MemberDto m, MultipartFile uploadFile,HttpSession session) {
		
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		String originUrl = loginUser.getProfileUrl();
		Map<String,String> map = fileUtil.fileUpload(uploadFile, "profile");
		
		String newProfileUrl = map.get("filePath") + "/" + map.get("filesystemName");
		loginUser.setProfileUrl(newProfileUrl);
		m.setProfileUrl(newProfileUrl);
		
		int result = mService.updateMember(m); 
		
	}
	
	//비밀번호 확인 AJAX
	@ResponseBody
	@PostMapping("/checkPassword")
	public String checkPassword(MemberDto m) {
		int result = mService.checkPassword(m);
		return result > 0 ? "YYYYY" : "NNNNN";
		
	}
	
	@PostMapping("/updateUserPassWord")
	public String updateUserPassWord(MemberDto m,HttpSession session
			  , RedirectAttributes redirectAttributes) {
		int result = mService.updatePwd(m);
		
		if (result>0) {
			redirectAttributes.addFlashAttribute("alertMsg","비밀번호 변경이 완료되었습니다.");
			session.setAttribute("loginUser", mService.loginMember(m));
		}else {
			redirectAttributes.addFlashAttribute("alertMsg","비밀번호 변경에 실패했습니다.");
		}
		return "redirect:/member/myinfo.page";
	}
	
	@ResponseBody
	@PostMapping("/serchDayoff")
	public List<MemberDto> serchDayoff(MemberDto m) {
		return mService.searchDayoff(m);
	}
		
}

