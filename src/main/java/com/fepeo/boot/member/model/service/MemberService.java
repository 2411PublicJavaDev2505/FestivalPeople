package com.fepeo.boot.member.model.service;

import java.io.IOException;
import java.util.List;

import com.fepeo.boot.member.controller.dto.MemberFindIdRequest;
import com.fepeo.boot.member.controller.dto.MemberInsertRequest;
import com.fepeo.boot.member.controller.dto.MemberLoginRequest;
import com.fepeo.boot.member.controller.dto.MemberUpdatePwRequest;
import com.fepeo.boot.member.controller.dto.MemberUpdateRequest;
import com.fepeo.boot.member.model.vo.Member;

public interface MemberService {

	int insertMember(MemberInsertRequest member) throws IllegalStateException, IOException;

	Member memberLogin(MemberLoginRequest login);

	Member memberSocialLogin(String id);

	Member selectOneByNo(int memberNo);
	
	List<Member> selectMemberList(int currentPage);

	int getMemberTotalCount();

	int deleteMember(int memberNo);

	int deleteSocialMember(int memberNo);

	int updateMember(MemberUpdateRequest member) throws IllegalStateException, IOException;

	Member selectOneByEmail(MemberFindIdRequest member);

	int updateMemberPw(MemberUpdatePwRequest member);

	Member selectOneById(String memberId);

}
