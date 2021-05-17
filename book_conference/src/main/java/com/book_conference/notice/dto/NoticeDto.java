package com.book_conference.notice.dto;

import java.sql.Date;

public class NoticeDto {
	private int NOTICE_NUM;
	private String NOTICE_TITLE;
	private String NOTICE_WRITER;
	private String NOTICE_CONTENT;
	private int NOTICE_HIT;
	private String NOTICE_TOP;
	private Date CREATE_DATE;
	private Date UPDATE_DATE;
	private String RNUM;
	
	public NoticeDto() {
		// TODO Auto-generated constructor stub
	}
	
	public NoticeDto(int NOTICE_NUM, String NOTICE_TITLE, String NOTICE_WRITER
			, String NOTICE_CONTENT, int NOTICE_HIT, String NOTICE_TOP, Date CREATE_DATE
			,Date UPDATE_DATE,String RNUM) {
		this.NOTICE_NUM = NOTICE_NUM;
		this.NOTICE_TITLE = NOTICE_TITLE;
		this.NOTICE_WRITER = NOTICE_WRITER;
		this.NOTICE_CONTENT = NOTICE_CONTENT;
		this.NOTICE_HIT =  NOTICE_HIT;
		this.NOTICE_TOP = NOTICE_TOP;
		this.CREATE_DATE = CREATE_DATE;
		this.UPDATE_DATE = UPDATE_DATE;
		this.RNUM = RNUM;
	}

	public int getNOTICE_NUM() {
		return NOTICE_NUM;
	}

	public void setNOTICE_NUM(int nOTICE_NUM) {
		NOTICE_NUM = nOTICE_NUM;
	}

	public String getNOTICE_TITLE() {
		return NOTICE_TITLE;
	}

	public void setNOTICE_TITLE(String nOTICE_TITLE) {
		NOTICE_TITLE = nOTICE_TITLE;
	}

	public String getNOTICE_WRITER() {
		return NOTICE_WRITER;
	}

	public void setNOTICE_WRITER(String nOTICE_WRITER) {
		NOTICE_WRITER = nOTICE_WRITER;
	}

	public String getNOTICE_CONTENT() {
		return NOTICE_CONTENT;
	}

	public void setNOTICE_CONTENT(String nOTICE_CONTENT) {
		NOTICE_CONTENT = nOTICE_CONTENT;
	}

	public int getNOTICE_HIT() {
		return NOTICE_HIT;
	}

	public void setNOTICE_HIT(int nOTICE_HIT) {
		NOTICE_HIT = nOTICE_HIT;
	}

	public String getNOTICE_TOP() {
		return NOTICE_TOP;
	}

	public void setNOTICE_TOP(String nOTICE_TOP) {
		NOTICE_TOP = nOTICE_TOP;
	}

	public Date getCREATE_DATE() {
		return CREATE_DATE;
	}

	public void setCREATE_DATE(Date cREATE_DATE) {
		CREATE_DATE = cREATE_DATE;
	}

	public Date getUPDATE_DATE() {
		return UPDATE_DATE;
	}

	public void setUPDATE_DATE(Date uPDATE_DATE) {
		UPDATE_DATE = uPDATE_DATE;
	}

	public String getRNUM() {
		return RNUM;
	}

	public void setRNUM(String rNUM) {
		RNUM = rNUM;
	}
	
	
}
