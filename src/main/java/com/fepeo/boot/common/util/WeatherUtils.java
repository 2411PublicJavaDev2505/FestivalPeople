package com.fepeo.boot.common.util;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class WeatherUtils {
	
		public static Map<String, String> getWeatherBaseDateTime(String baseTime) {
	        LocalDate today = LocalDate.now();
	        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyyMMdd");

	        Map<String, String> result = new HashMap<>();
	        result.put("baseDate", today.format(dateFormatter));
	        result.put("baseTime", baseTime); // "0500" 고정
	        return result;
	    }
		
		public static List<String> getNext3Days() {
	        List<String> days = new ArrayList<>();
	        LocalDate today = LocalDate.now();
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
	        for (int i = 0; i < 3; i++) {
	            days.add(today.plusDays(i).format(formatter));
	        }
	        return days;
	    }
}
