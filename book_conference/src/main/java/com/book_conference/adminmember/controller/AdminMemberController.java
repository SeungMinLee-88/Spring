package com.book_conference.adminmember.controller;
import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.book_conference.adminmember.dao.AdminMemberIDao;
import com.book_conference.adminmember.dto.ApplyContentDto;
import com.book_conference.member.dao.MemberIDao;
import com.book_conference.member.dto.MemberContentDto;
import com.book_conference.adminmember.controller.MailSend;


@Controller
public class AdminMemberController {
@Autowired
	private SqlSession slqSession;
	
	// 이용 신청 리스트
	@RequestMapping("/AdminMemberApplyList")
	public String AdminMemberApplyList(HttpServletRequest request, HttpServletResponse response,Model model) {
		
		List<ApplyContentDto> itemList=null;
		int count=1;
		int page=1;			
		int pageSize=7;		
		if(request.getParameter("page")!=null){
			page=Integer.parseInt(request.getParameter("page"));
		}
		AdminMemberIDao Idao = slqSession.getMapper(AdminMemberIDao.class);
		itemList= Idao.SelectApplyList(page);
		count = Idao.SelectApplyListCount(page);
		
		int pageCount=count/pageSize+(count % pageSize==0?0:1);
		int startPage=(int)((page-1)/10)*10+1;
		int endPage=startPage+10-1;
		if (endPage>pageCount) endPage=pageCount;
		
		request.setAttribute("itemList", itemList);
		request.setAttribute("count", page);
		request.setAttribute("pageCount", pageCount);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		return "/admin_member/admin_memberapply_list.admintiles";
	}
	// 이용 신청에 대한 처리
	@RequestMapping("/ApplyProcess")
	public String ApplyProcess(
			HttpServletRequest request,HttpServletResponse response, Model model) throws IOException{
		String returnmsg ="";
		int page=1;	
		AdminMemberIDao Idao = slqSession.getMapper(AdminMemberIDao.class);
		Idao.UpdateApply(request.getParameter("status"),request.getParameter("APPLY_NUM"));
		ApplyContentDto dto =Idao.SelectApply(request.getParameter("APPLY_NUM"));
		if(request.getParameter("status").equals("a")){
			Idao.ApproveApply(request.getParameter("APPLY_NUM"));
			returnmsg ="승인 처리가 완료되었습니다.";
			MailSend.MailSendProcess(dto.getMEMBER_EMAIL(), request.getParameter("status"),dto.getMEMBER_NAME());
		}else if(request.getParameter("status").equals( "r")){
			returnmsg ="반려 처리가 완료되었습니다.";
			MailSend.MailSendProcess(dto.getMEMBER_EMAIL(), request.getParameter("status"),dto.getMEMBER_NAME());
		}else{
		}
		if(request.getParameter("page")!=null){
			page=Integer.parseInt(request.getParameter("page"));
		}
		request.setAttribute("msg", returnmsg); 
		request.setAttribute("url", "./AdminMemberApplyList?page="+page);
		return "/alertredirect/redirect";
	}
	// 사용자 리스트
	@RequestMapping("/AdminMemberList")
	public String AdminMemberList(HttpServletRequest request, HttpServletResponse response,Model model) {
		String memdept=null;
		String memdeptcode=null;
		String memname=null;
		String memid=null;
		// 사용자 리스트 검색 처리
		if(request.getParameter("memdept")!=null && request.getParameter("memdept")!=""){
			memdept=request.getParameter("memdept");
		}
		if(request.getParameter("memdeptcode")!=null && request.getParameter("memdeptcode")!=""){
			memdeptcode=request.getParameter("memdeptcode");
		}
		if(request.getParameter("memname")!=null && request.getParameter("memname")!=""){
			memname=request.getParameter("memname");
		}
		if(request.getParameter("memid")!=null && request.getParameter("memid")!=""){
			memid=request.getParameter("memid");
		}
		List<MemberContentDto> itemList=null;
		int count=1;
		int page=1;			
		int pageSize=7;		
		if(request.getParameter("page")!=null){
			page=Integer.parseInt(request.getParameter("page"));
		}
		AdminMemberIDao Idao = slqSession.getMapper(AdminMemberIDao.class);
		itemList= Idao.SelectMemberList(memdeptcode,memname,memid,page);
		count = Idao.SelectMemberCount(memdeptcode,memname,memid);
		int pageCount=count/pageSize+(count % pageSize==0?0:1);
		int startPage=(int)((page-1)/10)*10+1;
		int endPage=startPage+10-1;
		if (endPage>pageCount) endPage=pageCount;
		
		// 사용자 리스트 및 검색 키워드
		request.setAttribute("itemList", itemList);
		request.setAttribute("memdept", memdept);
		request.setAttribute("memdeptcode", memdeptcode);
		request.setAttribute("memname", memname);
		request.setAttribute("memid", memid);
		request.setAttribute("count", page);
		request.setAttribute("pageCount", pageCount);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		
		return "/admin_member/admin_member_list.admintiles";
	}
	
	// 사용자 삭제
	@RequestMapping("/AdminDeleteMember")
	public String AdminDeleteMember(HttpServletRequest request, HttpServletResponse response,Model model) {
		String member_number=null;
		String memdept=null;
		String memdeptcode=null;
		String memname=null;
		String memid=null;
		if(request.getParameter("member_number")!=null && request.getParameter("member_number")!=""){
			member_number=request.getParameter("member_number");
		}
		if(request.getParameter("memdept")!=null && request.getParameter("memdept")!=""){
			memdept=request.getParameter("memdept");
		}
		if(request.getParameter("memdeptcode")!=null && request.getParameter("memdeptcode")!=""){
			memdeptcode=request.getParameter("memdeptcode");
		}
		if(request.getParameter("memname")!=null && request.getParameter("memname")!=""){
			memname=request.getParameter("memname");
		}
		if(request.getParameter("memid")!=null && request.getParameter("memid")!=""){
			memid=request.getParameter("memid");
		}
		int page=1;			
		if(request.getParameter("page")!=null){
			page=Integer.parseInt(request.getParameter("page"));
		}
		AdminMemberIDao Idao = slqSession.getMapper(AdminMemberIDao.class);
		Idao.DeleteMember(member_number);
		request.setAttribute("memdept", memdept);
		request.setAttribute("memdeptcode", memdeptcode);
		request.setAttribute("memname", memname);
		request.setAttribute("memid", memid);
		request.setAttribute("count", page);
		String returnmsg ="이용자를 삭제하였습니다.";
		request.setAttribute("msg", returnmsg); 
		request.setAttribute("url", "./AdminMemberList?page="+page);
		return "/alertredirect/redirect";
	}
	
	
	@RequestMapping("/AdminDeptList")
	public String SelectDeptList(HttpServletRequest request,Model model){

		MemberIDao Idao = slqSession.getMapper(MemberIDao.class);
		model.addAttribute("dept_list", Idao.SelectDeptList(null, null));
		
		return "/admin_member/admin_dept_list";
	}
	
}
