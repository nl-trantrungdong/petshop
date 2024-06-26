package vn.edu.hcmuaf.fit.controller;

import vn.edu.hcmuaf.fit.beans.UserAccount;
import vn.edu.hcmuaf.fit.services.LogService;
import vn.edu.hcmuaf.fit.services.LoginService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "LogoutController", value = "/api/v1/user/Logout")
public class LogoutController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session != null) {
            LogService logService= new LogService();

            if(session.getAttributeNames().equals("admin")) {
                UserAccount account = (UserAccount) request.getSession().getAttribute("admin");
                logService.createUserLog(account.getId(), "INFOR", "Admin " + account.getUsername() + " đăng xuất khỏi hệ thống");
            } else {
                UserAccount account = (UserAccount) request.getSession().getAttribute("user");
                logService.createUserLog(account.getId(), "INFOR", "Người dùng " + account.getUsername() + " đăng xuất khỏi hệ thống");
            }
            session.invalidate();
            response.setStatus(HttpServletResponse.SC_OK);
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // Set HTTP status code to 400 if session is null
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

}
