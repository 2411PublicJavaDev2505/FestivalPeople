package com.fepeo.boot;


import static org.assertj.core.api.Assertions.fail;
import static org.junit.jupiter.api.Assertions.assertFalse;

import java.util.List;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.fepeo.boot.festival.model.service.FestivalService;
import com.fepeo.boot.festival.model.vo.Festival;

@SpringBootTest
public class FestivalTest {
	private static final Logger LOGGER =LoggerFactory.getLogger(FestivalTest.class);
	
	@Autowired
	private FestivalService  fService;
	
	@BeforeAll
	public static void setUp() {
		LOGGER.info("테스트 시작");
	}
	
	 @Test
	    public void testInsertFestivalList() {
		 try {
	            fService.insertFestivalList(); // API 호출 및 DB 저장
	            LOGGER.info("✅ insertFestivalList 호출 완료");

	            int startRow = 1;
	            int endRow = 10;
	            List<Festival> list = fService.selectFestivalList(startRow, endRow);
	            LOGGER.info("✅ DB에서 가져온 축제 수: {}", list.size());

	            assertFalse(list.isEmpty(), "축제 리스트가 비어 있지 않아야 합니다");

	        } catch (Exception e) {
	            LOGGER.error("❌ 테스트 중 예외 발생", e);
	            fail("테스트 실패: 예외 발생");
	        }
	    }
	 
	
}
