package com.fepeo.boot.member.controller;

import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.util.Properties;

import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.WebClient;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
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
	private final Properties prop;

	@GetMapping("/login")
	public String showLogin(Model model) throws IOException {
		Reader reader = new FileReader(System.getProperty("user.dir")+"\\src\\main\\resources\\api\\api");
		prop.load(reader);
		String kakao = prop.getProperty("kakao");
		model.addAttribute("kakao",kakao);
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
		
		WebClient webClient = WebClient.create("https://kauth.kakao.com");
		String token = webClient.post().uri("/oauth/token")
				.contentType(MediaType.APPLICATION_FORM_URLENCODED)
				.body(BodyInserters.fromFormData("grant_type", "authorization_code")
						.with("client_id", "05ae1e70e0b04614496a16fb554e7110")
						.with("redirect_uri", "http://localhost:8888/member/kakao")
						.with("code", code)).retrieve()
				.bodyToMono(String.class).block();
		
		ObjectMapper mapper = new ObjectMapper();
		JsonNode root = mapper.readTree(token);
		String accessToken = root.path("access_token").asText();
		WebClient webClient2 = WebClient.create("https://kapi.kakao.com");
		String userInfo = webClient2.get()
	            .uri("/v2/user/me")
	            .header(HttpHeaders.AUTHORIZATION, "Bearer " + accessToken)
	            .retrieve()
	            .bodyToMono(String.class)
	            .block(); // 결과를 기다려서 String으로 받음
		
		JsonNode userNode = mapper.readTree(userInfo);
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
			session.setAttribute("accessToken", accessToken);
			return "redirect:/";
		}else {
			return "member/socialInsert";
		}
		
	}
	
	@GetMapping("/naver")
	public String naverLogin(@RequestParam("code") String code,
	                         @RequestParam("state") String state,
	                         HttpSession session
	                         ,Model model) throws JsonMappingException, JsonProcessingException {

	    WebClient client = WebClient.create("https://nid.naver.com");

	    String token = client.post()
	            .uri(uriBuilder -> uriBuilder.path("/oauth2.0/token")
	                    .queryParam("grant_type", "authorization_code")
	                    .queryParam("client_id", "vtFv0628kUp2Kt2meM2v")
	                    .queryParam("client_secret", "9OON4RGUOZ")
	                    .queryParam("code", code)
	                    .queryParam("state", state)
	                    .build())
	            .retrieve()
	            .bodyToMono(String.class)
	            .block();
	    
	    ObjectMapper mapper = new ObjectMapper();
		JsonNode root = mapper.readTree(token);
		String accessToken = root.path("access_token").asText();
	    
	    WebClient userClient = WebClient.create("https://openapi.naver.com");

	    String userInfo = userClient.get()
	            .uri("/v1/nid/me")
	            .header(HttpHeaders.AUTHORIZATION, "Bearer " + accessToken)
	            .retrieve()
	            .bodyToMono(String.class)
	            .block();
	    
	    JsonNode userNode = mapper.readTree(userInfo);
        String id = userNode.path("response").path("id").asText();
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
			session.setAttribute("accessToken", accessToken);
			session.setAttribute("state", state);
			return "redirect:/";
		}else {
			return "member/socialInsert";
		}
	}
	
	@GetMapping("/logout")
	public String memberLogout(HttpSession session) {
		Member member = (Member)session.getAttribute("member");
		String accessToken = (String)session.getAttribute("accessToken");
		if(accessToken != null || accessToken.trim() != "") {
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
	
	@GetMapping("/delete")
	public String showMemberDelete() {
		return "member/memberDelete";
	}
}
