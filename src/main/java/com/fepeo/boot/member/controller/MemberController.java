package com.fepeo.boot.member.controller;

import java.io.File;
import java.io.IOException;
import java.security.SecureRandom;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.http.HttpHeaders;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.password.PasswordEncoder;
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
import com.fepeo.boot.common.util.Util;
import com.fepeo.boot.course.model.service.CourseService;
import com.fepeo.boot.course.model.vo.Course;
import com.fepeo.boot.member.controller.dto.CustomUserDetail;
import com.fepeo.boot.member.controller.dto.MemberFindIdRequest;
import com.fepeo.boot.member.controller.dto.MemberInsertRequest;
import com.fepeo.boot.member.controller.dto.MemberLoginRequest;
import com.fepeo.boot.member.controller.dto.MemberUpdatePwRequest;
import com.fepeo.boot.member.controller.dto.MemberUpdateRequest;
import com.fepeo.boot.member.model.service.MemberService;
import com.fepeo.boot.member.model.service.logic.MailService;
import com.fepeo.boot.member.model.vo.Member;
import com.fepeo.boot.notice.model.service.logic.NoticeServiceLogic;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/member")
public class MemberController {

	private final ApiComponent api;
	private final MemberService mService;
	private final MailService mailService;
	private final PasswordEncoder passwordEncoder;
	private final CourseService courseService;

	@GetMapping("/login")
	public String showLogin(Model model
			,@RequestParam(value="fail", defaultValue = "0") int fail) throws IOException {
		model.addAttribute("fail",fail);
		String kakao = api.getKakao_client_id();
		String naver = api.getNaver_client_id();
		String google = api.getGoogle_client_id();
		model.addAttribute("kakao",kakao);
		model.addAttribute("naver",naver);
		model.addAttribute("google",google);
		return "member/login";
	}
	

	@ResponseBody
	@PostMapping("/login")
	public String memberLogin(@ModelAttribute MemberLoginRequest login) {
		JSONObject json = new JSONObject();
		int check = mService.checkMemberById(login.getMemberId());
		String checkMsg = "";
		if(check == 0) {
			checkMsg = "등록되지 않은 계정입니다.";
			json.put("checkMsg", checkMsg);
			return json.toString();
		}
		Member member = mService.memberLogin(login);
		if(member != null) {
			json.put("memberNo", member.getMemberNo());
		}else {
			checkMsg = "비밀번호가 틀렸습니다.";
		}
		json.put("checkMsg", checkMsg);
		return json.toString();
	}
	
