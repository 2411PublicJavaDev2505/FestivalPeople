package com.fepeo.boot.member.model.service.logic;

import org.springframework.stereotype.Service;

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
	public int insertMember(MemberInsertRequest member) {
		return mapper.insertMember(member);
	}

	@Override
	public Member memberLogin(MemberLoginRequest login) {
		return mapper.memberLogin(login);
	}

}
