package com.mm.linkflow.controller;

import java.io.File;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/member")
@RequiredArgsConstructor
public class MemberController {
	
	private final MemberService mService;
	private final FileUtil fileUtil;
	private final BCryptPasswordEncoder bcryptPwdEncoder;
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
	public String update(MemberDto m, MultipartFile uploadFile, HttpSession session, RedirectAttributes redirectAttributes) {

	    MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
	    String originName = loginUser.getProfileUrl();

	    if (uploadFile != null && !uploadFile.isEmpty()) {
	      
	        Map<String, String> map = fileUtil.fileUpload(uploadFile, "profile");
	        String newProfileUrl = map.get("filePath") + "/" + map.get("filesystemName");
	        m.setProfileUrl(newProfileUrl);

	        int result = mService.updateMember(m);

	        if (result > 0) {
	            redirectAttributes.addFlashAttribute("alertMsg", "성공적으로 정보수정 되었습니다.");
	            session.setAttribute("loginUser", mService.loginMember(m));
	        } else {
	            redirectAttributes.addFlashAttribute("alertMsg", "정보수정에 실패하였습니다.");
	        }
	    } else {
	       
	        m.setProfileUrl(originName);  

	        int result = mService.updatInfoeMember(m);

	        if (result > 0) {
	            redirectAttributes.addFlashAttribute("alertMsg", "성공적으로 정보수정 되었습니다.");
	            session.setAttribute("loginUser", mService.loginMember(m));
	        } else {
	            redirectAttributes.addFlashAttribute("alertMsg", "정보수정에 실패하였습니다.");
	        }
	    }

	    return "redirect:/member/myinfo.page";
	}
	
	//프로필 삭제 AJAX 
	@ResponseBody
	@PostMapping("/modifyProfile")
	private String modifyProfile(HttpSession session) {
		MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
		String originFileUrl = loginUser.getProfileUrl();
		
		int result =mService.deleteProfill(loginUser);
		
		if(result > 0) {
	         if(originFileUrl != null) {
	            new File(originFileUrl).delete();
	         }
	         return "SUCCESS";
	      }else {
	        
	         return "FAIL";
	      }

	}
	
	//비밀번호 확인 AJAX
	@ResponseBody
	@PostMapping("/checkPassword")
	public String checkPassword(String userId, String userPwd) {

		
		String userOldPwd = mService.SerchPwd(userId);
		
		 
		if(bcryptPwdEncoder.matches(userPwd, userOldPwd)) { return "YYYYY"; }else {
		return "NNNNN"; }
		
		
		
	}
	
	@PostMapping("/updateUserPassWord")
	public String updateUserPassWord(MemberDto m, HttpSession session
			  , RedirectAttributes redirectAttributes) {
		m.setUserPwd(bcryptPwdEncoder.encode(m.getUserPwd()));
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

