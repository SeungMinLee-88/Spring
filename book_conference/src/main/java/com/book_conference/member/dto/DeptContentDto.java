package com.book_conference.member.dto;

public class DeptContentDto {

	private int DEPT_NUM;
	private String DEPT_CODE;
	private String DEPT_NAME;
	private String DEPT_DEPTH;

	public DeptContentDto() {
		// TODO Auto-generated constructor stub
	}
	
	public DeptContentDto(int DEPT_NUM, String DEPT_CODE, String DEPT_NAME, String DEPT_DEPTH) {
		this.DEPT_NUM = DEPT_NUM;
		this.DEPT_CODE = DEPT_CODE;
		this.DEPT_NAME = DEPT_NAME;
		this.DEPT_DEPTH = DEPT_DEPTH;
	}

	public int getDEPT_NUM() {
		return DEPT_NUM;
	}

	public void setDEPT_NUM(int dEPT_NUM) {
		DEPT_NUM = dEPT_NUM;
	}

	public String getDEPT_CODE() {
		return DEPT_CODE;
	}

	public void setDEPT_CODE(String dEPT_CODE) {
		DEPT_CODE = dEPT_CODE;
	}

	public String getDEPT_NAME() {
		return DEPT_NAME;
	}

	public void setDEPT_NAME(String dEPT_NAME) {
		DEPT_NAME = dEPT_NAME;
	}

	public String getDEPT_DEPTH() {
		return DEPT_DEPTH;
	}

	public void setDEPT_DEPTH(String dEPT_DEPTH) {
		DEPT_DEPTH = dEPT_DEPTH;
	}


}
