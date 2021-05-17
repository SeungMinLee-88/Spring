package com.book_conference.memberreserve.dao;

import java.util.List;
import com.book_conference.memberreserve.dto.*;

public interface MemberReserveIDao {

	public void MemberBookWrite(String roomnum, String BOOK_MEMBER, String BOOK_TIME, String BOOK_TOTAL_TIME, String BOOK_DATE, String BOOK_REASON);

	public List<RoomDto> SelectMemberReserveList(String roomnum, String BOOK_MEMBER, String inputDate, int page);

	public int SelectMemberReserveListCount(String roomnum, String BOOK_MEMBER, String inputDate);

	public RoomDto SelectMemberBookInfo(String roomnum, String BOOK_NUM);

	public void MemberBookUpdate(String roomnum, String book_time, String book_total_time, String BOOK_DATE, String BOOK_REASON,
			String BOOK_NUM);

	public List<RoomDto> MemberReserveStatusList(String roomnum, String inputdate, int page);

	public int MemberReserveStatusListCount(String roomnum, String inputdate);

	public void MemberDeleteBook(String roomnum, String BOOK_NUM);

}
