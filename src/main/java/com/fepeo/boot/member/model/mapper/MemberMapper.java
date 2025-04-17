package com.fepeo.boot.member.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.fepeo.boot.member.controller.dto.MemberFindIdRequest;
import com.fepeo.boot.member.controller.dto.MemberInsertRequest;
import com.fepeo.boot.member.controller.dto.MemberLoginRequest;
import com.fepeo.boot.member.controller.dto.MemberUpdatePwRequest;
import com.fepeo.boot.member.controller.dto.MemberUpdateRequest;
import com.fepeo.boot.member.model.vo.Member;

@Mapper
public interface MemberMapper {

	int insertMember(MemberInsertRequest member);

	Member memberLogin(MemberLoginRequest login);

	Member memberSocialLogin(String id);

	Member selectOneByNo(int memberNo);
	
	List<Member> selectMemberList(RowBounds rowBounds);

	int getMemberTotalCount();

	int deleteMember(int memberNo);

	int deleteSocialMember(int memberNo);

	int updateMemberProfile(MemberUpdateRequest member);

	int updateSocialMember(MemberUpdateRequest member);

	Member selectOneByEmail(MemberFindIdRequest member);

	int updateMemberPw(MemberUpdatePwRequest member);

	Member selectOneById(String memberId);

	int checkMemberById(String memberId);

	int checkMemberByNickname(String nickname);

	int checkMemberEmail(String email);

}
