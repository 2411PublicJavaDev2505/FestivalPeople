package com.fepeo.boot.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MemberController {

	@GetMapping("/member/login")
	public String showLogin() {
		return "member/login";
	}
	
	@GetMapping("/member/insert")
	public String showMemberInsert() {
		return "member/memberInsert";
	}
	
	@GetMapping("/member/delete")
	public String showMemberDelete() {
		return "member/memberDelete";
	}
}
