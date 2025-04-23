package com.fepeo.boot.common.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import com.fepeo.boot.member.controller.dto.CustomUserDetail;
import com.fepeo.boot.member.model.service.logic.CustomUserDetailsService;
import com.fepeo.boot.member.model.service.logic.MemberServiceLogic;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@EnableWebSecurity
@Configuration
public class WebSecurityConfig {

	private final CustomUserDetailsService customUserDetailsService;
	
	@Bean
	public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
		http.authorizeHttpRequests(auth -> auth.anyRequest().permitAll())
		.formLogin(form -> form.loginPage("/member/login")
				.defaultSuccessUrl("/member/loginsuccess",true)
				.permitAll())
		.logout(logout -> logout
				.logoutUrl("/member/logout")
				.logoutSuccessUrl("/"));
		return http.build();
	}
	
	@Bean
	public UserDetailsService userDetailsService() {
		return customUserDetailsService;
	}
	
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
}
