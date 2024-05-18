package com.mm.linkflow.util;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.mm.linkflow.dto.AttachDto;
import com.mm.linkflow.dto.MemberDto;

@Component
public class FileUtil {
	public Map<String, String> fileUpload(MultipartFile uploadFile, String folderName){
		
		String filePath = "/upload/" + folderName + new SimpleDateFormat("/yyyy/MM/dd").format(new Date());
		
		File filePathDir = new File(filePath);
		if(!filePathDir.exists()) {
			filePathDir.mkdirs();
		}
		
		String originName = uploadFile.getOriginalFilename();
		String ext = originName.endsWith(".tar.gz") ? ".tar.gz" 
													  : originName.substring(originName.lastIndexOf("."));
		String filesystemName = UUID.randomUUID().toString().replace("-", "") + ext;
		
		try {
			uploadFile.transferTo(new File(filePathDir, filesystemName));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		
		Map<String, String> map = new HashMap<>();
		map.put("filePath", filePath);
		map.put("originName", originName);
		map.put("filesystemName", filesystemName);
		
		return map;
		
	}
	
	/**
	 * AttachDto 설정
	 * @param uploadFiles : 첨부파일
	 * @param folderName : 저장할 경로 / Board / Edoc / Member 등등 테이블 따르게
	 * @param member : 로그인한 유저 Dto / update시 regId 변경x 
	 * @param refNo : insert는 0 update 테이블에 맞는 번호
	 * @param refString : b: Board / E : 전자결재 / 추가하면 여기에 업데이트하셈
	 * @return : AttachDto List
	 */
	public List<AttachDto> setAttach(List<MultipartFile> uploadFiles, 
									 String folderName,
									 MemberDto member,
									 int refNo,
									 String refString) {
		
		List<AttachDto> attachList = new ArrayList<>();
		
		for(MultipartFile uploadFile : uploadFiles) {
			if(uploadFile != null && !uploadFile.isEmpty()) {
				// 파일 업로드
				Map<String, String> map = fileUpload(uploadFile, folderName);
				
				attachList.add(AttachDto.builder()
						                .regId(member.getUserId())
						                .modId(member.getUserId())
						                .refCategory(refString)
						                .originName(map.get("originName"))
						                .filesystemName(map.get("filesystemName"))
						                .filePath(map.get("filePath"))
						                .build());
			}
		}
		
		
		return attachList;
	}
		
}
