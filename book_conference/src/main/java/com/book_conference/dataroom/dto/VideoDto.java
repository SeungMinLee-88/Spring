package com.book_conference.dataroom.dto;

import java.sql.Date;

public class VideoDto {
	private int VIDEO_NUM;
	private String VIDEO_TITLE;
	private String VIDEO_WRITER;
	private String VIDEO_FILENAME;
	private String VIDEO_FILE;
	private String VIDEO_LINK;
	private String VIDEO_TYPE;
	private String VIDEO_CONTENT;
	private int VIDEO_HIT;
	private String VIDEO_TOP;
	private Date CREATE_DATE;
	private Date UPDATE_DATE;
	private String RNUM;
	
	public VideoDto() {
	}
	public VideoDto(int VIDEO_NUM, String VIDEO_TITLE, String VIDEO_WRITER
			, String VIDEO_CONTENT, int VIDEO_HIT, String VIDEO_TOP, Date CREATE_DATE
			,Date UPDATE_DATE,String VIDEO_FILENAME,String VIDEO_FILE,String VIDEO_LINK
			,String VIDEO_TYPE,String RNUM) {
		this.VIDEO_NUM = VIDEO_NUM;
		this.VIDEO_TITLE = VIDEO_TITLE;
		this.VIDEO_WRITER = VIDEO_WRITER;
		this.VIDEO_CONTENT = VIDEO_CONTENT;
		this.VIDEO_HIT =  VIDEO_HIT;
		this.VIDEO_TOP = VIDEO_TOP;
		this.CREATE_DATE = CREATE_DATE;
		this.UPDATE_DATE = UPDATE_DATE;
		this.RNUM = VIDEO_FILENAME;
		this.RNUM = VIDEO_FILE;
		this.RNUM = VIDEO_LINK;
		this.RNUM = VIDEO_TYPE;
		this.RNUM = RNUM;
	}

	public int getVIDEO_NUM() {
		return VIDEO_NUM;
	}

	public void setVIDEO_NUM(int vIDEO_NUM) {
		VIDEO_NUM = vIDEO_NUM;
	}

	public String getVIDEO_TITLE() {
		return VIDEO_TITLE;
	}

	public void setVIDEO_TITLE(String vIDEO_TITLE) {
		VIDEO_TITLE = vIDEO_TITLE;
	}

	public String getVIDEO_WRITER() {
		return VIDEO_WRITER;
	}

	public void setVIDEO_WRITER(String vIDEO_WRITER) {
		VIDEO_WRITER = vIDEO_WRITER;
	}

	public String getVIDEO_FILENAME() {
		return VIDEO_FILENAME;
	}

	public void setVIDEO_FILENAME(String vIDEO_FILENAME) {
		VIDEO_FILENAME = vIDEO_FILENAME;
	}

	public String getVIDEO_FILE() {
		return VIDEO_FILE;
	}

	public void setVIDEO_FILE(String vIDEO_FILE) {
		VIDEO_FILE = vIDEO_FILE;
	}

	public String getVIDEO_LINK() {
		return VIDEO_LINK;
	}

	public void setVIDEO_LINK(String vIDEO_LINK) {
		VIDEO_LINK = vIDEO_LINK;
	}

	public String getVIDEO_TYPE() {
		return VIDEO_TYPE;
	}

	public void setVIDEO_TYPE(String vIDEO_TYPE) {
		VIDEO_TYPE = vIDEO_TYPE;
	}

	public String getVIDEO_CONTENT() {
		return VIDEO_CONTENT;
	}

	public void setVIDEO_CONTENT(String vIDEO_CONTENT) {
		VIDEO_CONTENT = vIDEO_CONTENT;
	}

	public int getVIDEO_HIT() {
		return VIDEO_HIT;
	}

	public void setVIDEO_HIT(int vIDEO_HIT) {
		VIDEO_HIT = vIDEO_HIT;
	}

	public String getVIDEO_TOP() {
		return VIDEO_TOP;
	}

	public void setVIDEO_TOP(String vIDEO_TOP) {
		VIDEO_TOP = vIDEO_TOP;
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
