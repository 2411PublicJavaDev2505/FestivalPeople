package com.fepeo.boot.notice.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fepeo.boot.common.util.PageUtil;
import com.fepeo.boot.common.util.Util;
import com.fepeo.boot.notice.controller.dto.NoticeAddRequest;
import com.fepeo.boot.notice.controller.dto.NoticeUpdateRequest;
import com.fepeo.boot.notice.model.service.NoticeService;
import com.fepeo.boot.notice.model.vo.Notice;
import com.fepeo.boot.review.model.service.CommentService;
import com.fepeo.boot.review.model.service.ReviewService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/notice")
public class NoticeController {
	
	private final PageUtil pageUtil;
	private final NoticeService nService;

	@GetMapping("/list")
	public String showNoticeList(HttpSession session
			,Model model
			,@RequestParam(value="currentPage", defaultValue="1") int currentPage) {
		int totalCount = nService.getTotalCount();
		Map<String, Integer> pageInfo = pageUtil.generatePageInfo(totalCount, currentPage);
		
		List<Notice> nList = nService.selectNoticeList(currentPage);
		model.addAttribute("currentPage",currentPage);
		model.addAttribute("pageInfo",pageInfo);
		model.addAttribute("nList",nList);
		return "notice/list";
	}
	
	@GetMapping("/insert")
	public String showNoticeInsert() {
		return "notice/insert";
	}
	
	@PostMapping("/insert")
	public String insertNotice(@ModelAttribute NoticeAddRequest notice,
			MultipartFile file,
			HttpSession session,
			Model model) throws IllegalStateException, IOException {
		notice.setFile(file);
		int result = nService.insertNotice(notice);
		
		return "redirect:/notice/detail?noticeNo=" + result;
	}
	
	@GetMapping("/detail")
	public String showNoticeDetail(@RequestParam("noticeNo") int noticeNo
			,Model model) {
		Notice notice = nService.selectOneByNo(noticeNo);
		int result = nService.countNotice(noticeNo);
		model.addAttribute("notice",notice);
		return "notice/detail";
	}
	
	@GetMapping("/update")
	public String showNoticeUpdate(@RequestParam("noticeNo") int noticeNo
			,Model model) {
		Notice notice = nService.selectOneByNo(noticeNo);
		model.addAttribute("notice",notice);
		return "notice/update";
	}
	
	@ResponseBody
	@PostMapping("/updatefile")
	public String updateFile(MultipartFile file) throws IllegalStateException, IOException {
		String filePath = "";
		if(file != null && !file.isEmpty()) {
			String filename = file.getOriginalFilename();
			String fileRename = Util.fileRename(filename);
			filePath = "/images/notice/"+fileRename;
			file.transferTo(new File("C:/uploadImage/notice/"+fileRename));
		}
		return filePath;
	}
	
	@PostMapping("/update")
	public String updateNotice(@ModelAttribute NoticeUpdateRequest notice
			,MultipartFile file,
			HttpSession session) throws IllegalStateException, IOException {
		notice.setFile(file);
		int result = nService.updateNotice(notice);
		return "redirect:/notice/detail?noticeNo="+notice.getNoticeNo();
	}
	
	@GetMapping("/delete")
	public String deleteNotice(@RequestParam("noticeNo") int noticeNo) {
		int result = nService.deleteNotice(noticeNo);
		return "redirect:/notice/list";
	}
	
}
