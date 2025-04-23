package com.fepeo.boot.festival.model.vo.dto;

import java.util.List;

public class WeatherApiResponse {
	
	public Response response;
	
	public static class Response{
		public Body body;
	}
	
	public static class Body{
		public Items items;
	}
	public static class Items{
		public List<WeatherItem> item;
	}
}
