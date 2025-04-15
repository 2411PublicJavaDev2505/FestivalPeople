package com.fepeo.boot.festival.model.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.fepeo.boot.festival.model.vo.Festival;


@Service
public interface FestivalService {
	
	public void insertFestivalList();

	public List<Festival> getFestivalList();
	
}
	
	
	


