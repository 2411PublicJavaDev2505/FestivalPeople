package com.fepeo.boot.course.model.vo.dto;

import java.util.List;

import lombok.Data;

@Data
public class CourseForm {
	private List<PlaceDto> places;
	
	public List<PlaceDto> getPlaces() {
		return places;
	}
	
	public void setPlaces(List<PlaceDto> places) {
		this.places = places;
	}
	
}
