package com.mm.linkflow.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.mm.linkflow.dto.AttachDto;
import com.mm.linkflow.service.impl.AttachTestServiceImpl;
import com.mm.linkflow.util.FileUtil;

import lombok.RequiredArgsConstructor;

@RequestMapping("/attachTest")
@RequiredArgsConstructor
@Controller
public class AttachTestController {
	private final AttachTestServiceImpl attachTestService;
	private final FileUtil fileUtil;
	
	@GetMapping("/insertForm.test")
	public String insertForm() {
		return "test/attachTest";
	}
	
	@PostMapping("/insert.test")
	public String insert(List<MultipartFile> uploadFiles) {
		
		List<AttachDto> attachList = new ArrayList<>();
		
		for(MultipartFile uploadFile : uploadFiles) {
			if(uploadFile != null && !uploadFile.isEmpty()) {
				// 파일 업로드
				Map<String, String> map = fileUtil.fileUpload(uploadFile, "test");
				
				// insert할 데이터 => AttachDto객체만들기 => attachList쌓기
//				attachList.add(new AttachDto("user01", "user01", 1, "B", map.get("originName"), map.get("filesystemName"), map.get("filePath")));
				attachList.add(AttachDto.builder()
						                .regId("user01")
						                .modId("user01")
						                .refNo(1)
						                .refCategory("B")
						                .originName(map.get("originName"))
						                .filesystemName(map.get("filesystemName"))
						                .filePath(map.get("filePath"))
						                .build());
				
			}
		}
		
		int result = attachTestService.insertAttach(attachList);
		return "test/attachTest";
	}
	
	@GetMapping("/list.test")
	public ModelAndView list(ModelAndView mav) {
		
		AttachDto at = AttachDto.builder()
				                .refNo(1)
				                .refCategory("B")
				                .build();
		
		List<AttachDto> attachList = attachTestService.selectAttach(at);
		
		mav.addObject("attachList", attachList)
		   .setViewName("test/attachListTest");
		
		return mav;
	}
	
}
