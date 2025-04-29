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
        Map<String, Integer> map = new HashMap<>();

        // 기본값 세팅
        if (itemsPerPage <= 0) {
            itemsPerPage = 8; 
        }

        int maxPage = (int) Math.ceil((double) totalCount / itemsPerPage);

        // maxPage가 0이면 currentPage를 1로 고정
        if (maxPage == 0) {
            currentPage = 1;
        } else {
            if (currentPage > maxPage) {
                currentPage = maxPage;
            }
            if (currentPage < 1) {
                currentPage = 1;
            }
        }

        // 네비게이션 범위 설정 (5개 단위)
        int naviSize = 5;
        int startNavi = ((currentPage - 1) / naviSize) * naviSize + 1;
        int endNavi = Math.min(startNavi + naviSize - 1, maxPage);

        // 시작, 끝 Row 계산 (DB용)
        int startRow = (currentPage - 1) * itemsPerPage + 1;
        int endRow = currentPage * itemsPerPage;

        // Map에 담아서 리턴
        map.put("startNavi", startNavi);
        map.put("endNavi", endNavi);
        map.put("maxPage", maxPage);
        map.put("startRow", startRow);
        map.put("endRow", endRow);
        map.put("currentPage", currentPage); // 최종 currentPage

        return map;
    }


	
}
