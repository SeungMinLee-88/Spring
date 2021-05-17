package com.book_conference.dataroom.dao;

import java.util.List;

import com.book_conference.dataroom.dto.DownloadDto;
import com.book_conference.dataroom.dto.VideoDto;

public interface DataRoomIDao {
	public List<DownloadDto> SelectDownloadList(String TITLE, String WRITER, int page);

	public int SelectDownloadCount(String searchtype, String searchkeyword, int page);

	public List<DownloadDto> SelectDownloadTopList();

	public void DownloadWriteProcess(String DOWNLOAD_TITLE, String DOWNLOAD_CONTENT, String DOWNLOAD_WRITER,String DOWNLOAD_FILENAME, String DOWNLOAD_FILE, String DOWNLOAD_TOP );

	public DownloadDto SelectDownloadInfo(String DOWNLOAD_number);

	public void DownloadHitCountIncrese(String DOWNLOAD_number);

	public void DownloadModifyProcess(String DOWNLOAD_TITLE, String DOWNLOAD_CONTENT, String DOWNLOAD_WRITER,String DOWNLOAD_FILENAME, String DOWNLOAD_FILE, String DOWNLOAD_TOP,String DOWNLOAD_number);

	public void DownloadDelete(String DOWNLOAD_number);

	public List<VideoDto> SelectVideoList(String searchtype, String searchkeyword, int page);

	public List<VideoDto> SelectVideoTopList();

	public int SelectVideoCount(String searchtype, String searchkeyword, int page);

	public void VideoWriteProcess(String VIDEO_TITLE, String VIDEO_CONTENT, String VIDEO_WRITER, String VIDEO_FILENAME,
			String VIDEO_FILE, String VIDEO_LINK, String VIDEO_TYPE, String vIDEO_TOP);

	public VideoDto SelectVideoInfo(String VIDEO_NUM);

	public void VideoModifyProcess(String VIDEO_TITLE, String VIDEO_CONTENT, String memberid, String VIDEO_FILENAME, String VIDEO_FILE,
			String VIDEO_LINK, String VIDEO_TYPE, String vIDEO_TOP, String VIDEO_NUM);

	public void VideoDelete(String VIDEO_NUM);
}
