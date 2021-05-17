package com.book_conference.notice.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.book_conference.notice.dao.NoticeIDao;
import com.book_conference.notice.dto.NoticeDto;

import java.util.List;

@Controller
public class NoticeController {

		@Autowired
		private SqlSession slqSession;
		
		//공지사항 리스트
		@RequestMapping("/NoticeList")
		public String NoticeList(HttpServletRequest request,Model model) {
		String searchtype="";
		String searchkeyword="";
		if(request.getParameter("searchtype")!=null && request.getParameter("searchtype")!=""){
			searchtype=request.getParameter("searchtype");
		}
		if(request.getParameter("searchkeyword")!=null && request.getParameter("searchkeyword")!=""){
			searchkeyword=request.getParameter("searchkeyword");
		}
		List<NoticeDto> topitemList=null;
		List<NoticeDto> itemList=null;
		int count=1;
		int page=1;			
		int pageSize=7;		
		if(request.getParameter("page")!=null){
			page=Integer.parseInt(request.getParameter("page"));
		}
		NoticeIDao Idao = slqSession.getMapper(NoticeIDao.class);

		itemList = Idao.SelectNoticeList(searchtype, searchkeyword,page);
		topitemList = Idao.SelectNoticeTopList();
		count=Idao.SelectNoticeCount(searchtype, searchkeyword,page);
		int pageCount=count/pageSize+(count % pageSize==0?0:1);
		int startPage=(int)((page-1)/10)*10+1;
		int endPage=startPage+10-1;
		if (endPage>pageCount) endPage=pageCount;
		request.setAttribute("itemList", itemList);
		request.setAttribute("topitemList", topitemList);
		request.setAttribute("count", page);
		request.setAttribute("pageCount", pageCount);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("searchtype", searchtype);
		request.setAttribute("searchkeyword", searchkeyword);

		return "/notice/notice_list.noticetiles";
		}
		
		//공지사항 글쓰기 페이지 요청
		@RequestMapping("/NoticeWrite")
		public String NoticeWrite(HttpServletRequest request,Model model){

			return "/notice/notice_write.noticetiles";
		}
		
		//공지사항 글쓰기 처리
		@RequestMapping("/NoticeWriteProcess")
		public String NoticeWriteProcess(HttpServletRequest request,Model model){
		NoticeIDao Idao = slqSession.getMapper(NoticeIDao.class);
		HttpSession session=request.getSession(); 
		String memberid = (String)session.getAttribute("id");
		String NOTICE_TOP=null;
		if(request.getParameter("NOTICE_TOP")!=null && request.getParameter("NOTICE_TOP")!=""){
			NOTICE_TOP="y";
		}else if(request.getParameter("NOTICE_TOP")==null || request.getParameter("NOTICE_TOP")==""){
			NOTICE_TOP="n";
		}
		Idao.NoticeWriteProcess(request.getParameter("NOTICE_TITLE"),
			request.getParameter("NOTICE_CONTENT"),
			memberid,
			NOTICE_TOP);
			String returnmsg ="등록 되었습니다.";
			request.setAttribute("msg", returnmsg); 
			request.setAttribute("url", "./NoticeList");
			return "/alertredirect/redirect";
		}
		
