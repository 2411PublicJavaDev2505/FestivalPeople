package com.fepeo.boot.common.util;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Component;

@Component
public class PageUtil {
	public Map<String, Integer> generatePageInfo(int totalCount, int currentPage) {
		Map<String, Integer> pageInfo = new HashMap<String, Integer>();
		int boardLimit = 10;
		int maxPage = 0;
		if(totalCount % boardLimit != 0) {
			maxPage = totalCount / boardLimit+1; 
		}else {
			maxPage = totalCount / boardLimit;
		}
		int naviLimit = 5;
		// page: 1~5, startNavi->1,endNavi->5
		// page: 6~10, startNavi->6, endNavi->10
		// page: 11~15, startNavi->11,endNavi->15
		int startNavi = ((currentPage-1)/naviLimit)*naviLimit+1;
		int endNavi = (startNavi-1)+naviLimit;
		if(endNavi > maxPage) {
			endNavi = maxPage;
		}
		pageInfo.put("maxPage", maxPage);
		pageInfo.put("startNavi", startNavi);
		pageInfo.put("endNavi", endNavi);
		return pageInfo;		
	}
	
	public Map<String, Integer> generatePageInfo(int totalCount, int currentPage, int itemsPerPage) {
	    int maxPage = (int) Math.ceil((double) totalCount / itemsPerPage);
	    int startNavi = ((currentPage - 1) / 5) * 5 + 1;
	    int endNavi = Math.min(startNavi + 4, maxPage);

	    int startRow = (currentPage - 1) * itemsPerPage + 1;
	    int endRow = currentPage * itemsPerPage;

	    Map<String, Integer> map = new HashMap<>();
	    map.put("startNavi", startNavi);
	    map.put("endNavi", endNavi);
	    map.put("maxPage", maxPage);
	    map.put("startRow", startRow);
	    map.put("endRow", endRow);
	    return map;
	}
	
	
	
}
