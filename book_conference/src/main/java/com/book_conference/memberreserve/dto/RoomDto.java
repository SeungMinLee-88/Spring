package com.book_conference.memberreserve.dto;

import java.sql.Timestamp;

public class RoomDto {

	private int BOOK_NUM;	
	private String BOOK_MEMBER;
	private String BOOK_TIME;
	private String BOOK_TOTAL_TIME;
	private String BOOK_DATE;
	private String BOOK_REASON;
	private Timestamp CREATE_TIME;
	private Timestamp UPDATE_TIME;
	private String RNUM;
	
	public RoomDto() {
	}
	public RoomDto(int BOOK_NUM, String BOOK_MEMBER, String BOOK_TIME
			, String BOOK_TOTAL_TIME, String BOOK_DATE, String BOOK_REASON, Timestamp CREATE_TIME
			,Timestamp UPDATE_TIME, String RNUM) {
		this.BOOK_NUM = BOOK_NUM;
		this.BOOK_MEMBER = BOOK_MEMBER;
		this.BOOK_TIME = BOOK_TIME;
		this.BOOK_TOTAL_TIME = BOOK_TOTAL_TIME;
		this.BOOK_DATE =  BOOK_DATE;
		this.BOOK_REASON = BOOK_REASON;
		this.CREATE_TIME = CREATE_TIME;
		this.UPDATE_TIME = UPDATE_TIME;
		this.RNUM = RNUM;
	}
	public int getBOOK_NUM() {
		return BOOK_NUM;
	}
	public void setBOOK_NUM(int bOOK_NUM) {
		BOOK_NUM = bOOK_NUM;
	}
	public String getBOOK_MEMBER() {
		return BOOK_MEMBER;
	}
	public void setBOOK_MEMBER(String bOOK_MEMBER) {
		BOOK_MEMBER = bOOK_MEMBER;
	}
	public String getBOOK_TIME() {
		return BOOK_TIME;
	}
	public void setBOOK_TIME(String bOOK_TIME) {
		BOOK_TIME = bOOK_TIME;
	}
	public String getBOOK_TOTAL_TIME() {
		return BOOK_TOTAL_TIME;
	}
	public void setBOOK_TOTAL_TIME(String bOOK_TOTAL_TIME) {
		BOOK_TOTAL_TIME = bOOK_TOTAL_TIME;
	}
	public String getBOOK_DATE() {
		return BOOK_DATE;
	}
	public void setBOOK_DATE(String bOOK_DATE) {
		BOOK_DATE = bOOK_DATE;
	}
	public String getBOOK_REASON() {
		return BOOK_REASON;
	}
	public void setBOOK_REASON(String bOOK_REASON) {
		BOOK_REASON = bOOK_REASON;
	}
	public Timestamp getCREATE_TIME() {
		return CREATE_TIME;
	}
	public void setCREATE_TIME(Timestamp cREATE_TIME) {
		CREATE_TIME = cREATE_TIME;
	}
	public Timestamp getUPDATE_TIME() {
		return UPDATE_TIME;
	}
	public void setUPDATE_TIME(Timestamp uPDATE_TIME) {
		UPDATE_TIME = uPDATE_TIME;
	}
	public String getRNUM() {
		return RNUM;
	}
	public void setRNUM(String rNUM) {
		RNUM = rNUM;
	}
}
