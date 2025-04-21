package com.fepeo.boot.course.model.vo.dto;

import java.util.List;
import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@AllArgsConstructor
@ToString
public class Categories {

	private List<String> categories;
	private Integer festivalNo;
	
	public List<String> getCategories() {
		return categories;
	}
	public void setCategories(List<String> categories) {
		this.categories = categories;
	}
	public int getFestivalNo() {
		return festivalNo;
	}
	public void setFestivalNo(int festivalNo) {
		this.festivalNo = festivalNo;
	}
	

	
	
	
}
