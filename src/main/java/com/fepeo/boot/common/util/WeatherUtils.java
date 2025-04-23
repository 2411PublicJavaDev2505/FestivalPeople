package com.fepeo.boot.common.util;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

public class WeatherUtils {
	
	public static Map<String, String> getWeatherBaseDateTime(){
		LocalDateTime now = LocalDateTime.now();
		
		String baseDate = now.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        String baseTime;

        int hour = now.getHour();

        if (hour < 2) {
            baseDate = now.minusDays(1).format(DateTimeFormatter.ofPattern("yyyyMMdd"));
            baseTime = "2300";
        } else if (hour < 5) {
            baseTime = "0200";
        } else if (hour < 8) {
            baseTime = "0500";
        } else if (hour < 11) {
            baseTime = "0800";
        } else if (hour < 14) {
            baseTime = "1100";
        } else if (hour < 17) {
            baseTime = "1400";
        } else if (hour < 20) {
            baseTime = "1700";
        } else if (hour < 23) {
            baseTime = "2000";
        } else {
            baseTime = "2300";
        }
        
		Map<String, String> result = new HashMap<>();
		result.put("baseDate", baseDate);
		result.put("baseTime", baseTime);
		return result;
	}
}
