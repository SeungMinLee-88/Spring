package com.book_conference.member.dao;

import java.util.ArrayList;

import com.book_conference.member.dto.MemberContentDto;
import com.book_conference.member.dto.DeptContentDto;

public interface MemberIDao {

	public int ConfirmId(String id);
	
	public ArrayList<DeptContentDto> SelectDeptList(String depth, String code);

	public int SelectDeptCount(String depth,String code);
	
	public ArrayList<MemberContentDto> SelectUserList(String depcode);
	
	public int SelectUserCount(String code);
	
	public void JoinApply
	(String MEMBER_NAME, String MEMBER_DEPTNAME, String MEMBER_DEPTCODE, String MEMBER_ID, String MEMBER_PW, String EMAIL);

	public int userCheck(String MEMBER_ID, String MEMBER_PW);

	public String isAdmin(String MEMBER_ID);
	
	//public void BookWrite(String parameter, String book_time, String string, String parameter2, String parameter3);

	public MemberContentDto SelectMemberInfo(String MEMBER_ID);

	public void MemberModifyProcess(String MEMBER_NAME, String MEMBER_DEPTNAME, String MEMBER_DEPTCODE, String MEMBER_PW,
			String MEMBER_EMAIL, String MEMBER_ID);

	public int MemberFindPwProcess(String MEMBER_ID, String MEMBER_EMAIL);
	
}
