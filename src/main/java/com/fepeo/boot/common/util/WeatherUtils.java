package com.fepeo.boot.common.util;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
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
}
