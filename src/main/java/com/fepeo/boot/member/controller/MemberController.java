package com.fepeo.boot.member.controller;

import java.io.IOException;
import java.util.Map;

import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.reactive.function.client.WebClient;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fepeo.boot.common.controller.api.ApiComponent;
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

	private final ApiComponent api;
	
	private final MemberService mService;

	@GetMapping("/login")
	public String showLogin(Model model) throws IOException {
		String kakao = api.getKakao_client_id();
		String naver = api.getNaver_client_id();
		String google = api.getGoogle_client_id();
		model.addAttribute("kakao",kakao);
		model.addAttribute("naver",naver);
		model.addAttribute("google",google);
		return "member/login";
	}
	
	@PostMapping("/login")
	public String memberLogin(@ModelAttribute MemberLoginRequest login
			,HttpSession session) {
		Member member = mService.memberLogin(login);
		session.setAttribute("member", member);
		return "redirect:/";
	}
	
	@GetMapping("/kakao")
	public String kakaoLogin(@RequestParam("code") String code
			,Model model
			,HttpSession session) throws JsonMappingException, JsonProcessingException {
		
	
		Map<String, String> loginMap = api.kakaoLogin(code);
		
		ObjectMapper mapper = new ObjectMapper();
		JsonNode userNode = mapper.readTree(loginMap.get("userInfo"));
        String id = "kakao_"+userNode.path("id").asText();
        String nickname = userNode.path("kakao_account")
                                  .path("profile")
                                  .path("nickname").asText();
        String email = userNode.path("kakao_account").path("email").asText();
        String profileUrl = userNode.path("kakao_account")
					                .path("profile")
					                .path("profile_image_url").asText();
		
		model.addAttribute("id",id);
		model.addAttribute("nickname",nickname);
		model.addAttribute("email",email);
		model.addAttribute("profileUrl",profileUrl);
		
		Member member = mService.memberSocialLogin(id);
		if(member != null) {
			session.setAttribute("member", member);
			session.setAttribute("accessToken", loginMap.get("accessToken"));
			return "member/successPopup";
		}else {
			return "member/socialInsert";
		}
		
	}
	
	@GetMapping("/naver")
	public String naverLogin(@RequestParam("code") String code,
	                         @RequestParam("state") String state,
	                         HttpSession session
	                         ,Model model) throws JsonMappingException, JsonProcessingException {



		Map<String, String> loginMap = api.naverLogin(code, state);
	    
	    ObjectMapper mapper = new ObjectMapper();
	    JsonNode userNode = mapper.readTree(loginMap.get("userInfo"));
        String id = "naver_"+userNode.path("response").path("id").asText();
        String nickname = userNode.path("response").path("nickname").asText();
        String email = userNode.path("response").path("email").asText();
        String profileUrl = userNode.path("response").path("profile_image").asText();
        
        Member member = mService.memberSocialLogin(id);
        model.addAttribute("id",id);
        model.addAttribute("nickname",nickname);
        model.addAttribute("email",email);
        model.addAttribute("profileUrl",profileUrl);
	    
	    
	    if(member != null) {
			session.setAttribute("member", member);
			session.setAttribute("accessToken", loginMap.get("accessToken"));
			session.setAttribute("state", state);
			return "member/successPopup";
		}else {
			return "member/socialInsert";
		}
	}
	
	@GetMapping("/google")
	public String googleLogin(@RequestParam("code") String code, Model model
			,HttpSession session) throws JsonMappingException, JsonProcessingException {
	    

		Map<String, String> loginMap = api.googleLogin(code);
		
		ObjectMapper mapper = new ObjectMapper();
		JsonNode userNode = mapper.readTree(loginMap.get("userInfo"));
        String id = "google_" + userNode.path("id").asText();
        String nickname = userNode.path("name").asText();
        String email = userNode.path("email").asText();
        String profileUrl = userNode.path("picture").asText();
        
        Member member = mService.memberSocialLogin(id);
        model.addAttribute("id",id);
        model.addAttribute("nickname",nickname);
        model.addAttribute("email",email);
        model.addAttribute("profileUrl",profileUrl);
	    
	    
	    if(member != null) {
			session.setAttribute("member", member);
			session.setAttribute("accessToken", loginMap.get("accessToken"));
			return "member/successPopup";
		}else {
			return "member/socialInsert";
		}
		
	}
	
	
	@GetMapping("/logout")
	public String memberLogout(HttpSession session) {
		
		Member member = (Member)session.getAttribute("member");
		String accessToken = (String)session.getAttribute("accessToken");
		
		if(accessToken != null && member.getMemberId().split("_")[0].equals("kakao")) {

			WebClient client = WebClient.create("https://kapi.kakao.com");
	        String response = client.post()
	                .uri("/v1/user/logout")
	                .header(HttpHeaders.AUTHORIZATION, "Bearer " + accessToken)
	                .retrieve()
	                .bodyToMono(String.class)
	                .block();
		}
		
		if(member != null) {
			session.invalidate();
		}
		
		return "redirect:/";
	}
	
	@GetMapping("/insert")
	public String showMemberInsert() {
		return "member/memberInsert";
	}
	
	@PostMapping("/insert")
	public String insertMember(@ModelAttribute MemberInsertRequest member
			,@RequestParam(required=false) MultipartFile profile) throws IllegalStateException, IOException {
		member.setProfile(profile);
		int result = mService.insertMember(member);
		return "member/insertSucess";
	}
	
	@GetMapping("/detail")
	public String showMemberDetail(HttpSession session, Model model) {
		Member member = (Member)session.getAttribute("member");
		member = mService.selectOneByNo(member.getMemberNo());
		model.addAttribute("member",member);
		return "member/memberDetail";
	}
	
	@GetMapping("/delete")
	public String showMemberDelete() {
		return "member/memberDelete";
	}
	
	@ResponseBody
	@RequestMapping("/delcheck")
	public String deleteMember(String pw) {
		System.out.println("확인");
		System.out.println("확인");
		System.out.println("확인");
		System.out.println("확인");
		System.out.println("확인");
		return "AJAX";
	}
}
