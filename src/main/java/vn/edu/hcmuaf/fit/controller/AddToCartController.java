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

@WebServlet(name = "AddToCartController", value = "/api/v1/Cart/Add")
public class AddToCartController extends HttpServlet {
    CartResponse cartResponse;
    long totalCartValue = 0;
    String jsonResponse;
    Gson gson = new Gson();
    PrintWriter out;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

   // 5. doPost()
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("idAdd");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        Cart cart = (Cart) request.getSession().getAttribute("cart");
        Product product = ProductService.getInstance().getProductDetail(id);
        if (cart == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            //6. reponse {"reponseCode":?,"message":"?","totalCartValue":?}
            out = response.getWriter();
            cartResponse = new CartResponse(HttpServletResponse.SC_UNAUTHORIZED,"Người dùng chưa đăng nhập", totalCartValue); // Giỏ hàng rỗng
            jsonResponse = new Gson().toJson(cartResponse);
            out.print(jsonResponse);
            out.flush();
            return;
        } else if (product.getQuantity().equals("0")){
            System.out.println(product.getQuantity());
            //6. reponse {"reponseCode":?,"message":"?","totalCartValue":?}
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            out = response.getWriter();
            cartResponse = new CartResponse(HttpServletResponse.SC_BAD_REQUEST,"Sản phẩm không còn hàng", totalCartValue); // Giỏ hàng rỗng
            jsonResponse = new Gson().toJson(cartResponse);
            out.print(jsonResponse);
            out.flush();
        }else {
            product.setQuantityCart(quantity);
            cart.put(id, product);
            request.getSession().setAttribute("cart", cart);
            // Lấy tổng giá trị giỏ hàng
            long totalCartValue = (long) cart.total();
            // Gửi về JSON response
            // 6. reponse {"reponseCode":?,"message":"?","totalCartValue":?}
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
}
