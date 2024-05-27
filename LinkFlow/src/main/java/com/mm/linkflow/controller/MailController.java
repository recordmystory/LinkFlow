package com.mm.linkflow.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mm.linkflow.dto.AttachDto;
import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.dto.PageInfoDto;
import com.mm.linkflow.dto.ReceiveMailDto;
import com.mm.linkflow.dto.SendMailDto;
import com.mm.linkflow.service.service.AttachService;
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
	
	private final MailService mailService;
	private final AttachService attachService;
	private final MemberService memberService;
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
	
	@GetMapping("/detail.do") 
	public String detail(int no, Model model, HttpSession session) { // 게시글 상세 조회용 (내가 작성한 게시글 클릭시 곧바로 호출 | 수정완료 후 곧바로 호출)
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		Map<String, Integer> countMap = selectSidebarCount(loginUser);
		model.addAttribute("countMap", countMap);
		model.addAttribute("mail", mailService.selectMail(no));
		return "mail/detail";
	}
	
	@GetMapping("/readMail.do")
	public String updateMailRead(int no) {
		mailService.updateMailRead(no);	
		return "redirect:/mail/detail.do?no=" + no;
	}
	
	@GetMapping("/registForm.page") 
	public ModelAndView registForm(HttpSession session, ModelAndView mv) {
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		Map<String, Integer> countMap = selectSidebarCount(loginUser);
		mv.addObject("countMap", countMap)
		  .setViewName("mail/registForm");
		return mv;
	}
	
	@PostMapping("/regist.do")
	public String regist(SendMailDto sendMail
					   , String receiveUser
					   , List<MultipartFile> uploadFiles
					   , HttpSession session
					   , RedirectAttributes redirectAttributes) {
		
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		sendMail.setRegId(String.valueOf(loginUser.getUserId()));
		sendMail.setModId(String.valueOf(loginUser.getUserId()));
		sendMail.setTempSave("02");
		String[] receivceEmailId = parseEmails(receiveUser);

		int count = memberService.selectCheckUser(receivceEmailId);
		
		if(count != receivceEmailId.length || receivceEmailId.length == 0) {
			redirectAttributes.addFlashAttribute("alertMsg", "존재하지않는 이메일입니다");
			return "redirect:/mail/registForm.page";
		}
		
		List<AttachDto> attachList = new ArrayList<>();
		if(uploadFiles != null) {
			attachList = fileUtil.setAttach(uploadFiles, "mail", loginUser, 0, "M");
			sendMail.setAttachList(attachList);
		}

		int result1 = mailService.insertSendMail(sendMail);
		int result2 = mailService.insertReceiveeMail(receivceEmailId);
		log.debug("result1 : {}", result1);
		log.debug("result2 : {}", result2);
		if((attachList.isEmpty() && result1 * result2 == receivceEmailId.length) || (!attachList.isEmpty() && result1 == attachList.size() && result1 == receivceEmailId.length)) {
			redirectAttributes.addFlashAttribute("alertMsg", "메일 전송에 성공하였습니다.");
		}else {
			redirectAttributes.addFlashAttribute("alertMsg", " 메일 전송에 실패하였습니다.");
			redirectAttributes.addFlashAttribute("histortyBackYN", "Y");
		}
		
		return "redirect:/mail/sendList.do";
	}
	
	 public static String[] parseEmails(String emails) {
        emails = emails.replace(" ", "");

        String[] emailArray = emails.split(",");

        List<String> usernameList = new ArrayList<>();

        for (String email : emailArray) {
            if (email.endsWith("@linkflow.com")) {
                String username = email.split("@")[0];
                usernameList.add(username);
            }
        }

        return usernameList.toArray(new String[0]);
    }
}
