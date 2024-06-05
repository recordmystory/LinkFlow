package com.mm.linkflow.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mm.linkflow.dto.AttachDto;
import com.mm.linkflow.dto.BoardDto;
import com.mm.linkflow.dto.DeptDto;
import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.dto.PageInfoDto;
import com.mm.linkflow.dto.ReceiveMailDto;
import com.mm.linkflow.dto.SendMailDto;
import com.mm.linkflow.service.service.AttachService;
import com.mm.linkflow.service.service.HrService;
import com.mm.linkflow.service.service.MailService;
import com.mm.linkflow.service.service.MemberService;
import com.mm.linkflow.util.FileUtil;
import com.mm.linkflow.util.PagingUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/mail")
@RequiredArgsConstructor
@Controller
public class MailController {
	@Autowired
	private JavaMailSender mailSender;
	
	private final MailService mailService;
	private final AttachService attachService;
	private final MemberService memberService;
	private final HrService hService;
	private final PagingUtil pagingUtil;
	private final FileUtil fileUtil;
	
	private Map<String, Integer> selectSidebarCount(MemberDto loginUser) {
		
		Map<String, Integer> map = new HashMap<>();
		
		int nonReadCount = mailService.selectNonReadCount(loginUser);
		int trashCount = mailService.selectTrashCount(loginUser);
		
		map.put("readCount", nonReadCount);
		map.put("trashCount", trashCount);
		
		return map;
	}
	
	@GetMapping("/receiveList.do")
	public ModelAndView recevieList(HttpSession session,
							@RequestParam(value="page", defaultValue="1")int currentPage,
							ModelAndView mv) {
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		int listCount = mailService.selectReceiveListCount(loginUser);
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 5, 10);
		
		List<ReceiveMailDto> receiveMailList = mailService.selectReceiveList(pi, loginUser);
		
		Map<String, Integer> countMap = selectSidebarCount(loginUser);
		
