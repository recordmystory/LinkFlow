package com.mm.linkflow.util;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;

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
		map.put("originalName", originName);
		map.put("filesystemName", filesystemName);
		
		return map;
		
	}
}
