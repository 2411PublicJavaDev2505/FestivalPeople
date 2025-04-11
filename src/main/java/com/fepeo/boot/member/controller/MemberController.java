package com.fepeo.boot.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fepeo.boot.member.controller.dto.MemberInsertRequest;
import com.fepeo.boot.member.controller.dto.MemberLoginRequest;
import com.fepeo.boot.member.model.service.MemberService;
import com.fepeo.boot.member.model.vo.Member;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/member")
public class MemberController {

	private final MemberService mService;
	
	@GetMapping("/login")
	public String showLogin() {
		return "member/login";
	}
	
	@PostMapping("/login")
	public String memberLogin(@ModelAttribute MemberLoginRequest login
			,HttpSession session) {
		Member member = mService.memberLogin(login);
		session.setAttribute("member", member);
		return "redirect:/";
	}
	
	@GetMapping("/insert")
	public String showMemberInsert() {
		return "member/memberInsert";
	}
	
	@PostMapping("/insert")
	public String insertMember(@ModelAttribute MemberInsertRequest member) {
		int result = mService.insertMember(member);
		return "member/insertSucess";
	}
	
	@GetMapping("/delete")
	public String showMemberDelete() {
		return "member/memberDelete";
	}
}
