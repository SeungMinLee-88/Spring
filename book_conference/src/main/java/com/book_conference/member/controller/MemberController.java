package com.book_conference.member.controller;

import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.book_conference.member.dao.MemberIDao;
import com.book_conference.member.dto.DeptContentDto;
import com.book_conference.member.dto.MemberContentDto;
import com.book_conference.member.controller.MailSend;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class MemberController {

		@Autowired
		private SqlSession slqSession;
		

		@RequestMapping(value = "/", method = RequestMethod.GET)
		public String home(Locale locale, Model model) {
			
			return "/member/main_login";
		}
		// 메인 로그인 화면
		@RequestMapping("/MainLogin")
		public String writeForm() {
			
			return "/member/main_login";
		}
		// 이용 신청 페이지 요청
		@RequestMapping("/DeptList")
		public String SelectDeptList(HttpServletRequest request,Model model){

			MemberIDao Idao = slqSession.getMapper(MemberIDao.class);
			model.addAttribute("dept_list", Idao.SelectDeptList(null, null));
			
			return "/member/dept_list";
		}

		// ID 중복 체크
		@RequestMapping("/MemberIDCheck")
		public String MemberIDCheck(HttpServletRequest request,Model model){
			String id=request.getParameter("MEMBER_ID");
			MemberIDao Idao = slqSession.getMapper(MemberIDao.class);
			int check = Idao.ConfirmId(id);
			
			request.setAttribute("id", id);
			request.setAttribute("check", check);
			
			return "/member/member_idchk";
		}
		
		// 이용신청 페이지의 부서 목록 요청
		@RequestMapping("/GetDeptList")
		public void GetDeptList(HttpServletRequest request,HttpServletResponse response,Model model)
				 throws Exception{

			MemberIDao Idao = slqSession.getMapper(MemberIDao.class);

			String code;
			if(request.getParameter("depth").equals("0")){
				code = null;
			}else{
				code = request.getParameter("code");
			}
			
			model.addAttribute("dept_list", Idao.SelectDeptList(request.getParameter("depth"),code));
			
			
			ArrayList<DeptContentDto> itemList=null;
			itemList =Idao.SelectDeptList(request.getParameter("depth"),code);
			JSONArray arr = new JSONArray();
			JSONObject obj = new JSONObject();
			for(int i=0;i<itemList.size();i++){
				int DeptCount =0;
				int UserCount =0;
				obj.put( "DEPT_NUM", ((DeptContentDto) itemList.get(i)).getDEPT_NUM());
				obj.put( "DEPT_CODE", ((DeptContentDto) itemList.get(i)).getDEPT_CODE());
				obj.put( "DEPT_NAME", ((DeptContentDto) itemList.get(i)).getDEPT_NAME());
				obj.put( "DEPT_DEPTH", ((DeptContentDto) itemList.get(i)).getDEPT_DEPTH());
				
				String repcode =((DeptContentDto) itemList.get(i)).getDEPT_CODE();
				repcode = repcode.replace("0", "");
				String depthval = ((DeptContentDto) itemList.get(i)).getDEPT_DEPTH();
				DeptCount = Idao.SelectDeptCount(depthval,repcode);
				UserCount = 
				Idao.SelectUserCount(((DeptContentDto) itemList.get(i)).getDEPT_CODE());
				obj.put( "DEPT_CHILD", DeptCount);
				obj.put( "USER_CHILD", UserCount);
				arr.add(obj);
			}
			
			response.setHeader( "Content-Type", "text/html;charset=utf-8" );
			PrintWriter out = new PrintWriter( new OutputStreamWriter(response.getOutputStream(), "UTF-8" ) );
			out.print(arr);
			out.flush();
			out.close();
		}
		//이용 신청 처리
		@RequestMapping("/JoinApply")
		public void JoinApply
		(HttpServletRequest request, HttpServletResponse response,Model model)
		throws IOException{
			
			MemberIDao Idao = slqSession.getMapper(MemberIDao.class);
			
			String EMAIL = request.getParameter("MEMBER_EMAIL1")+"@"+
					request.getParameter("MEMBER_EMAIL2");
			
			Idao.JoinApply(request.getParameter("MEMBER_NAME"), 
					request.getParameter("MEMBER_DEPTNAME"),
					request.getParameter("MEMBER_DEPTCODE"),
					request.getParameter("MEMBER_ID"),
					request.getParameter("MEMBER_PW"),
					EMAIL);
			response.setContentType("text/html; charset=euc-kr");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('신청되었습니다.');");
			out.println("location.href='./dept_list?close=y';");
			out.println("</script>");			
			out.close();	
		}
		// 로그인 처리
		@RequestMapping("/MemberLogin")
		public String MemberLogin
		(HttpServletRequest request, HttpServletResponse response,Model model)
		throws IOException{
			
			HttpSession session=request.getSession();
			
			String id=request.getParameter("MEMBER_ID");
			String pass=request.getParameter("MEMBER_PW");	
			
			MemberIDao Idao = slqSession.getMapper(MemberIDao.class);

			int check=Idao.userCheck(id, pass);
			String admin;
						
			if(check == 1){
				admin = Idao.isAdmin(id);
				session.setAttribute("id", id);
				session.setAttribute("admin", admin);
				if(admin.equals("y")){
					return "redirect:/AdminReserve";
				}else if(admin.equals("n")){
					return "redirect:/MemberReserve";
				}else{
					return "redirect:/MemberReserve";
				}
			
			}else if(check == 0){
				String returnmsg ="아이디 또는 패스워드가 일치하지 않습니다.";
				request.setAttribute("msg", returnmsg); 
				request.setAttribute("url", "./main_login");
				
				return "/alertredirect/redirect";
			}
			return null;	
		}
		// 로그아웃 처리
		@RequestMapping("/MemberLogout")
		public String MemberLogout
		(HttpServletRequest request, HttpServletResponse response,Model model)
		throws IOException{
			HttpSession session=request.getSession();
			session.invalidate();
			String returnmsg ="로그아웃 되었습니다.";
			request.setAttribute("msg", returnmsg); 
			request.setAttribute("url", "./main_login");
			
			return "/alertredirect/redirect";
		}
		// 패스워드 찾기 페이지 요청
		@RequestMapping("/MemberFindPw")
		public String MemberFindPw
		(HttpServletRequest request, HttpServletResponse response,Model model)
		throws IOException{
			
			return "/member/main_find";
		}
		// 패스워드 찾기 처리
		@RequestMapping("/MemberFindPwProcess")
		public String MemberFindPwProcess
		(HttpServletRequest request, HttpServletResponse response,Model model)
		throws IOException{

			MemberIDao Idao = slqSession.getMapper(MemberIDao.class);
			int result =0;
			result = Idao.MemberFindPwProcess(
			request.getParameter("MEMBER_ID"),
			request.getParameter("MEMBER_EMAIL"));
			if(result<1){
			
			String returnmsg ="입력하신 정보가 존재하지 않습니다.";
			request.setAttribute("msg", returnmsg); 
			request.setAttribute("url", "./MemberFindPw");
			return "/alertredirect/redirect";
			
			}else if(result>=1){
			MemberContentDto Dto;
			Dto = Idao.SelectMemberInfo(request.getParameter("MEMBER_ID"));
			MailSend.MailSendProcess(Dto.getMEMBER_EMAIL(), Dto.getMEMBER_NAME(),Dto.getMEMBER_PW());
				String returnmsg ="이메일로 패스워드가 발송되었습니다.";
				request.setAttribute("msg", returnmsg); 
				request.setAttribute("url", "./main_login");
				return "/member/main_find_result";
			}
			return null;
		}
		
		// 사용자 정보 수정 페이지 요청
		@RequestMapping("/MemberModify")
		public String MemberModify
		(HttpServletRequest request, HttpServletResponse response,Model model)
		throws IOException{
			HttpSession session=request.getSession(); 
			String memberId = (String)session.getAttribute("id"); 
			MemberIDao Idao = slqSession.getMapper(MemberIDao.class);
			MemberContentDto Dto;
			Dto = Idao.SelectMemberInfo(memberId);
			request.setAttribute("Dto", Dto);
			return "/member/member_modify.tiles";
		}
		// 사용자 정보 수정 처리
		@RequestMapping("/MemberModifyProcess")
		public String MemberModifyProcess
		(HttpServletRequest request, HttpServletResponse response,Model model)
		throws IOException{
			HttpSession session=request.getSession(); 
			String memberId = (String)session.getAttribute("id"); 
			MemberIDao Idao = slqSession.getMapper(MemberIDao.class);
			
			String EMAIL = request.getParameter("MEMBER_EMAIL1")+"@"+
					request.getParameter("MEMBER_EMAIL2");
			
			Idao.MemberModifyProcess(
					request.getParameter("MEMBER_NAME"), 
					request.getParameter("MEMBER_DEPTNAME"),
					request.getParameter("MEMBER_DEPTCODE"),
					request.getParameter("MEMBER_PW"),
					EMAIL, memberId);
			String returnmsg ="수정 되었습니다.";
			request.setAttribute("msg", returnmsg); 
			request.setAttribute("url", "./MemberModify");
			return "/alertredirect/redirect";
		}
		// 사용자 정보 수정 부서 요청
		@RequestMapping("/ModiDeptList")
		public String modi_dept_list(HttpServletRequest request,Model model){

			MemberIDao Idao = slqSession.getMapper(MemberIDao.class);
			model.addAttribute("dept_list", Idao.SelectDeptList(null, null));
			
			return "/member/modi_dept_list";
		}
		

}
