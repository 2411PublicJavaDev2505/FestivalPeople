package com.fepeo.boot.member.model.service;

import com.fepeo.boot.member.controller.dto.MemberInsertRequest;
import com.fepeo.boot.member.controller.dto.MemberLoginRequest;
import com.fepeo.boot.member.model.vo.Member;

public interface MemberService {

	int insertMember(MemberInsertRequest member);

	Member memberLogin(MemberLoginRequest login);

}
