package com.fepeo.boot.manager.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fepeo.boot.manager.model.service.ManagerService;
import com.fepeo.boot.member.model.vo.Member;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/manager")
public class ManagerController {
	
	//의존성 때문에 다음에 만들거임
//	@Autowired
//	private final ManagerService manService;
	
	
	public String showManagerPage(HttpSession session) {
		Member member = (Member)session.getAttribute("member");
		
		if(member.getManagerYn().equals("Y")) {
			return "redirect:/manager/list";
		}else if(member.getManagerYn().equals("N")) {
			return "common/error";
		} else {
			return "common/error";
		}
	}
}
