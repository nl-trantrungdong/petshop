package vn.edu.hcmuaf.fit.adminController;

import vn.edu.hcmuaf.fit.beans.OrderDetail;
import vn.edu.hcmuaf.fit.beans.Orders;
import vn.edu.hcmuaf.fit.beans.PublicKey;
import vn.edu.hcmuaf.fit.dao.KeyDAO;
import vn.edu.hcmuaf.fit.dao.OrderDAO;
import vn.edu.hcmuaf.fit.services.OrderService;
import vn.edu.hcmuaf.fit.tool.DSA;
import vn.edu.hcmuaf.fit.tool.Hash;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet(name = "VerifyOrderController", value = "/VerifyOrderController")
public class VerifyOrderController extends HttpServlet {
    // 20130260-Hoàng Trung Hiếu
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderID = request.getParameter("orderId");
        OrderService orderService = new OrderService();
        Orders orders = orderService.getOrderByIdOrder(orderID);
        String decryptedHashMessage = orders.getHashMessage();
        orderService.changeStatusVerify(orders.getOrderID(), 1);

//        String hashMessage = orders.getRecipientName()+orders.getPhone()+orders.getAddress()
//                +orders.getEmail()+orders.getNotice()+orders.getPrice();
//        List<OrderDetail> list = orderService.getOrderDetailsById(orders.getOrderID());
//        for (int i = 0; i < list.size(); i++) {
//            OrderDetail orderDetail = list.get(i);
//            // đưa kiểu decimal trong db thành kiểu long
//            BigDecimal decimalValue = BigDecimal.valueOf(orderDetail.getPrice());
//            long longValue = decimalValue.longValueExact() / orderDetail.getQuantity();
//            hashMessage += orderDetail.getProductID()+orderDetail.getProductName()
//                    +longValue+orderDetail.getPricePromotional()+orderDetail.getQuantity();
//        }
//        String hashMessage = orderService.createHashMessageWithOrder(orders);
//        System.out.println(hashMessage);
//        DSA dsa = new DSA();
//        PublicKey publicKey = new KeyDAO().getPublicKey(orders.getCustomerID(), orders.getOrderDate());
//        String hash = new Hash().hashString(hashMessage);
//        try {
//            if (dsa.verify(hash,decryptedHashMessage,dsa.convertStringToPublicKey(publicKey.getPublicKey()))) {
//                orderService.changeStatusVerify(orders.getOrderID(), 1);
//            } else {
//                orderService.changeStatusVerify(orders.getOrderID(), 2);
//            }
//        } catch (Exception e) {
//            throw new RuntimeException(e);
//        }
//        response.sendRedirect("/admin/products-status.jsp");
        response.sendRedirect("/ajax/admin-ajax-loadOrder.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}