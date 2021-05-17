package com.book_conference.adminmember.dto;

import java.sql.Date;

public class ApplyContentDto {
	private int APPLY_NUM;
	private String MEMBER_NAME;
	private String MEMBER_DEPTCODE;
	private String MEMBER_DEPTNAME;
	private String MEMBER_ID;
	private String MEMBER_PW;
	private String MEMBER_EMAIL;
	private Date MEMBER_APPLY_DATE;
	private String APPLY_STATUS;
	private String RNUM;
	
	public ApplyContentDto() {
	}
	public ApplyContentDto(int APPLY_NUM, String MEMBER_NAME, String MEMBER_DEPTCODE
			, String MEMBER_DEPTNAME, String MEMBER_ID, String MEMBER_PW, String MEMBER_EMAIL
			,Date MEMBER_APPLY_DATE, String APPLY_STATUS,String RNUM) {
		this.APPLY_NUM = APPLY_NUM;
		this.MEMBER_NAME = MEMBER_NAME;
		this.MEMBER_DEPTCODE = MEMBER_DEPTCODE;
		this.MEMBER_DEPTNAME = MEMBER_DEPTNAME;
		this.MEMBER_ID =  MEMBER_ID;
		this.MEMBER_PW = MEMBER_PW;
		this.MEMBER_EMAIL = MEMBER_EMAIL;
		this.MEMBER_APPLY_DATE = MEMBER_APPLY_DATE;
		this.APPLY_STATUS = APPLY_STATUS;
		this.RNUM = RNUM;
	}

	public int getAPPLY_NUM() {
		return APPLY_NUM;
	}

	public void setAPPLY_NUM(int aPPLY_NUM) {
		APPLY_NUM = aPPLY_NUM;
	}

	public String getMEMBER_NAME() {
		return MEMBER_NAME;
	}

	public void setMEMBER_NAME(String mEMBER_NAME) {
		MEMBER_NAME = mEMBER_NAME;
	}

	public String getMEMBER_DEPTCODE() {
		return MEMBER_DEPTCODE;
	}

	public void setMEMBER_DEPTCODE(String mEMBER_DEPTCODE) {
		MEMBER_DEPTCODE = mEMBER_DEPTCODE;
	}

	public String getMEMBER_DEPTNAME() {
		return MEMBER_DEPTNAME;
	}

	public void setMEMBER_DEPTNAME(String mEMBER_DEPTNAME) {
		MEMBER_DEPTNAME = mEMBER_DEPTNAME;
	}

	public String getMEMBER_ID() {
		return MEMBER_ID;
	}

	public void setMEMBER_ID(String mEMBER_ID) {
		MEMBER_ID = mEMBER_ID;
	}

	public String getMEMBER_PW() {
		return MEMBER_PW;
	}

	public void setMEMBER_PW(String mEMBER_PW) {
		MEMBER_PW = mEMBER_PW;
	}

	public String getMEMBER_EMAIL() {
		return MEMBER_EMAIL;
	}

	public void setMEMBER_EMAIL(String mEMBER_EMAIL) {
		MEMBER_EMAIL = mEMBER_EMAIL;
	}

	public Date getMEMBER_APPLY_NUM() {
		return MEMBER_APPLY_DATE;
	}

	public void setMEMBER_APPLY_NUM(Date mEMBER_APPLY_DATE) {
		MEMBER_APPLY_DATE = mEMBER_APPLY_DATE;
	}

	public String getAPPLY_STATUS() {
		return APPLY_STATUS;
	}

	public void setAPPLY_STATUS(String aPPLY_STATUS) {
		APPLY_STATUS = aPPLY_STATUS;
	}

	public Date getMEMBER_APPLY_DATE() {
		return MEMBER_APPLY_DATE;
	}

	public void setMEMBER_APPLY_DATE(Date mEMBER_APPLY_DATE) {
		MEMBER_APPLY_DATE = mEMBER_APPLY_DATE;
	}

	public String getRNUM() {
		return RNUM;
	}

	public void setRNUM(String rNUM) {
		RNUM = rNUM;
	}
}
