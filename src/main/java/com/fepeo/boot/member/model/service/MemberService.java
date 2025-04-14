package com.fepeo.boot.member.model.service;

import java.io.IOException;

import com.fepeo.boot.member.controller.dto.MemberInsertRequest;
import com.fepeo.boot.member.controller.dto.MemberLoginRequest;
import com.fepeo.boot.member.model.vo.Member;

public interface MemberService {

	int insertMember(MemberInsertRequest member) throws IllegalStateException, IOException;

	Member memberLogin(MemberLoginRequest login);

	Member memberSocialLogin(String id);

}
