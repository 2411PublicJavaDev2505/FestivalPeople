package com.fepeo.boot.member.model.service.logic;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.fepeo.boot.common.util.Util;
import com.fepeo.boot.member.controller.dto.MemberCodeInsertRequest;
import com.fepeo.boot.member.controller.dto.MemberFindIdRequest;
import com.fepeo.boot.member.controller.dto.MemberInsertRequest;
import com.fepeo.boot.member.controller.dto.MemberLoginRequest;
import com.fepeo.boot.member.controller.dto.MemberUpdatePwRequest;
import com.fepeo.boot.member.controller.dto.MemberUpdateRequest;
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
			member.setProfileFileRename(fileRename);
			member.setProfileFilePath(filePath);
		}
		int result = mapper.insertMember(member);
		return member.getMemberNo();
	}

	@Override
	public Member memberLogin(MemberLoginRequest login) {
		return mapper.memberLoginById(login.getMemberId());
	}

	@Override
	public Member memberSocialLogin(String id) {
		return mapper.memberSocialLogin(id);
	}

	@Override
	public Member selectOneByNo(int memberNo) {
		return mapper.selectOneByNo(memberNo);
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

	@Override
	public int deleteMember(int memberNo) {
		return mapper.deleteMember(memberNo);
	}

	@Override
	public int deleteSocialMember(int memberNo) {
		return mapper.deleteSocialMember(memberNo);
	}

	@Override
	public int updateMemberProfile(MemberUpdateRequest member) throws IllegalStateException, IOException {
		if(member.getProfile() != null && !member.getProfile().isEmpty()) {
			MultipartFile profile = member.getProfile();
			String filename = profile.getOriginalFilename();
			String fileRename = Util.fileRename(filename);
			String filePath = "/images/member/"+fileRename;
			profile.transferTo(new File("C:/uploadImage/member/"+fileRename));
			member.setProfileFileName(filename);
			member.setProfileFileRename(fileRename);
			member.setProfileFilePath(filePath);
		}else {
			Member existing = mapper.selectOneByNo(member.getMemberNo());
			member.setProfileFileName(existing.getProfileFileName());
			member.setProfileFileRename(existing.getProfileFileRename());
			member.setProfileFilePath(existing.getProfileFilePath());
		}
		return mapper.updateMemberProfile(member);
	}

	@Override
	public Member selectOneByEmail(MemberFindIdRequest member) {
		return mapper.selectOneByEmail(member);
	}

	@Override
	public int updateMemberPw(MemberUpdatePwRequest member) {
		return mapper.updateMemberPw(member);
	}

	@Override
	public Member selectOneById(String memberId) {
		return mapper.selectOneById(memberId);
	}

	@Override
	public int checkMemberById(String memberId) {
		return mapper.checkMemberById(memberId);
	}

	@Override
	public int checkMemberByNickname(String nickname) {
		return mapper.checkMemberByNickname(nickname);
	}

	@Override
	public int checkMemberEmail(String email) {
		return mapper.checkMemberEmail(email);
	}

	@Override
	public int updateMemberAddress(MemberUpdateRequest member) {
		return mapper.updateMemberAddress(member);
	}

	@Override
	public int updateMemberNickname(MemberUpdateRequest member) {
		return mapper.updateMemberNickname(member);
	}

	@Override
	public int updateMemberEmail(MemberUpdateRequest member) {
		return mapper.updateMemberEmail(member);
	}

	@Override
	public int insertMemberCode(MemberCodeInsertRequest memberCode) {
		int result = mapper.insertMemberCode(memberCode);
		int memberCodeNo = memberCode.getMemberCodeNo();
		return memberCodeNo;
	}

	@Override
	public int checkCode(MemberCodeInsertRequest memberCode) {
		return mapper.checkCode(memberCode);
	}

	@Override
	public int updateReportCount(int memberNo) {
		return mapper.updateReportCount(memberNo);
	}

}
