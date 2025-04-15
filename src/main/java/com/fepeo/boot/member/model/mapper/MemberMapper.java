package com.fepeo.boot.member.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.fepeo.boot.member.controller.dto.MemberInsertRequest;
import com.fepeo.boot.member.controller.dto.MemberLoginRequest;
import com.fepeo.boot.member.model.vo.Member;

@Mapper
public interface MemberMapper {

	int insertMember(MemberInsertRequest member);

	Member memberLogin(MemberLoginRequest login);

	Member memberSocialLogin(String id);

	List<Member> selectMemberList(RowBounds rowBounds);

	int getMemberTotalCount();

}
