package com.book_conference.dataroom.dto;

import java.sql.Date;

public class DownloadDto {
	private int DOWNLOAD_NUM;
	private String DOWNLOAD_TITLE;
	private String DOWNLOAD_WRITER;
	private String DOWNLOAD_FILENAME;
	private String DOWNLOAD_FILE;
	private String DOWNLOAD_CONTENT;
	private int DOWNLOAD_HIT;
	private String DOWNLOAD_TOP;
	private Date CREATE_DATE;
	private Date UPDATE_DATE;
	private String RNUM;
	public DownloadDto() {
	}
	public DownloadDto(int DOWNLOAD_NUM, String DOWNLOAD_TITLE, String DOWNLOAD_WRITER
			, String DOWNLOAD_CONTENT, int DOWNLOAD_HIT, String DOWNLOAD_TOP, Date CREATE_DATE
			,Date UPDATE_DATE,String DOWNLOAD_FILENAME,String DOWNLOAD_FILE,String RNUM) {
		this.DOWNLOAD_NUM = DOWNLOAD_NUM;
		this.DOWNLOAD_TITLE = DOWNLOAD_TITLE;
		this.DOWNLOAD_WRITER = DOWNLOAD_WRITER;
		this.DOWNLOAD_CONTENT = DOWNLOAD_CONTENT;
		this.DOWNLOAD_HIT =  DOWNLOAD_HIT;
		this.DOWNLOAD_TOP = DOWNLOAD_TOP;
		this.CREATE_DATE = CREATE_DATE;
		this.UPDATE_DATE = UPDATE_DATE;
		this.RNUM = DOWNLOAD_FILENAME;
		this.RNUM = DOWNLOAD_FILE;
		this.RNUM = RNUM;
	}

	public int getDOWNLOAD_NUM() {
		return DOWNLOAD_NUM;
	}

	public void setDOWNLOAD_NUM(int dOWNLOAD_NUM) {
		DOWNLOAD_NUM = dOWNLOAD_NUM;
	}

	public String getDOWNLOAD_TITLE() {
		return DOWNLOAD_TITLE;
	}

	public void setDOWNLOAD_TITLE(String dOWNLOAD_TITLE) {
		DOWNLOAD_TITLE = dOWNLOAD_TITLE;
	}

	public String getDOWNLOAD_WRITER() {
		return DOWNLOAD_WRITER;
	}

	public void setDOWNLOAD_WRITER(String dOWNLOAD_WRITER) {
		DOWNLOAD_WRITER = dOWNLOAD_WRITER;
	}

	public String getDOWNLOAD_FILENAME() {
		return DOWNLOAD_FILENAME;
	}

	public void setDOWNLOAD_FILENAME(String dOWNLOAD_FILENAME) {
		DOWNLOAD_FILENAME = dOWNLOAD_FILENAME;
	}

	public String getDOWNLOAD_FILE() {
		return DOWNLOAD_FILE;
	}

	public void setDOWNLOAD_FILE(String dOWNLOAD_FILE) {
		DOWNLOAD_FILE = dOWNLOAD_FILE;
	}

	public String getDOWNLOAD_CONTENT() {
		return DOWNLOAD_CONTENT;
	}

	public void setDOWNLOAD_CONTENT(String dOWNLOAD_CONTENT) {
		DOWNLOAD_CONTENT = dOWNLOAD_CONTENT;
	}

	public int getDOWNLOAD_HIT() {
		return DOWNLOAD_HIT;
	}

	public void setDOWNLOAD_HIT(int dOWNLOAD_HIT) {
		DOWNLOAD_HIT = dOWNLOAD_HIT;
	}

	public String getDOWNLOAD_TOP() {
		return DOWNLOAD_TOP;
	}

	public void setDOWNLOAD_TOP(String dOWNLOAD_TOP) {
		DOWNLOAD_TOP = dOWNLOAD_TOP;
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
