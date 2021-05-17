package com.book_conference.adminreserve.controller;

import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.book_conference.adminreserve.dao.AdminReserveIDao;
import com.book_conference.adminreserve.dto.RoomDto;
import com.book_conference.member.dao.MemberIDao;
import com.book_conference.member.dto.MemberContentDto;


@Controller
public class AdminReserveController {
	
	@Autowired
	private SqlSession slqSession;
	//관리자 예약
	@RequestMapping("/AdminReserve")
	public String AdminReserve(HttpServletRequest request, HttpServletResponse response,Model model) {
		String roomnum=request.getParameter("roomnum");
		request.setAttribute("roomnum", roomnum);
		return "/admin_reserve/admin_reserve.admintiles";
	}
	// 관리자 예약 달력 폼
	@RequestMapping("/RoomBookCalendar")
	public String RoomBookCalendar(HttpServletRequest request, HttpServletResponse response,Model model) {
		
		String roomnum=request.getParameter("roomnum");
		request.setAttribute("roomnum", roomnum);

		return "/admin_reserve/book_calendar";
	}
	// 관리자 예약 관리 값 조회
	@RequestMapping("/RoomBookList")
	public void RoomBookList(HttpServletRequest request, HttpServletResponse response,Model model) throws UnsupportedEncodingException, IOException {
		List<RoomDto> itemList=new ArrayList<RoomDto>();
		String roomnum=request.getParameter("roomnum");
		String inputDate=request.getParameter("inputDate");
		AdminReserveIDao IDao = slqSession.getMapper(AdminReserveIDao.class);
		itemList = IDao.RoomBookList(roomnum, inputDate);
		
		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();
		for(int i=0;i<itemList.size();i++){
		obj.put( "BOOK_NUM", ((RoomDto) itemList.get(i)).getBOOK_NUM());
		obj.put( "BOOK_MEMBER", ((RoomDto) itemList.get(i)).getBOOK_MEMBER());
		obj.put( "BOOK_TIME", ((RoomDto) itemList.get(i)).getBOOK_TIME());
		obj.put( "BOOK_DATE", ((RoomDto) itemList.get(i)).getBOOK_DATE());
		arr.add(obj);
		}
		
		response.setHeader( "Content-Type", "text/html;charset=utf-8" );
		PrintWriter out = new PrintWriter( new OutputStreamWriter(response.getOutputStream(), "UTF-8" ) );
		out.print(arr);
		out.flush();
		out.close();

	}
	// 일자별 예약 및 예약 제한 상태 조회
	@RequestMapping("/RoomBookStatus")
	public void RoomBookStatus(HttpServletRequest request, HttpServletResponse response,Model model) throws UnsupportedEncodingException, IOException {
		String roomnum=request.getParameter("roomnum");
		String inputDate=request.getParameter("inputDate");
		String TotalNum="0";
		String RestrictStatus="0";
		AdminReserveIDao IDao = slqSession.getMapper(AdminReserveIDao.class);
		TotalNum = IDao.RoomBookTotalList(roomnum, inputDate);
		RestrictStatus = IDao.BookRestrictStatus(roomnum, inputDate);
		
		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();

		if(TotalNum == null){
			obj.put( "TotalNum", "0");
		}else{
			obj.put( "TotalNum", TotalNum);
		}
		obj.put( "RestrictStatus", RestrictStatus);
		arr.add(obj);
		response.setHeader( "Content-Type", "text/html;charset=utf-8" );
		PrintWriter out = new PrintWriter( new OutputStreamWriter(response.getOutputStream(), "UTF-8" ) );
		out.print(arr);
		out.flush();
		out.close();
	}
	// 관리자 예약 제한
	@RequestMapping("/RestrictBookStatus")
	public String RestrictBookStatus(HttpServletRequest request, HttpServletResponse response,Model model) {
		
		String roomnum=request.getParameter("roomnum");
		String inputDate=request.getParameter("inputDate");
		String strMonth=request.getParameter("strMonth");
		AdminReserveIDao IDao = slqSession.getMapper(AdminReserveIDao.class);
		IDao.RestrictBookStatus(roomnum, inputDate);
		
		request.setAttribute("roomnum", roomnum);
		request.setAttribute("strMonth", strMonth);

		return "redirect:/RoomBookCalendar?roomnum="+roomnum;
	}
	// 예약 제한 삭제
	@RequestMapping("/ReleaseRestrictBookStatus")
	public String ReleaseRestrictBookStatus(HttpServletRequest request, HttpServletResponse response,Model model) {
		
		String roomnum=request.getParameter("roomnum");
		String inputDate=request.getParameter("inputDate");
		String strMonth=request.getParameter("month");
		AdminReserveIDao IDao = slqSession.getMapper(AdminReserveIDao.class);
		IDao.ReleaseRestrictBookStatus(roomnum, inputDate);
		
		request.setAttribute("roomnum", roomnum);
		request.setAttribute("month", strMonth);

		return "redirect:/RoomBookCalendar?roomnum="+roomnum;
	}
	