		mv.addObject("pi", pi)
		  .addObject("countMap",countMap)
		  .addObject("receiveMailList", receiveMailList)
		  .setViewName("mail/receiveList");
		return mv;
	}
	
	@GetMapping("/sendList.do")
	public ModelAndView sendList(HttpSession session,
							@RequestParam(value="page", defaultValue="1")int currentPage,
							ModelAndView mv) {
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		int listCount = mailService.selectSendListCount(loginUser);
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 5, 10);
		
		List<SendMailDto> sendMailList = mailService.selectSendList(pi, loginUser);
		
		Map<String, Integer> countMap = selectSidebarCount(loginUser);
		
		mv.addObject("pi", pi)
		  .addObject("countMap",countMap)
		  .addObject("sendMailList", sendMailList)
		  .setViewName("mail/sendList");
		
		return mv;
	}
	
	@GetMapping("/detail.page") 
	public String detail(int no, Model model, HttpSession session) { // 게시글 상세 조회용 (내가 작성한 게시글 클릭시 곧바로 호출 | 수정완료 후 곧바로 호출)
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		Map<String, Integer> countMap = selectSidebarCount(loginUser);
		model.addAttribute("countMap", countMap);
		model.addAttribute("mail", mailService.selectMail(no));
		return "mail/detail";
	}
	
	@GetMapping("/readMail.do")
	public String updateMailRead(int no, HttpSession session) {
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		Map<String, Object> map = new HashMap<>();
		map.put("no", no);
		map.put("userId", loginUser.getUserId());
		mailService.updateMailRead(map);
		return "redirect:/mail/detail.page?no=" + no;
	}
	
	@GetMapping("/registForm.page") 
	public ModelAndView registForm(HttpSession session, ModelAndView mv) {
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		Map<String, Integer> countMap = selectSidebarCount(loginUser);
		List<DeptDto> apprList = hService.selectApprLine();
		mv.addObject("countMap", countMap)
		  .addObject("apprList", apprList)
		  .setViewName("mail/registForm");
		return mv;
	}
	
	@PostMapping("/regist.do")
	public String regist(SendMailDto sendMail
					   , String receiveUser
					   , List<MultipartFile> uploadFiles
					   , HttpSession session
					   , RedirectAttributes redirectAttributes) throws Exception {
		
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		sendMail.setRegId(String.valueOf(loginUser.getUserId()));
		sendMail.setModId(String.valueOf(loginUser.getUserId()));
		sendMail.setReceiver(receiveUser);
		sendMail.setTempSave("02");
		Map<String, String[]> map = parseEmails(receiveUser);
		String[] receivceEmailId = null;
		String[] externalEmail = null;
		log.debug("receivceEmailId : {}", receivceEmailId);
		log.debug("externalEmail : {}", externalEmail);
		if(!ObjectUtils.isEmpty(map.get("userNameList"))) {
			receivceEmailId = map.get("userNameList");
		}
		if(!ObjectUtils.isEmpty(map.get("externalEmail"))) {
			externalEmail = map.get("externalEmail");
		}
		
		int count = 0;
		if(ObjectUtils.isEmpty(receivceEmailId) && ObjectUtils.isEmpty(externalEmail)) {
			redirectAttributes.addFlashAttribute("alertMsg", "error1 : 존재하지않는 이메일입니다");
			return "redirect:/mail/registForm.page";
		}
		
		if(!ObjectUtils.isEmpty(receivceEmailId)) {
			count = memberService.selectCheckUser(receivceEmailId);
			if(count != receivceEmailId.length || count == 0) {
				redirectAttributes.addFlashAttribute("alertMsg", "error2 : 존재하지않는 이메일입니다");
				return "redirect:/mail/registForm.page";
			}
		}
		
		List<AttachDto> attachList = new ArrayList<>();
		if(uploadFiles != null) {
			attachList = fileUtil.setAttach(uploadFiles, "mail", loginUser, 0, "M");
			sendMail.setAttachList(attachList);
		}

		int result1 = mailService.insertSendMail(sendMail);
		
		if(!ObjectUtils.isEmpty(externalEmail)) {
			boolean check =sendExternalMail(sendMail, externalEmail, uploadFiles);
		}
		
		int result2 = 1;
		if(!ObjectUtils.isEmpty(receivceEmailId)) {
			result2 = mailService.insertReceiveMail(receivceEmailId);			
		}

		if((attachList.isEmpty() && result1 * result2 > 0) || 
		  (!attachList.isEmpty() && result1 == attachList.size() && result2 > 0)) {
			redirectAttributes.addFlashAttribute("alertMsg", "메일 전송에 성공하였습니다.");
		}else {
			redirectAttributes.addFlashAttribute("alertMsg", " 메일 전송에 실패하였습니다.");
			redirectAttributes.addFlashAttribute("histortyBackYN", "Y");
		}
		
		return "redirect:/mail/sendList.do";
	}
	
	 public static Map<String, String[]> parseEmails(String emails) {
        emails = emails.replace(" ", "");

        String[] emailArray = emails.split(",");
        
        List<String> userNameList = new ArrayList<>();
        List<String> externalEmail = new ArrayList<>();
        
        Map<String, String[]> map = new HashMap<>();
        
        for (String email : emailArray) {
            if (email.endsWith("@linkflow.com")) {
                String username = email.split("@")[0];
                userNameList.add(username);
            }else if(email.endsWith("@gmail.com")) {
            	externalEmail.add(email);
            }
        }
        if(emailArray.length != userNameList.size() + externalEmail.size()) {
        	return null;
        }
        map.put("userNameList",  userNameList.toArray(new String[0]));
        map.put("externalEmail", externalEmail.toArray(new String[0]));

        return map;
    }
	 
	 @ResponseBody
	 @PostMapping("/insertTempSave.do")
	 public int insertTempSave(SendMailDto sendMail
							   , String receiveUser
							   , List<MultipartFile> uploadFiles
							   , HttpSession session
							   , RedirectAttributes redirectAttributes) {
		
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		sendMail.setRegId(String.valueOf(loginUser.getUserId()));
		sendMail.setModId(String.valueOf(loginUser.getUserId()));
		sendMail.setTempSave("01");

		
		List<AttachDto> attachList = new ArrayList<>();
		if(uploadFiles != null) {
			attachList = fileUtil.setAttach(uploadFiles, "mail", loginUser, 0, "M");
			sendMail.setAttachList(attachList);
		}

		int result = mailService.insertSendMail(sendMail);
		int mailNo = 0;
		 
		 if(result > 0) {
			 mailNo = mailService.selectCurrnetTempSave();
		 }
		 
		 return mailNo;
	}
	 
	@GetMapping("/tempSaveDetail.page") 
	public String tempSaveDetail(int no, Model model, HttpSession session) { // 게시글 상세 조회용 (내가 작성한 게시글 클릭시 곧바로 호출 | 수정완료 후 곧바로 호출)
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		Map<String, Integer> countMap = selectSidebarCount(loginUser);
		List<DeptDto> apprList = hService.selectApprLine();
		model.addAttribute("countMap", countMap);
		model.addAttribute("apprList", apprList);
		model.addAttribute("mail", mailService.selectMail(no));
		return "mail/tempSaveRegist";
	}
	
	@ResponseBody
	@PostMapping("/tempSaveUpdate.do")
	public String tempSaveUpdate(SendMailDto mail, String[] delFileNo
							   , List<MultipartFile> uploadFiles
							   , HttpSession session) {
		
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		mail.setModId(loginUser.getUserId());
		mail.setTempSave("01");

		List<AttachDto> delFileList = attachService.selectDelFileList(delFileNo);
		
		
		List<AttachDto> attachList = new ArrayList<>();
		if(uploadFiles != null) {
			attachList = fileUtil.setAttach(uploadFiles, "mail", loginUser, mail.getMailNo(), "M");
			mail.setAttachList(attachList);
		}
		int result = mailService.updateTempSaveMail(mail, delFileNo);
		
		if (result > 0) {
			for(AttachDto at : delFileList) {
				new File(at.getFilePath() + "/" + at.getFilesystemName()).delete();
			}
		}
		return result > 0 ? "SUCCESS" : "FAIL";
	}
	
	@GetMapping("/tempSave.page")
	public String tempSaveForm(Model model, HttpSession session
							, @RequestParam(value="page", defaultValue="1")int currentPage) { // 게시글 상세 조회용 (내가 작성한 게시글 클릭시 곧바로 호출 | 수정완료 후 곧바로 호출)
		
		
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		Map<String, Integer> countMap = selectSidebarCount(loginUser);
		int listCount = mailService.selectTempSaveListCount(loginUser.getUserId());
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 5, 10);
		
		List<BoardDto> tempSaveList = mailService.selectTempSaveList(pi, loginUser.getUserId());
		
		
		model.addAttribute("pi", pi);
		model.addAttribute("countMap", countMap);
		model.addAttribute("tempSaveList", tempSaveList);
		return "mail/tempSave";
	}
	
	@PostMapping("/registTempSave.do")
	public String registTempSave(SendMailDto sendMail
					   , String receiveUser, String[] delFileNo
					   , List<MultipartFile> uploadFiles
					   , HttpSession session
					   , RedirectAttributes redirectAttributes) throws Exception {
		
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		sendMail.setRegId(String.valueOf(loginUser.getUserId()));
		sendMail.setModId(String.valueOf(loginUser.getUserId()));
		sendMail.setReceiver(receiveUser);
		sendMail.setTempSave("02");
		Map<String, String[]> map = parseEmails(receiveUser);
		String[] receivceEmailId = map.get("userNameList");
		String[] externalEmail = map.get("externalEmail");
		
		
		int count = 0;
		if(ObjectUtils.isEmpty(receivceEmailId) && ObjectUtils.isEmpty(externalEmail)) {
			redirectAttributes.addFlashAttribute("alertMsg", "error1 : 존재하지않는 이메일입니다");
			return "redirect:/mail/registForm.page";
		}
		
		if(!ObjectUtils.isEmpty(receivceEmailId)) {
			count = memberService.selectCheckUser(receivceEmailId);
			if(count != receivceEmailId.length || count == 0) {
				redirectAttributes.addFlashAttribute("alertMsg", "error2 : 존재하지않는 이메일입니다");
				return "redirect:/mail/registForm.page";
			}
		}
		
		List<AttachDto> delFileList = attachService.selectDelFileList(delFileNo);
		
		List<AttachDto> attachList = new ArrayList<>();
		if(uploadFiles != null) {
			attachList = fileUtil.setAttach(uploadFiles, "mail", loginUser, sendMail.getMailNo(), "M");
			sendMail.setAttachList(attachList);
		}

		int result1 = mailService.updateTempSaveMail(sendMail, delFileNo);
		int result2 = 1;
		
		if(!ObjectUtils.isEmpty(externalEmail)) {
			boolean check =sendExternalMail(sendMail, externalEmail, uploadFiles);
		}
		
		if(!ObjectUtils.isEmpty(receivceEmailId)) {
			mailService.insertTempSaveReceiveMail(sendMail.getMailNo(), receivceEmailId);			
		}

		if((attachList.isEmpty() && result1 * result2 > 0) || (!attachList.isEmpty() && result1 == attachList.size() && result2 > 0)) {
			for(AttachDto at : delFileList) {
				new File(at.getFilePath() + "/" + at.getFilesystemName()).delete();
			}
			redirectAttributes.addFlashAttribute("alertMsg", "메일 전송에 성공하였습니다.");
		}else {
			redirectAttributes.addFlashAttribute("alertMsg", " 메일 전송에 실패하였습니다.");
			redirectAttributes.addFlashAttribute("histortyBackYN", "Y");
		}
		
		return "redirect:/mail/detail.page?no=" + sendMail.getMailNo();
	}
	
	
	@GetMapping("/delete.do") 
	public String delete(@RequestParam(value = "no")List<Integer> no
					   , HttpSession session
				       , RedirectAttributes redirectAttributes) {
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		HashMap <String, Object> map = new HashMap<>();
		map.put("userId", loginUser.getUserId());
		map.put("mailNoList", no);
		int result = mailService.deleteMail(map);

		if(result > 0) {
			redirectAttributes.addFlashAttribute("alertMsg", "삭제에 성공하였습니다.");
		}else {
			redirectAttributes.addFlashAttribute("alertMsg", " 삭제에 실패하였습니다.");
			redirectAttributes.addFlashAttribute("histortyBackYN", "Y");
		}
		
		return "redirect:/mail/receiveList.do?page=1";
	}
	
	@GetMapping("/trash.page")
	public String trashForm(Model model, HttpSession session
						  , @RequestParam(value="page", defaultValue="1")int currentPage) { 
		
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		Map<String, Integer> countMap = selectSidebarCount(loginUser);
		int listCount = countMap.get("trashCount");
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 5, 10);
		
		List<ReceiveMailDto> trashList = mailService.selectTrashList(pi, loginUser.getUserId());
		
		
		model.addAttribute("pi", pi);
		model.addAttribute("countMap", countMap);
		model.addAttribute("trashList", trashList);
		return "mail/trash";
	}
	
	@GetMapping("/reStore.do") 
	public String reStore(@RequestParam(value = "no")List<Integer> no
					   , HttpSession session
				       , RedirectAttributes redirectAttributes) {
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		HashMap <String, Object> map = new HashMap<>();
		map.put("userId", loginUser.getUserId());
		map.put("mailNoList", no);
		int result = mailService.reStoreMail(map);

		if(result > 0) {
			redirectAttributes.addFlashAttribute("alertMsg", "복구에 성공하였습니다.");
		}else {
			redirectAttributes.addFlashAttribute("alertMsg", " 복구에 실패하였습니다.");
			redirectAttributes.addFlashAttribute("histortyBackYN", "Y");
		}
		
		return"redirect:/mail/trash.page";
	}
	
	@GetMapping("/remove.do") 
	public String removeList(@RequestParam(value = "no")List<Integer> no
						, HttpServletRequest request
				        , RedirectAttributes redirectAttributes) {

		int result = mailService.removeMail(no);

		if(result > 0) {
			redirectAttributes.addFlashAttribute("alertMsg", "삭제에 성공하였습니다.");
		}else {
			redirectAttributes.addFlashAttribute("alertMsg", " 삭제에 실패하였습니다.");
			redirectAttributes.addFlashAttribute("histortyBackYN", "Y");
		}
		
		return "redirect:" + request.getHeader("referer");
	}
	
	@GetMapping("/removeTempSave.do") 
	public String removeTempSave(@RequestParam(value = "no")List<Integer> no
						, HttpServletRequest request
				        , RedirectAttributes redirectAttributes) {

		int result = mailService.removeTempSave(no);

		if(result > 0) {
			redirectAttributes.addFlashAttribute("alertMsg", "삭제에 성공하였습니다.");
		}else {
			redirectAttributes.addFlashAttribute("alertMsg", " 삭제에 실패하였습니다.");
			redirectAttributes.addFlashAttribute("histortyBackYN", "Y");
		}
		
		return "redirect:" + request.getHeader("referer");
	}
	
	@GetMapping("/receiveSearch.do")
	public ModelAndView receiveSearch(
					   @RequestParam(value="page", defaultValue="1") int currentPage,
					   @RequestParam Map<String, String> search,
					   HttpSession session,
					   ModelAndView mv) {
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		Map<String, Integer> countMap = selectSidebarCount(loginUser);
		search.put("userId", loginUser.getUserId());
		search.put("type", "R");
		int listCount = mailService.selectSearchCount(search);
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 5, 10);
		
		List<SendMailDto> receiveMailList = mailService.selectSearchList(pi, search);
		
		mv.addObject("pi", pi)
		  .addObject("receiveMailList", receiveMailList)
		  .addObject("countMap", countMap)
		  .addObject("search", search)
		  .setViewName("mail/receiveList");
		
		return mv;
	}
	
	@GetMapping("/sendSearch.do")
	public ModelAndView sendSearch(
					   @RequestParam(value="page", defaultValue="1") int currentPage,
					   @RequestParam Map<String, String> search,
					   HttpSession session,
					   ModelAndView mv) {
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		Map<String, Integer> countMap = selectSidebarCount(loginUser);
		search.put("userId", loginUser.getUserId());
		search.put("type", "S");
		int listCount = mailService.selectSearchCount(search);
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 5, 10);
		
		List<SendMailDto> sendMailList = mailService.selectSearchList(pi, search);
		
		mv.addObject("pi", pi)
		  .addObject("sendMailList", sendMailList)
		  .addObject("countMap", countMap)
		  .addObject("search", search)
		  .setViewName("mail/sendList");
		
		return mv;
	}
	
    public boolean sendExternalMail(SendMailDto sendMail, String[] externalEmail, List<MultipartFile> uploadFiles) throws Exception{
        
    	boolean result = true;
    	
        String subject = sendMail.getMailTitle();
        String content = sendMail.getMailContent();
        String from = "lingkeupeullou@gmail.com";
        String to = externalEmail[0];
        
        try {
            MimeMessage mail = mailSender.createMimeMessage();
            MimeMessageHelper mailHelper = new MimeMessageHelper(mail,true,"UTF-8");
            
            mailHelper.setFrom(from);
            mailHelper.setTo(to);
            mailHelper.setSubject(subject);
            mailHelper.setText(content, true);

        	for (MultipartFile file : uploadFiles) {
        		if(!file.getOriginalFilename().isEmpty()) {
        			mailHelper.addAttachment(file.getOriginalFilename(), file);
        		}
        	}
            
            mailSender.send(mail);
            
        } catch(Exception e) {
            e.printStackTrace();
            result = false;
        }
        log.debug("외부메일 발송 체크 : {}", result);
        return result;
    }
}
