package com.book_conference.adminreserve.dao;

import java.util.List;

import com.book_conference.adminreserve.dto.*;

public interface AdminReserveIDao {

	public List<RoomDto> RoomBookList(String roomnum, String inputDate);

	public String RoomBookTotalList(String roomnum, String inputDate);

	public String BookRestrictStatus(String roomnum, String inputDate);

	public void RestrictBookStatus(String roomnum, String inputDate);

	public void ReleaseRestrictBookStatus(String roomnum, String inputDate);

	public void BookWrite(String roomnum, String BOOK_MEMBER, String BOOK_TIME, String BOOK_TOTAL_TIME, String BOOK_DATE, String BOOK_REASON);

	public List<RoomDto> SelectReserveList(String roomnum, String inputDate, int page);

	public int SelectReserveListCount(String roomnum, String inputDate);

	public RoomDto SelectBookInfo(String roomnum, String BOOK_NUM);

	public void BookUpdate(String roomnum, String BOOK_TIME, String BOOK_TOTAL_TIME, String BOOK_DATE, String BOOK_REASON,
			String BOOK_MEMBER, String BOOK_NUM);

	public List<RoomDto> ReserveStatusList(String roomnum, String inputdate, int page);

	public int ReserveStatusListCount(String roomnum, String inputdate);

	public void DeleteBook(String roomnum, String BOOK_NUM);

}
