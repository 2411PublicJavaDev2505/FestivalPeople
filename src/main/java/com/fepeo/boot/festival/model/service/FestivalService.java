package com.fepeo.boot.festival.model.service;

import java.util.List;

import com.fepeo.boot.festival.model.vo.dto.FestivalItem;

public interface FestivalService {
    List<FestivalItem> getFestivalList();
}
