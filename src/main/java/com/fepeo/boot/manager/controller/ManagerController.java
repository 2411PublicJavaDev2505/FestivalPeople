package com.fepeo.boot.manager.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fepeo.boot.common.util.PageUtil;
import com.fepeo.boot.manager.model.service.ManagerService;
import com.fepeo.boot.member.model.service.MemberService;
import com.fepeo.boot.member.model.vo.Member;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/manager")
public class ManagerController {
	

	@Autowired
	private final MemberService mService;
	
	@Autowired
	private PageUtil pageutil;
	
	@GetMapping("/mypage")
	public String showMemberList(HttpSession session, 
			@RequestParam(value="currentPage", defaultValue="1") int currentPage,
			Model model) {
		
		Member member = (Member)session.getAttribute("member");
		if(member.getManagerYn().equals("Y")) {

			int totalCount = mService.getMemberTotalCount();
			System.out.println(totalCount);
			Map<String, Integer> pageInfo = pageutil.generatePageInfo(totalCount, currentPage);
			System.out.println(pageInfo);
			List<Member> mList = mService.selectMemberList(currentPage);
			model.addAttribute("mList", mList);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("pageInfo", pageInfo);
			int maxPage = 0;
			pageInfo.get(maxPage);
			System.out.println(maxPage);
			
			
			
			session.setAttribute("mList", mList);
			return "/manager/list";
			
		}else if(member.getManagerYn().equals("N")) {
			return "/common/error";
		} else {
			return "/common/error";
		}
	}
}
