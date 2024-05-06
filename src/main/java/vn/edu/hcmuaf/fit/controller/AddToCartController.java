package vn.edu.hcmuaf.fit.controller;

import com.google.gson.Gson;
import vn.edu.hcmuaf.fit.beans.Cart;
import vn.edu.hcmuaf.fit.beans.Product;
import vn.edu.hcmuaf.fit.beans.UserAccount;
import vn.edu.hcmuaf.fit.services.LogService;
import vn.edu.hcmuaf.fit.filter.CartResponse;
import vn.edu.hcmuaf.fit.services.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "AddToCartController", value = "/api/AddCartController")
public class AddToCartController extends HttpServlet {
    CartResponse cartResponse;
    long totalCartValue = 0;
    String jsonResponse;
    Gson gson = new Gson();
    PrintWriter out;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("idAdd");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        Cart cart = (Cart) request.getSession().getAttribute("cart");
        if (cart == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            out = response.getWriter();
            cartResponse = new CartResponse(HttpServletResponse.SC_UNAUTHORIZED,"Người dùng chưa đăng nhập", totalCartValue); // Giỏ hàng rỗng
            jsonResponse = new Gson().toJson(cartResponse);
            out.print(jsonResponse);
            out.flush();
            return;
        } else {
            Product product = ProductService.getInstance().getProductDetail(id);
            product.setQuantityCart(quantity);
            cart.put(id, product);
            request.getSession().setAttribute("cart", cart);

            // Lấy tổng giá trị giỏ hàng
            long totalCartValue = (long) cart.total();

            // Gửi về JSON response
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");


            // Tạo một đối tượng JSON để chứa thông báo thành công và tổng giá trị giỏ hàng

            cartResponse = new CartResponse(HttpServletResponse.SC_OK,"Thêm vào giỏ hàng thành công", totalCartValue);
            String jsonResponse = gson.toJson(cartResponse);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            out = response.getWriter();
            out.print(jsonResponse);
            out.flush();

            // Ghi log
            LogService logService = new LogService();
            UserAccount user = (UserAccount) request.getSession().getAttribute("user");
            logService.createUserLog(user.getId(), "INFOR", "Người dùng " + user.getUsername() + " đã thêm " + product.getProductName() + " vào giỏ hàng");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Để lại trống vì bạn không sử dụng phương thức POST
    }
}
