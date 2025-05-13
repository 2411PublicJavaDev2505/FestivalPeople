package com.fepeo.boot.member.model.service.logic;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.fepeo.boot.member.controller.dto.CustomUserDetail;
import com.fepeo.boot.member.model.mapper.MemberMapper;
import com.fepeo.boot.member.model.vo.Member;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService{

	private final MemberMapper mapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		System.out.println(username);
		Member member = mapper.memberLoginById(username);
		System.out.println(member);
		if(member == null) {
			throw new UsernameNotFoundException("사용자를 찾을 수 없습니다.");
		}
		return new CustomUserDetail(member);
	}

}
