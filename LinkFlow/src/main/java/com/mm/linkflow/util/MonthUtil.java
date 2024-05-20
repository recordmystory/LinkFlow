package com.mm.linkflow.util;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import org.springframework.stereotype.Component;

@Component
public class MonthUtil {
	
	public String monthReturn(int no) {
		
		LocalDate currentDate = LocalDate.now();
        LocalDate month = currentDate.minusMonths(no);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("YYYY-MM");
        
        return month.format(formatter);
        
	}
}
