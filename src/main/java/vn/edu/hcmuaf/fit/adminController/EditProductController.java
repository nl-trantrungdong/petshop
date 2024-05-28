package vn.edu.hcmuaf.fit.adminController;

import com.google.gson.Gson;
import vn.edu.hcmuaf.fit.beans.UserAccount;
import vn.edu.hcmuaf.fit.dao.ProductDAO;
import vn.edu.hcmuaf.fit.filter.CartResponse;
import vn.edu.hcmuaf.fit.filter.EditProductResponse;
import vn.edu.hcmuaf.fit.services.LogService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;
import java.util.Arrays;

@WebServlet(name = "EditProductController", value = "/admin/edit-product")
public class EditProductController extends HttpServlet {

    EditProductResponse edtResponse;
    String jsonResponse;
    Gson gson = new Gson();
    PrintWriter out;

    // 5. processRequest()
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        // Lấy tham số input từ trang edit=product.jsp
        String pid = request.getParameter("id");
        String pname = request.getParameter("name");
        String pprice = request.getParameter("price");
        String quantity = request.getParameter("quantity");
        String pdescription = request.getParameter("description");
        String detail = request.getParameter("detail");
        String pgiong = request.getParameter("giong");
        String pmausac = request.getParameter("mausac");
        String pcannang = request.getParameter("cannang");
//        String oldImg = request.getParameter("oldImg");
        String CateParent = request.getParameter("CateParent");
        String cateChild = request.getParameter("cateChild");
        String status = request.getParameter("status");
        String Promotional = request.getParameter("Promotional");
        String PromotionalPrice = request.getParameter("PromotionalPrice");
        String[] imgFile = request.getParameterValues("imgFile[]");

        UserAccount AdminUser = (UserAccount) request.getSession().getAttribute("admin");
        ProductDAO dao = new ProductDAO();

        if (pid.equals("null")) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            // 6. Insert Product
            String id = dao.insertProduct(AdminUser.getId(),pname,pprice,pdescription,detail,quantity,pgiong,pmausac,pcannang,CateParent,cateChild,status,Promotional,PromotionalPrice, imgFile);
            // removeOldImg(oldImg, request);
            copyImage(request, imgFile);

            if(id == null){
                // 8. reponse {"reponseCode":?,"message":"?"}
                out = response.getWriter();
                edtResponse = new EditProductResponse(HttpServletResponse.SC_UNAUTHORIZED,"Lỗi dữ liệu không thêm được thú cưng mới"); // Giỏ hàng rỗng
                jsonResponse = new Gson().toJson(edtResponse);
                out.print(jsonResponse);
                out.flush();
            } else {
                // 8. reponse {"reponseCode":?,"message":"?"}
                out = response.getWriter();
                edtResponse = new EditProductResponse(HttpServletResponse.SC_UNAUTHORIZED,"Admin đã thêm sản phẩm thú cưng"); // Giỏ hàng rỗng
                jsonResponse = new Gson().toJson(edtResponse);
                out.print(jsonResponse);
                out.flush();
            }
        }else {
            dao.updateProduct(pid,AdminUser.getId(),pname,pprice,pdescription,detail,quantity,pgiong,pmausac,pcannang,CateParent,cateChild,status,Promotional,PromotionalPrice, imgFile);
//            removeOldImg(oldImg, request);
            copyImage(request, imgFile);

            LogService logService= new LogService();
            UserAccount userAccount = (UserAccount) request.getSession().getAttribute("admin");
            logService.createUserLog(userAccount.getId(), "INFOR", "Admin "+userAccount.getUsername()+" đã chỉnh sửa sản phẩm thú cưng "+dao.getProductDetail(pid).getProductName());
        }
    }
    private void removeOldImg(String oldImg, HttpServletRequest request) {
        if (oldImg.length() > 0) {
            String[] splited = oldImg.split(",");
            System.out.println(Arrays.toString(splited));
            for (String split : splited) {
                File fileInServer = new File(request.getServletContext().getAttribute("TEMPPRODUCT_DIR") + File.separator + split);
                if (fileInServer.exists())
                    fileInServer.delete();
                File fileInLocal = new File(request.getServletContext().getAttribute("FILEPRODUCT_DIR") + File.separator + split);
                if (fileInLocal.exists())
                    fileInLocal.delete();
            }
        }
    }

    public void copyImage(HttpServletRequest request, String[] imgFile) throws IOException {
        if (imgFile != null) {
            for (String fileName : imgFile) {
                if (fileName != null && !fileName.isEmpty()) {
                    File file = new File(request.getServletContext().getAttribute("TEMPPRODUCT_DIR") + File.separator + fileName);
                    if (file.exists()) {
                        File local = new File(request.getServletContext().getAttribute("FILEPRODUCT_DIR") + File.separator + fileName);
                        try (FileInputStream fis = new FileInputStream(file); FileOutputStream fos = new FileOutputStream(local)) {
                            byte[] bytes = new byte[1024];
                            int read;
                            while ((read = fis.read(bytes)) != -1) {
                                fos.write(bytes, 0, read);
                            }
                        }
                    } else {
                        throw new FileNotFoundException("File does not exist: " + file.getAbsolutePath());
                    }
                }
            }
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }
}