	// 사용자 리스트 팝업 요청
	@RequestMapping("/UserList")
	public String UserList(HttpServletRequest request,Model model){

		MemberIDao Idao = slqSession.getMapper(MemberIDao.class);
		model.addAttribute("dept_list", Idao.SelectDeptList(null, null));
		String roomnum=request.getParameter("roomnum");	
		request.setAttribute("roomnum", roomnum);
		
		return "/admin_reserve/user_list";
	}
	
	// 사용라 리스트 조회 후 리턴
	@RequestMapping("/SelectUserList")
	public void SelectUserList(
			HttpServletRequest request,HttpServletResponse response,Model model)
			 throws Exception{
		MemberIDao Idao = slqSession.getMapper(MemberIDao.class);
		String depcode;
		depcode = request.getParameter("depcode");
		ArrayList<MemberContentDto> itemList=null;
		itemList =Idao.SelectUserList(depcode);
		
		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();
		for(int i=0;i<itemList.size();i++){

			obj.put( "MEMBER_NUM", ((MemberContentDto) itemList.get(i)).getMEMBER_NUM());
			obj.put( "MEMBER_NAME", ((MemberContentDto) itemList.get(i)).getMEMBER_NAME());
			obj.put( "MEMBER_DEPTCODE", ((MemberContentDto) itemList.get(i)).getMEMBER_DEPTCODE());
			obj.put( "MEMBER_DEPTNAME", ((MemberContentDto) itemList.get(i)).getMEMBER_DEPTNAME());
			obj.put( "MEMBER_ID", ((MemberContentDto) itemList.get(i)).getMEMBER_ID());
			arr.add(obj);
		}
		response.setHeader( "Content-Type", "text/html;charset=utf-8" );
		PrintWriter out = new PrintWriter( new OutputStreamWriter(response.getOutputStream(), "UTF-8" ) );
		out.print(arr);
		out.flush();
		out.close();
	}
	// 관리자 예약 등록
	@RequestMapping("/BookWrite")
	public String BookWrite(HttpServletRequest request,Model model){
		String roomnum=request.getParameter("roomnum");	
		String[] BOOK_TIME_ARR = request.getParameterValues("BOOK_TIME");

		String book_time ="";
		int book_total_time=0;
		// 예약 시간 String 형태로 변환
		for(int i=0;i<BOOK_TIME_ARR.length;i++)
		{
			if(i<BOOK_TIME_ARR.length-1){
			book_time = book_time + BOOK_TIME_ARR[i] +",";
			}else{
			book_time = book_time + BOOK_TIME_ARR[i];
			}
			book_total_time++;
		}
		AdminReserveIDao Idao = slqSession.getMapper(AdminReserveIDao.class);
		Idao.BookWrite(roomnum,request.getParameter("BOOK_MEMBER"), 
				book_time,
				Integer.toString(book_total_time),
				request.getParameter("BOOK_DATE"),
				request.getParameter("BOOK_REASON"));
		
		request.setAttribute("roomnum", roomnum);
		
		return "redirect:/AdminReserve?roomnum="+roomnum;
	}
	
