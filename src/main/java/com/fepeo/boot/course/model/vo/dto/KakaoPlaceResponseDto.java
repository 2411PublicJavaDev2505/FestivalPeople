package com.fepeo.boot.course.model.vo.dto;

import java.util.List;

import lombok.AllArgsConstructor;

@AllArgsConstructor
public class KakaoPlaceResponseDto {
	private List<PlaceDto> documents;
	
	public List<PlaceDto> getDocuments() {
		return documents;
	}
	
}
