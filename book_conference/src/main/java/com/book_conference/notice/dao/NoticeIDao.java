package com.book_conference.notice.dao;

import java.util.ArrayList;
import java.util.List;
import com.book_conference.notice.dto.*;


public interface NoticeIDao {

	public List<NoticeDto> SelectNoticeList(String NOTICE_TITLE, String NOTICE_WRITER, int page);

	public int SelectNoticeCount(String searchtype, String searchkeyword, int page);

	public List<NoticeDto> SelectNoticeTopList();

	public void NoticeWriteProcess(String NOTICE_TITLE, String NOTICE_CONTENT, String NOTICE_WRITER, String NOTICE_TOP);

	public NoticeDto SelectNoticeInfo(String NOTICE_NUM);

	public void NoticeHitCountIncrese(String NOTICE_NUM);

	public void NoticeModifyProcess(String parameter, String parameter2, String memberid, String nOTICE_TOP, String notice_number);

	public void NoticeDelete(String NOTICE_NUM);

}
