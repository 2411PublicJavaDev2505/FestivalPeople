package com.fepeo.boot.member.model.service.logic;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.fepeo.boot.common.util.Util;
import com.fepeo.boot.member.controller.dto.MemberInsertRequest;
import com.fepeo.boot.member.controller.dto.MemberLoginRequest;
import com.fepeo.boot.member.model.mapper.MemberMapper;
import com.fepeo.boot.member.model.service.MemberService;
import com.fepeo.boot.member.model.vo.Member;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberServiceLogic implements MemberService{
	
	private final MemberMapper mapper;
	
	@Override
	public int insertMember(MemberInsertRequest member) throws IllegalStateException, IOException {
		if(member.getProfile() != null && !member.getProfile().isEmpty()) {
			MultipartFile profile = member.getProfile();
			String filename = profile.getOriginalFilename();
			String fileRename = Util.fileRename(filename);
			String filePath = "/images/member/"+fileRename;
			profile.transferTo(new File("C:/uploadImage/member/"+fileRename));
			member.setProfileFileName(filename);
			member.setProfileFileName(fileRename);
			member.setProfileFilePath(filePath);
		}
		return mapper.insertMember(member);
	}

	@Override
	public Member memberLogin(MemberLoginRequest login) {
		return mapper.memberLogin(login);
	}

	@Override
	public Member memberSocialLogin(String id) {
		return mapper.memberSocialLogin(id);
	}

	
	@Override
	public List<Member> selectMemberList(int currentPage) {
		int limit = 10;
		int offset = (currentPage-1)* limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return mapper.selectMemberList(rowBounds);
	}

	@Override
	public int getMemberTotalCount() {
		
		return mapper.getMemberTotalCount();
	}

}