		// 공지사항 글 상세보기
		@RequestMapping("/NoticeView")
		public String NoticeView(HttpServletRequest request,Model model){
			String searchtype="";
			String searchkeyword="";
			String notice_number = request.getParameter("notice_number");
			int page=1;	
			if(request.getParameter("searchtype")!=null && request.getParameter("searchtype")!=""){
				searchtype=request.getParameter("searchtype");
			}
			if(request.getParameter("searchkeyword")!=null && request.getParameter("searchkeyword")!=""){
				searchkeyword=request.getParameter("searchkeyword");
			}
			if(request.getParameter("page")!=null){
				page=Integer.parseInt(request.getParameter("page"));
			}
			NoticeIDao Idao = slqSession.getMapper(NoticeIDao.class);
			NoticeDto Dto = Idao.SelectNoticeInfo(notice_number);
			Idao.NoticeHitCountIncrese(notice_number);
			request.setAttribute("Dto", Dto);
			request.setAttribute("count", page);
			request.setAttribute("searchtype", searchtype);
			request.setAttribute("searchkeyword", searchkeyword);

			return "/notice/notice_view.noticetiles";
		}
		// 공지사항 글 수정 페이지 요청
		@RequestMapping("/NoticeModify")
		public String NoticeModify(HttpServletRequest request,Model model){
			String searchtype="";
			String searchkeyword="";
			String notice_number = request.getParameter("notice_number");
			int page=1;	
			if(request.getParameter("searchtype")!=null && request.getParameter("searchtype")!=""){
				searchtype=request.getParameter("searchtype");
			}
			if(request.getParameter("searchkeyword")!=null && request.getParameter("searchkeyword")!=""){
				searchkeyword=request.getParameter("searchkeyword");
			}
			if(request.getParameter("page")!=null){
				page=Integer.parseInt(request.getParameter("page"));
			}
			
			NoticeIDao Idao = slqSession.getMapper(NoticeIDao.class);
			NoticeDto Dto = Idao.SelectNoticeInfo(notice_number);
			Idao.NoticeHitCountIncrese(notice_number);
			request.setAttribute("Dto", Dto);
			request.setAttribute("count", page);
			request.setAttribute("searchtype", searchtype);
			request.setAttribute("searchkeyword", searchkeyword);

			return "/notice/notice_modify.noticetiles";
		}
		
		// 공지사항 글 수정 처리
		@RequestMapping("/NoticeModifyProcess")
		public String NoticeModifyProcess(HttpServletRequest request,Model model){
			String searchtype="";
			String searchkeyword="";
			String notice_number = request.getParameter("NOTICE_NUM");
			int page=1;	
			if(request.getParameter("searchtype")!=null && request.getParameter("searchtype")!=""){
				searchtype=request.getParameter("searchtype");
			}
			if(request.getParameter("searchkeyword")!=null && request.getParameter("searchkeyword")!=""){
				searchkeyword=request.getParameter("searchkeyword");
			}
			if(request.getParameter("page")!=null){
				page=Integer.parseInt(request.getParameter("page"));
			}
			
			NoticeIDao Idao = slqSession.getMapper(NoticeIDao.class);
			HttpSession session=request.getSession(); 
			String memberid = (String)session.getAttribute("id");
			String NOTICE_TOP=null;
			if(request.getParameter("NOTICE_TOP")!=null && request.getParameter("NOTICE_TOP")!=""){
				NOTICE_TOP="y";
			}else if(request.getParameter("NOTICE_TOP")==null || request.getParameter("NOTICE_TOP")==""){
				NOTICE_TOP="n";
			}
			Idao.NoticeModifyProcess(
				request.getParameter("NOTICE_TITLE"),
				request.getParameter("NOTICE_CONTENT"),
				memberid,
				NOTICE_TOP,
				notice_number);
				
				String returnmsg ="수정 되었습니다.";
				request.setAttribute("msg", returnmsg); 
				request.setAttribute("url", "./NoticeView?notice_number="+notice_number+"&page="+page+"&searchtype="+searchtype+"&searchkeyword="+searchkeyword);
				return "/alertredirect/redirect";
		}
		
		// 공지사항 글 삭제 처리
		@RequestMapping("/NoticeDelete")
		public String NoticeDelete(HttpServletRequest request,Model model){
			String searchtype="";
			String searchkeyword="";
			String notice_number = request.getParameter("notice_number");
			int page=1;	
			if(request.getParameter("searchtype")!=null && request.getParameter("searchtype")!=""){
				searchtype=request.getParameter("searchtype");
			}
			if(request.getParameter("searchkeyword")!=null && request.getParameter("searchkeyword")!=""){
				searchkeyword=request.getParameter("searchkeyword");
			}
			if(request.getParameter("page")!=null){
				page=Integer.parseInt(request.getParameter("page"));
			}
			NoticeIDao Idao = slqSession.getMapper(NoticeIDao.class);
			Idao.NoticeDelete(notice_number);


			String returnmsg ="삭제 되었습니다.";
			request.setAttribute("msg", returnmsg); 
			request.setAttribute("url", "./NoticeList?page="+page+"&searchtype="+searchtype+"&searchkeyword="+searchkeyword);
			return "/alertredirect/redirect";
		}
		
}