	@GetMapping("/loginsuccess")
	public String loginSuccess(@AuthenticationPrincipal CustomUserDetail customUserDetails
			,HttpSession session) {
		Member member = customUserDetails.getMember();
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
	
	@GetMapping("/findid")
	public String showFindId() {
		return "member/findId";
	}
	
	@ResponseBody
	@PostMapping("/findid")
	public String findId(MemberFindIdRequest member) {
		SimpleMailMessage message = new SimpleMailMessage();
		Member findMember = mService.selectOneByEmail(member);
		
		JSONObject json = new JSONObject();
		
		if(findMember == null) {
			json.put("check", 0);
			return json.toString();
		}else {
			mailService.sendMail(member.getEmail(), "Festival People 아이디 찾기", "회원님의 아이디는 " + findMember.getMemberId() + " 입니다.");
			
			json.put("check", 1);
			return json.toString();
		}
	}
	
	@GetMapping("/closefindid")
	public String showCloseFindId(Model model) {
		model.addAttribute("msg","아이디");
		return "member/closeFindId";
	}
	
	@GetMapping("/findpw")
	public String showFindPw() {
		return "member/findPw";
	}
	
	@ResponseBody
	@PostMapping("/findpw")
	public String findPw(@RequestParam("memberId") String memberId) {
		
		Member findMember = mService.selectOneById(memberId);
		JSONObject json = new JSONObject();
		if(findMember == null) {
			json.put("check", 0);
			return json.toString();
		}
		
		String alphabet = "abcdefghijklmnopqrstuvwxyz";
		alphabet += alphabet.toUpperCase();
		alphabet += "0123456789";
		SecureRandom rand = new SecureRandom();
		String memberPw = "";
		for(int i=0;i<10;i++) {
			memberPw += alphabet.charAt(rand.nextInt(alphabet.length()));
		}
		MemberUpdatePwRequest member = new MemberUpdatePwRequest();
		member.setMemberId(memberId);
		member.setMemberPw(memberPw);
		int result = mService.updateMemberPw(member);
		
		String text = "비밀번호는 "+ memberPw+"입니다 \n 로그인 후 비밀번호를 변경해주세요.";
	    mailService.sendMail(findMember.getEmail(), "Festival People 비밀번호 찾기", text);
	    
	    json.put("check", 1);
		return json.toString();
	}
	
	@GetMapping("/closefindpw")
	public String showCloseFindPw(Model model) {
		model.addAttribute("msg","비밀번호");
		return "member/closeFindId";
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
		
		return "redirect:/logout";
	}
	
	@GetMapping("/insert")
	public String showMemberInsert() {
		return "member/memberInsert";
	}
	
	@PostMapping("/insert")
	public String insertMember(@ModelAttribute MemberInsertRequest member
			,@RequestParam(required=false) MultipartFile profile
			,Model model) throws IllegalStateException, IOException {
		member.setProfile(profile);
		
		if(member.getMemberPw() != null) {
			member.setMemberPw(passwordEncoder.encode(member.getMemberPw()));
		}
		
		int result = mService.insertMember(member);
		model.addAttribute("memberName",member.getMemberName());
		
		if(member.getSocialYn().equals("Y")) {
			return "member/socialInsertPopup";
		}else {
			return "redirect:/member/insertsuccess?memberName="+member.getMemberName();
		}
	}
	
	@GetMapping("/insertsuccess")
	public String showInsertSuccess(@RequestParam("memberName") String memberName
			,Model model) {
		model.addAttribute("memberName",memberName);
		return "member/insertSucess";
	}
	
	@GetMapping("/update")
	public String showMemberUpdate(HttpSession session
			,Model model) {
		Member member = (Member)session.getAttribute("member");
		member = mService.selectOneByNo(member.getMemberNo());
		model.addAttribute("member",member);
		return "member/memberUpdate";
	}
	
	@ResponseBody
	@PostMapping("/updateprofile")
	public String updateMemberProfile(@RequestParam(required=false) MultipartFile profile
			,HttpSession session) throws IllegalStateException, IOException {
		MemberUpdateRequest member = new MemberUpdateRequest();
		Member loginMember = (Member)session.getAttribute("member");
		int result = mService.updateMemberProfile(member);
		loginMember = mService.selectOneByNo(loginMember.getMemberNo());
		JSONObject json = new JSONObject();
		json.put("profile", member.getProfileFilePath());
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping("/updatepw")
	public String updateMemberPw(MemberUpdatePwRequest member) {
		member.setMemberPw(passwordEncoder.encode(member.getMemberPw()));
		int result = mService.updateMemberPw(member);
		return "비밀번호가 변경되었습니다.";
	}
	
	@ResponseBody
	@PostMapping("/updateaddress")
	public String updateMemberAddress(MemberUpdateRequest member) {
		int result = mService.updateMemberAddress(member);
		return member.getAddress();
	}
	
	@ResponseBody
	@PostMapping("/updatenickname")
	public String updateMemberNickname(MemberUpdateRequest member) {
		int result = mService.updateMemberNickname(member);
		return member.getNickname();
	}
	
	@ResponseBody
	@PostMapping("/updateemail")
	public String updateMemberEmail(MemberUpdateRequest member) {
		int result = mService.updateMemberEmail(member);
		return member.getEmail();
	}
	
	@GetMapping("/detail")
	public String showMemberDetail(HttpSession session, Model model) {
		Member member = (Member)session.getAttribute("member");
		member = mService.selectOneByNo(member.getMemberNo());
		List<CourseDto> courseList = courseService.selectCourseByNo(member.getMemberNo());
		model.addAttribute("courseList",courseList);
		System.out.println(courseList);
		model.addAttribute("member",member);
		return "member/memberDetail";
	}
	
	@GetMapping("/delete")
	public String showMemberDelete() {
		return "member/memberDelete";
	}
	
	@ResponseBody
	@PostMapping("/delete")
	public String deleteMember(MemberLoginRequest login) {
		Member member = mService.memberLogin(login);
		JSONObject json = new JSONObject();
		if(passwordEncoder.matches(login.getMemberPw(), member.getMemberPw())) {
			json.put("memberId", member.getMemberId());
			int result = mService.deleteMember(member.getMemberNo());
		}
		
		return json.toString();
	}
	
	@GetMapping("/socialdelete")
	public String deleteSocialMember(HttpSession session) {
		Member member = (Member)session.getAttribute("member");
		int result = mService.deleteSocialMember(member.getMemberNo());
		if(result > 0)
			session.invalidate();
		return "redirect:/";
	}
	
	@ResponseBody
	@GetMapping("/checkid")
	public String checkMemberId(String memberId) {
		int check = mService.checkMemberById(memberId);
		JSONObject json = new JSONObject();
		json.put("check", check);
		return json.toString();
	}
	
	@ResponseBody
	@GetMapping("/checknickname")
	public String checkMemberNickname(String nickname) {
		int check = mService.checkMemberByNickname(nickname);
		JSONObject json = new JSONObject();
		json.put("check", check);
		return json.toString();
	}
	
	@ResponseBody
	@GetMapping("/checkemail")
	public String checkMemberEmail(String email) {
		int check = mService.checkMemberEmail(email);
		JSONObject json = new JSONObject();
		json.put("check", check);
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping("/changeprofile")
	public String changeProfile(@RequestParam(required=false) MultipartFile profile) throws IllegalStateException, IOException {
		String filePath = "";
		if(profile != null && !profile.isEmpty()) {
			String filename = profile.getOriginalFilename();
			String fileRename = Util.fileRename(filename);
			filePath = "/images/member/"+fileRename;
			profile.transferTo(new File("C:/uploadImage/member/"+fileRename));
		}
		return filePath;
	}
	
	@ResponseBody
	@GetMapping("/sendcode")
	public String sendEmailCode(String email) {
		String number = "0123456789";
		SecureRandom rand = new SecureRandom();
		String code = "";
		for(int i=0;i<6;i++) {
			code += number.charAt(rand.nextInt(number.length()));
		}
		String text = "인증코드는 "+ code+"입니다.";
		mailService.sendMail(email, "Festival People 이메일 인증 코드", text);
		JSONObject json = new JSONObject();
		json.put("emailCode", code);
		return json.toString();
	}
	
}