	@RequestMapping("/AdminReserList")
	public String AdminReserList
	(HttpServletRequest request, HttpServletResponse response,Model model) {
		String roomnum=request.getParameter("roomnum");
		
		String year = new java.text.SimpleDateFormat("yyyy").format(new java.util.Date());
		String month="";
		String inputDate="";
		new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		
		if(request.getParameter("month") ==null){
			month = new java.text.SimpleDateFormat("MM").format(new java.util.Date());
		}else{
			month =request.getParameter("month");
		}
		inputDate = year+"-"+(month.length() == 1 ? "0" + month : month);
		List<RoomDto> itemList=null;
		AdminReserveIDao Idao = slqSession.getMapper(AdminReserveIDao.class);
		
		int count=1;
		int page=1;			
		int pageSize=7;		
		if(request.getParameter("page")!=null){
			page=Integer.parseInt(request.getParameter("page"));
		}

		itemList =Idao.SelectReserveList(roomnum,inputDate,page);
		count =Idao.SelectReserveListCount(roomnum,inputDate);
				
		int pageCount=count/pageSize+(count % pageSize==0?0:1);
		int startPage=(int)((page-1)/10)*10+1;
		int endPage=startPage+10-1;
		if (endPage>pageCount) endPage=pageCount;

		request.setAttribute("itemList", itemList);
		request.setAttribute("count", page);
		request.setAttribute("pageCount", pageCount);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("roomnum", roomnum);
		request.setAttribute("year", year);
		request.setAttribute("month", month);
		return "/admin_reserve/admin_reserve_list.admintiles";
	}
	// 예약 삭제
	@RequestMapping("/DeleteBook")
	public String DeleteBook(HttpServletRequest request,Model model){
		String roomnum=request.getParameter("roomnum");
		String month="";
		if(request.getParameter("month") ==null){
			month = new java.text.SimpleDateFormat("MM").format(new java.util.Date());
		}else{
			month =request.getParameter("month");
		}
		
		String book_num=request.getParameter("book_num");

		int page=1;	
		if(request.getParameter("page")!=null){
			page=Integer.parseInt(request.getParameter("page"));
		}
		new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		AdminReserveIDao Idao = slqSession.getMapper(AdminReserveIDao.class);
		Idao.DeleteBook(roomnum,book_num);
		request.setAttribute("month", month);
		request.setAttribute("roomnum", roomnum);
		String returnmsg ="예약을 삭제하였습니다.";
		request.setAttribute("msg", returnmsg); 
		request.setAttribute("url", "./AdminReserList?page="+page+"&month="+month);
		return "/alertredirect/redirect";
	}
	// 예약 수정
	@RequestMapping("/ModifyBook")
	public String ModifyBook(HttpServletRequest request,Model model){
		String roomnum=request.getParameter("roomnum");
		String month="";
		if(request.getParameter("month") ==null){
			month = new java.text.SimpleDateFormat("MM").format(new java.util.Date());
		}else{
			month =request.getParameter("month");
		}
		
		String book_num=request.getParameter("book_num");
		
		int page=1;	
		if(request.getParameter("page")!=null){
			page=Integer.parseInt(request.getParameter("page"));
		}
		
		new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		AdminReserveIDao Idao = slqSession.getMapper(AdminReserveIDao.class);
		RoomDto Dto = Idao.SelectBookInfo(roomnum,book_num);
		request.setAttribute("month", month);
		request.setAttribute("roomnum", roomnum);
		request.setAttribute("book_num", book_num);
		request.setAttribute("Dto", Dto);
		
		return "/admin_reserve/admin_modify_reserve.admintiles";
	}
	// 예약 수정용 달력 폼
	@RequestMapping("/RoomBookModifyCalendar")
	public String RoomBookModifyCalendar(HttpServletRequest request, HttpServletResponse response,Model model) {
		
		String roomnum=request.getParameter("roomnum");
		String bookdate=request.getParameter("bookdate");
		String year = new java.text.SimpleDateFormat("yyyy").format(new java.util.Date());
		String month="";
		if(request.getParameter("month") ==null){
			month = new java.text.SimpleDateFormat("MM").format(new java.util.Date());
		}else{
			month =request.getParameter("month");
		}
		
		request.setAttribute("month", month);
		request.setAttribute("roomnum", roomnum);
		request.setAttribute("bookdate", bookdate);

		return "/admin_reserve/book_modify_calendar";
	}
	// 예약 수정 처리
	@RequestMapping("/ModifyBookProcess")
	public String ModifyBookProcess(HttpServletRequest request,Model model){
		String page=request.getParameter("page");	
		String roomnum=request.getParameter("roomnum");	
		
		String month="";
		if(request.getParameter("month") ==null){
			month = new java.text.SimpleDateFormat("MM").format(new java.util.Date());
		}else{
			month =request.getParameter("month");
		}
		String[] BOOK_TIME_ARR = request.getParameterValues("BOOK_TIME");
		String book_time ="";
		int book_total_time=0;
		for(int i=0;i<BOOK_TIME_ARR.length;i++)
		{
			if(i<BOOK_TIME_ARR.length-1){
			book_time = book_time + BOOK_TIME_ARR[i] +",";
			}else{
			book_time = book_time + BOOK_TIME_ARR[i];
			}
			book_total_time++;
		}
		AdminReserveIDao Idao = slqSession.getMapper(AdminReserveIDao.class);
		Idao.BookUpdate(roomnum,
				book_time,
				Integer.toString(book_total_time),
				request.getParameter("BOOK_DATE"),
				request.getParameter("BOOK_REASON"),
				request.getParameter("BOOK_MEMBER"),
				request.getParameter("BOOK_NUM"));
		request.setAttribute("page", page);
		request.setAttribute("month", month);
		request.setAttribute("roomnum", roomnum);
		String returnmsg ="예약을 수정하였습니다.";
		request.setAttribute("msg", returnmsg); 
		request.setAttribute("url", "./AdminReserList?roomnum="+roomnum+"&page="+page+"&month="+month);
		
		return "/alertredirect/redirect";
		
	}
	// 예약 현황 페이지 요청
	@RequestMapping("/AdminReserveStatus")
	public String AdminReserveStatus(HttpServletRequest request, HttpServletResponse response,Model model) {

		return "/admin_reserve/reserve_status.admintiles";
	}
	// 예약 현황 데이터 요청 처리
	@RequestMapping("/ReserveStatus")
	public void ReserveStatus(HttpServletRequest request, HttpServletResponse response,Model model) throws Exception{
		String roomnum=request.getParameter("roomnum");	
		List<RoomDto> itemList=null;
		new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String year ="";
		String month ="";
		String inputdate;
		int count=1;
		int page=1;			
		int pageSize=7;	
		year=request.getParameter("year");
		month=request.getParameter("month");
		if(request.getParameter("page")!=null){
			page=Integer.parseInt(request.getParameter("page"));
		}
		if(year ==null && month==null){
			inputdate = new java.text.SimpleDateFormat("yyyy").format(new java.util.Date())
					+"-"+ new java.text.SimpleDateFormat("MM").format(new java.util.Date());
		}else{
			inputdate = year +"-"+ (month.length() == 1 ? "0" + month : month);
		}
		AdminReserveIDao Idao = slqSession.getMapper(AdminReserveIDao.class);
		itemList= Idao.ReserveStatusList(roomnum,inputdate,page);
		count=Idao.ReserveStatusListCount(roomnum,inputdate);
		int pageCount=count/pageSize+(count % pageSize==0?0:1);
		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();
		for(int i=0;i<itemList.size();i++){
			obj.put( "BOOK_NUM", ((RoomDto) itemList.get(i)).getBOOK_NUM());
			obj.put( "BOOK_MEMBER", ((RoomDto) itemList.get(i)).getBOOK_MEMBER());
			obj.put( "BOOK_TIME", ((RoomDto) itemList.get(i)).getBOOK_TIME());
			obj.put( "BOOK_DATE", ((RoomDto) itemList.get(i)).getBOOK_DATE());
			arr.add(obj);
		}
		
		obj.put("page",page);
		arr.add(obj);
		obj.put("pageCount",pageCount);
		arr.add(obj);
	
		response.setHeader( "Content-Type", "text/html;charset=utf-8" );
		PrintWriter out = new PrintWriter( new OutputStreamWriter(response.getOutputStream(), "UTF-8" ) );
		out.print(arr);
		out.flush();
		out.close();
	}
	
}
