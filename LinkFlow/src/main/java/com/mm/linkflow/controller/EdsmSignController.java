package com.mm.linkflow.controller;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.util.Base64;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.service.service.EdsmSignService;
import com.mm.linkflow.util.FileUtil;

import lombok.RequiredArgsConstructor;

@RequestMapping("/edsm/sign")
@Controller
@RequiredArgsConstructor
public class EdsmSignController {
	
	private final EdsmSignService edsmSignService;
	private final FileUtil fileUtil;
	
	/** 기본 이미지로 서명 설정
	 * 
	 * @param uploadFile
	 * @param session
	 * @return SUCCESS | FAIL
	 * 
	 * @author 김지우
	 */
	@ResponseBody
	@PostMapping("/modifySignDefault.sg")
	public String modifySignDefault(MultipartFile uploadFile, HttpSession session, RedirectAttributes redirectAttributes) {
		MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
		String originalSignUrl = loginUser.getSignUrl();
		
		Map<String, String> map = fileUtil.fileUpload(uploadFile, "sign");
		loginUser.setSignUrl(map.get("filePath") + "/" + map.get("filesystemName"));
		
		int result = edsmSignService.uploadSignImg(loginUser);
		
		if(result > 0) {
			if(originalSignUrl != null) {
				new File(originalSignUrl).delete();
			}
			return "SUCCESS";
		} else {
			new File(map.get("filePath") + "/" + map.get("filesystemName")).delete();
			return "FAIL";
		}
	}
	
	/** 모달 내에서 마우스로 그려 서명 설정 (Canvas API)
	 * 
	 * @param uploadFile
	 * @param session
	 * @return SUCCESS | FAIL
	 * 
	 * @author 김지우
	 */
	@ResponseBody
	@PostMapping("/modifySignCanvas.sg")
	public String ajaxModifySignCanvas(MultipartFile uploadFile, HttpSession session) {
		MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
		String originalSignUrl = loginUser.getSignUrl();
		
		Map<String, String> map = fileUtil.fileUpload(uploadFile, "sign");
		loginUser.setSignUrl(map.get("filePath") + "/" + map.get("filesystemName"));
		
		int result = edsmSignService.uploadSignImg(loginUser);
		
		if(result > 0) {
			if(originalSignUrl != null) {
				new File(originalSignUrl).delete();
			}
			return "SUCCESS";
		} else {
			new File(map.get("filePath") + "/" + map.get("filesystemName")).delete();
			return "FAIL";
		}
	}
	
	/** 선택한 파일로 서명 설정
	 * 
	 * @param uploadFile
	 * @param session
	 * @return SUCCESS | FAIL
	 * 
	 * @author 김지우
	 */
	@ResponseBody
	@PostMapping("/modifySignFile.sg")
	public String ajaxModifySign(MultipartFile uploadFile, HttpSession session) {
		MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
		String originalSignUrl = loginUser.getSignUrl();
		
		Map<String, String> map = fileUtil.fileUpload(uploadFile, "sign");
		loginUser.setSignUrl(map.get("filePath") + "/" + map.get("filesystemName"));
		
		int result = edsmSignService.uploadSignImg(loginUser);
		
		if(result > 0) {
			if(originalSignUrl != null) {
				new File(originalSignUrl).delete();
			}
			return "SUCCESS";
		} else {
			new File(map.get("filePath") + "/" + map.get("filesystemName")).delete();
			return "FAIL";
		}
	}
	
	/** 서명 설정 페이지로 이동
	 * 
	 * @return /edsm/sign/setting
	 * 
	 * @author 김지우
	 */
	@GetMapping("/setting.sg")
	public String listAll() {
		return "/edsm/sign/setting";
	}
	
}
