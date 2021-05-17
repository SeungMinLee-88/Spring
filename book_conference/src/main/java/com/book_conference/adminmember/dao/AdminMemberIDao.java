package com.book_conference.adminmember.dao;
import java.util.ArrayList;
import java.util.List;

import com.book_conference.adminmember.dto.*;
import com.book_conference.member.dto.MemberContentDto;

public interface AdminMemberIDao {

	public ArrayList<ApplyContentDto> SelectApplyList(int page);
	
	public int SelectApplyListCount(int page);
	
	public ApplyContentDto SelectApply(String page);

	public void UpdateApply(String status, String APPLY_NUM);

	public void ApproveApply(String APPLY_NUM);

	public List<MemberContentDto> SelectMemberList(String memdept, String memname, String memid, int page);

	public int SelectMemberCount(String memdept, String memname, String memid);

	public void DeleteMember(String member_number);
	
}
