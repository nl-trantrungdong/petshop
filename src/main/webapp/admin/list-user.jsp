<%@ page import="vn.edu.hcmuaf.fit.beans.UserAccount" %>
<%@ page import="java.util.List" %>
<%@ page import="vn.edu.hcmuaf.fit.dao.CustomerUserDAO" %>
<%@ page import="vn.edu.hcmuaf.fit.services.OrderService" %>
<%@ page import="vn.edu.hcmuaf.fit.beans.Orders" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="vn.edu.hcmuaf.fit.beans.AdminRole" %>
<%@ page import="vn.edu.hcmuaf.fit.services.UserService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Quản lý Petshop</title>
    <!-- HTML5 Shim and Respond.js IE11 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 11]>
    	<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    	<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    	<![endif]-->
    <!-- Meta -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="description" content="DashboardKit is made using Bootstrap 5 design framework. Download the free admin template & use it for your project.">
    <meta name="keywords" content="DashboardKit, Dashboard Kit, Dashboard UI Kit, Bootstrap 5, Admin Template, Admin Dashboard, CRM, CMS, Free Bootstrap Admin Template">
    <meta name="author" content="DashboardKit ">


    <!-- Favicon icon -->
    <link rel="icon" href="assets/images/favicon.svg" type="image/x-icon">

    <!-- font css -->
    <link rel="stylesheet" href="assets/fonts/feather.css">
    <link rel="stylesheet" href="assets/fonts/fontawesome.css">
    <link rel="stylesheet" href="assets/fonts/material.css">

    <!-- vendor css -->
    <link rel="stylesheet" href="assets/css/style.css" id="main-style-link">
    <script src="bonus/js/imageloaded.min.js"></script>

    <!-- ===============================================-->
    <!--    Stylesheets-->
    <!-- ===============================================-->
    <link href="bonus/css/dropzone.min.css" rel="stylesheet" />
    <link href="bonus/css/line.css" rel="stylesheet" />
    <link href="bonus/css/choices.min.css" rel="stylesheet" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="" />
    <link
      href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@300;400;600;700;800;900&amp;display=swap"
      rel="stylesheet"
    />
    <link
      rel="stylesheet"
      href="https://unicons.iconscout.com/release/v4.0.0/css/line.css"
    />
    <link
      href="bonus/css/theme.min.css"
      type="text/css"
      rel="stylesheet"
      id="style-default"
    />
    <link
      href="../../../assets/css/user.min.css"
      type="text/css"
      rel="stylesheet"
      id="user-style-default"
    />
    <link
      rel="stylesheet"
      type="text/css"
      id="mce-u0"
      href="bonus/css/skin.min.css"
    />
</head>
<%
    if (request.getSession().getAttribute("admin") == null) {
        response.sendRedirect("/login.jsp");
    } else {
        UserAccount admin = (UserAccount) request.getSession().getAttribute("admin");
        boolean check = false;
        for (AdminRole role : admin.getRole()) {
            if (role.getTableName().equals("userAccount")) {
                check = true;
                break;
            }
        }
        if (!check) {%>
<script>
    window.location.href = 'index.jsp';
    alert("Tài khoản không có quyền này!");
</script>
<% } else {
%>
<body class="">
	<!-- [ Pre-loader ] start -->
	<div class="loader-bg">
		<div class="loader-track">
			<div class="loader-fill"></div>
		</div>
	</div>
	<!-- [ Pre-loader ] End -->
	<!-- [ Mobile header ] start -->
	<div class="pc-mob-header pc-header">
		<div class="pcm-logo">
			<img src="assets/images/logo.svg" alt="" class="logo logo-lg">
		</div>
		<div class="pcm-toolbar">
			<a href="#!" class="pc-head-link" id="mobile-collapse">
				<div class="hamburger hamburger--arrowturn">
					<div class="hamburger-box">
						<div class="hamburger-inner"></div>
					</div>
				</div>
			</a>
			<a href="#!" class="pc-head-link" id="headerdrp-collapse">
				<i data-feather="align-right"></i>
			</a>
			<a href="#!" class="pc-head-link" id="header-collapse">
				<i data-feather="more-vertical"></i>
			</a>
		</div>
	</div>
	<!-- [ Mobile header ] End -->

	<!-- [ navigation menu ] start -->
	<nav class="pc-sidebar ">
		<div class="navbar-wrapper">
			<div class="m-header">
				<a href="index.jsp" class="b-brand">
					<!-- ========   change your logo hear   ============ -->
					<img src="assets/images/logo.png" alt="" class="logo logo-lg">
					<img src="assets/images/logo-sm.svg" alt="" class="logo logo-sm">
				</a>
			</div>
			<div class="navbar-content">
        <ul class="pc-navbar">
            <li class="pc-item pc-caption">
                <label>Quản lý</label>
            </li>
            <li class="pc-item">
                <a href="index.jsp" class="pc-link "><span class="pc-micon"><i class="material-icons-two-tone">home</i></span><span class="pc-mtext">Quản lý chung</span></a>
            </li>
            <li class="pc-item pc-caption">
                <label>Quản lý sản phẩm</label>
                <!-- <span>UI Components</span> -->
            </li>
            <li class="pc-item pc-hasmenu">
                <a href="#!" class="pc-link "><span class="pc-micon"><i data-feather="github">business_center</i></span><span class="pc-mtext">Thú cưng</span><span class="pc-arrow"><i data-feather="chevron-right"></i></span></a>
                <ul class="pc-submenu">
                    <li class="pc-item"><a class="pc-link" href="list-products">Danh sách thú cưng</a></li>
                    <li class="pc-item"><a class="pc-link" href="edit-product.jsp">Thêm thú cưng</a></li>
                </ul>
            </li>
            <li class="pc-item pc-hasmenu">
                <a href="#!" class="pc-link "><span class="pc-micon"><i class="material-icons-two-tone">business_center</i></span><span class="pc-mtext">Phụ kiện</span><span class="pc-arrow"><i data-feather="chevron-right"></i></span></a>
                <ul class="pc-submenu">
                    <li class="pc-item"><a class="pc-link" href="list-accessory">Danh sách phụ kiện</a></li>
                    <li class="pc-item"><a class="pc-link" href="edit-accessory.jsp">Thêm phụ kiện</a></li>
                </ul>
            </li>
            <li class="pc-item">
                <a href="import.jsp" class="pc-link "><span class="pc-micon"><i
                        class="material-icons-two-tone">home</i></span><span class="pc-mtext">Nhập sản phẩm</span></a>
            </li>
            <li class="pc-item">
                <a href="products-status.jsp" class="pc-link "><span class="pc-micon"><i class="material-icons-two-tone">history_edu</i></span><span class="pc-mtext">Tình trạng đơn hàng</span></a>
            </li>
            <li class="pc-item pc-caption">
                <label>Quản lý tin tức</label>
            </li>
            <li class="pc-item pc-hasmenu">
                <a href="#!" class="pc-link "><span class="pc-micon"><i class="material-icons-two-tone" data-feather="file-minus"></i></span><span class="pc-mtext">Tin tức</span><span class="pc-arrow"><i data-feather="chevron-right"></i></span></a>
                <ul class="pc-submenu">
                    <li class="pc-item"><a class="pc-link" href="list-blog.jsp">Danh sách tin tức</a></li>
                    <li class="pc-item"><a class="pc-link" href="add-blog.jsp">Thêm tin tức</a></li>
                </ul>
            </li>
            <li class="pc-item pc-caption">
                <label>Quản lý danh mục</label>
            </li>
            <li class="pc-item">
                <a href="list-category.jsp" class="pc-link "><span class="pc-micon"><i
                        class="material-icons-two-tone">history_edu</i></span><span class="pc-mtext">Danh sách danh mục</span></a>
            </li>
            <li class="pc-item pc-hasmenu">
                <a href="#!" class="pc-link "><span class="pc-micon"><i class="material-icons-two-tone"
                                                                        data-feather="file-minus"></i></span><span
                        class="pc-mtext">Thêm danh mục</span><span class="pc-arrow"><i
                        data-feather="chevron-right"></i></span></a>
                <ul class="pc-submenu">
                    <li class="pc-item"><a class="pc-link" href="add-category-product.jsp">Danh mục sản phẩm</a></li>
                    <li class="pc-item"><a class="pc-link" href="add-category-blog.jsp">Danh mục tin tức</a></li>
                </ul>
            </li>
            <li class="pc-item pc-caption">
                <label>Tài khoản</label>
            </li>
            <li class="pc-item pc-hasmenu">
                <a href="#!" class="pc-link "><span class="pc-micon"><i class="material-icons-two-tone" data-feather="cpu"></i></span><span class="pc-mtext">Admin</span><span class="pc-arrow"><i data-feather="chevron-right"></i></span></a>
                <ul class="pc-submenu">
                    <li class="pc-item"><a class="pc-link" href="list-admin.jsp">Danh sách admin</a></li>
                    <li class="pc-item"><a class="pc-link" href="add-admin.jsp">Thêm admin</a></li>
                </ul>
            </li>
            <li class="pc-item pc-hasmenu">
                <a href="#!" class="pc-link "><span class="pc-micon"><i class="material-icons-two-tone" data-feather="user"></i></span><span class="pc-mtext">Người dùng</span><span class="pc-arrow"><i data-feather="chevron-right"></i></span></a>
                <ul class="pc-submenu">
                    <li class="pc-item"><a class="pc-link" href="list-user.jsp?role=1">Danh sách người dùng</a></li>
                    <li class="pc-item"><a class="pc-link" href="add-user.jsp">Thêm người dùng</a></li>
                </ul>
            </li>
            <li class="pc-item pc-caption">
                <label>Quản lý bình luận</label>
            </li>
            <li class="pc-item">
                <a href="list-comment.jsp" class="pc-link "><span class="pc-micon"><i data-feather="message-circle">history_edu</i></span><span class="pc-mtext">Bình luận</span></a>
            </li>
            <li class="pc-item pc-caption">
                <label>Quản lý liên hệ</label>
            </li>
            <li class="pc-item">
                <a href="list-contact.jsp" class="pc-link "><span class="pc-micon"><i data-feather="message-circle">history_edu</i></span><span class="pc-mtext">Liên hệ</span></a>
            </li>
        </ul>
    </div>
		</div>
	</nav>
	<!-- [ navigation menu ] end -->
	<!-- [ Header ] start -->
    <jsp:include page="layout-admin/header-admin.jsp"></jsp:include>
	<!-- [ Header ] end -->

<!-- [ Main Content ] start -->
<div class="pc-container">
    <div class="pcoded-content">
        <!-- [ breadcrumb ] start -->
        <div class="page-header">
            <div class="page-block">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <!-- <div class="page-header-title">
                            <h5 class="m-b-10">Dashboard sale</h5>
                        </div> -->
                        <ul class="breadcrumb">
                            <li class="breadcrumb-item">Tài khoản</li>
                            <li class="breadcrumb-item">Người dùng</li>
                            <li class="breadcrumb-item">Danh sách người dùng</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
          <div class="mb-9">
            <div class="row g-2 mb-4">
              <div class="">
                <h2 class="" style="margin-top: 20px; text-align: center;">Danh sách người dùng</h2>
              </div>
            </div>
<%--            <ul class="nav nav-links mb-3 mb-lg-2 mx-n3">--%>
<%--              <li class="nav-item"><a class="nav-link active" aria-current="page" href="#">Tất cả <span class="text-700 fw-semi-bold">(688)</span></a></li>--%>
<%--              <li class="nav-item"><a class="nav-link" href="#">Mới <span class="text-700 fw-semi-bold">(6)</span></a></li>--%>
<%--              <li class="nav-item"><a class="nav-link" href="#">Số người theo dõi <span class="text-700 fw-semi-bold">(8)</span></a></li>--%>
<%--              <li class="nav-item"><a class="nav-link" href="#">Tất cả nhận xét <span class="text-700 fw-semi-bold">(2)</span></a></li>--%>
<%--            </ul>--%>
            <div id="products" data-list="{&quot;valueNames&quot;:[&quot;customer&quot;,&quot;email&quot;,&quot;total-orders&quot;,&quot;total-spent&quot;,&quot;city&quot;,&quot;last-seen&quot;,&quot;last-order&quot;],&quot;page&quot;:10,&quot;pagination&quot;:true}">
              <div class="mb-4">
                <div class="row g-3">
                  <div class="col-auto">
                    <div class="search-box">
                      <form class="position-relative" data-bs-toggle="search" data-bs-display="static"><input class="form-control search-input search" type="search" placeholder="Tìm người dùng" aria-label="Search">
                        <svg class="svg-inline--fa fa-magnifying-glass search-box-icon" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="magnifying-glass" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg=""><path fill="currentColor" d="M500.3 443.7l-119.7-119.7c27.22-40.41 40.65-90.9 33.46-144.7C401.8 87.79 326.8 13.32 235.2 1.723C99.01-15.51-15.51 99.01 1.724 235.2c11.6 91.64 86.08 166.7 177.6 178.9c53.8 7.189 104.3-6.236 144.7-33.46l119.7 119.7c15.62 15.62 40.95 15.62 56.57 0C515.9 484.7 515.9 459.3 500.3 443.7zM79.1 208c0-70.58 57.42-128 128-128s128 57.42 128 128c0 70.58-57.42 128-128 128S79.1 278.6 79.1 208z"></path></svg><!-- <span class="fas fa-search search-box-icon"></span> Font Awesome fontawesome.com -->
                      </form>
                    </div>
                  </div>
<%--                  <div class="col-auto scrollbar overflow-hidden-y flex-grow-1">--%>
<%--                    <div class="btn-group position-static" role="group">--%>
<%--                      <div class="btn-group position-static text-nowrap"><button class="btn btn-phoenix-secondary px-7 flex-shrink-0" type="button" data-bs-toggle="dropdown" data-boundary="window" aria-haspopup="true" aria-expanded="false" data-bs-reference="parent"> Tỉnh thành<svg class="svg-inline--fa fa-angle-down ms-2" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="angle-down" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512" data-fa-i2svg=""><path fill="currentColor" d="M192 384c-8.188 0-16.38-3.125-22.62-9.375l-160-160c-12.5-12.5-12.5-32.75 0-45.25s32.75-12.5 45.25 0L192 306.8l137.4-137.4c12.5-12.5 32.75-12.5 45.25 0s12.5 32.75 0 45.25l-160 160C208.4 380.9 200.2 384 192 384z"></path></svg><!-- <span class="fas fa-angle-down ms-2"></span> Font Awesome fontawesome.com --></button>--%>
<%--                        <ul class="dropdown-menu">--%>
<%--                          <li><a class="dropdown-item" href="#">TP.HCM</a></li>--%>
<%--                          <li><a class="dropdown-item" href="#">Hà nội</a></li>--%>
<%--                          <li><a class="dropdown-item" href="#">Tỉnh thành khác</a></li>--%>
<%--                        </ul>--%>
<%--                      </div>--%>
<%--                    </div>--%>
<%--                  </div>--%>
                  <div class="col-auto">
                      <button href="add-user.jsp" class="btn btn-primary"><svg class="svg-inline--fa fa-plus me-2" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="plus" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg=""><path fill="currentColor" d="M432 256c0 17.69-14.33 32.01-32 32.01H256v144c0 17.69-14.33 31.99-32 31.99s-32-14.3-32-31.99v-144H48c-17.67 0-32-14.32-32-32.01s14.33-31.99 32-31.99H192v-144c0-17.69 14.33-32.01 32-32.01s32 14.32 32 32.01v144h144C417.7 224 432 238.3 432 256z"></path></svg><!-- <span class="fas fa-plus me-2"></span> Font Awesome fontawesome.com -->Thêm người dùng</button></div>
                </div>
              </div>
              <div class="mx-n4 px-4 mx-lg-n6 px-lg-6 bg-white border-top border-bottom border-200 position-relative top-1">
                <div class="table-responsive scrollbar mx-n1 px-1">
                  <table class="table table-sm fs--1 mb-0">
                    <thead>
                      <tr>
                        <th class="sort align-middle pe-5" scope="col" data-sort="customer" style="width:10%;">ID</th>
                        <th class="sort align-middle pe-5" scope="col" data-sort="customer" style="width:10%;">Người dùng</th>
                        <th class="sort align-middle pe-5" scope="col" data-sort="email" style="width:20%;">email</th>
                        <th class="sort align-middle text-center" scope="col" data-sort="total-orders" style="width:10%">Số đơn</th>
                        <th class="sort align-middle text-end ps-3" scope="col" data-sort="total-spent" style="width:10%">Số tiền đã mua</th>
                        <th class="sort align-middle ps-7 text-center" scope="col" data-sort="city" style="width:25%;">Tỉnh thành</th>
                        <th class="sort align-middle text-end" scope="col" data-sort="last-seen" style="width:15%;">Sửa xóa</th>
                      </tr>
                    </thead>
                      <%NumberFormat format = NumberFormat.getInstance(new Locale("vn", "VN"));%>
                      <%
                          List<UserAccount> listAccount = new CustomerUserDAO().listUser();
                            for(UserAccount c : listAccount) {
                                List<Orders> od =OrderService.getInstance().getOrdersByUser(c.getId());
                      %>
                    <tbody class="list" id="table-latest-review-body"><tr class="hover-actions-trigger btn-reveal-trigger position-static">
                        <td class="fs--1 align-middle ps-0 py-3">
                          <!-- <div class="form-check mb-0 fs-0"><input class="form-check-input" type="checkbox"></div> -->
                          <p class="mb-0 text-1100 fw-bold"><%=c.getId()%></p>
                        </td>
                        <td class="customer align-middle white-space-nowrap pe-5"><a class="d-flex align-items-center" href="#!">
                            <div class="avatar avatar-m"><img class="rounded-circle" src="assets/images/user/user.png" alt=""></div>
                            <p class="mb-0 ms-3 text-1100 fw-bold"><%=c.getUsername()%></p>
                          </a></td>
                        <td class="email align-middle white-space-nowrap pe-5"><a class="fw-semi-bold text-1100" href="mailto:annac34@gmail.com"><%=c.getEmail()%></a></td>
                        <td class="total-orders align-middle white-space-nowrap fw-semi-bold text-center"><%=od.size()%></td>
                        <td class="total-spent align-middle white-space-nowrap fw-bold text-end ps-3"><%=format.format(OrderService.getInstance().getPriceOrder(od))%>đ</td>
                        <td class="city align-middle white-space-nowrap text-900 ps-7 text-center"><%=c.getAddress()%></td>
                        <td class="last-order align-middle white-space-nowrap text-700 text-end">
                            <%
                                for (AdminRole role : admin.getRole()) {
                                    if (role.getTableName().equals("userAccount") && role.getPermission() == 2) {
                            %>
                            <a class="btn_2 edit btn btn-primary" href="add-user.jsp?idUser=<%=c.getId()%>">Sửa</a>
                            <%
                                }
                                if (role.getTableName().equals("userAccount") && role.getPermission() == 3) {
                                    if (!UserService.getInstance().isUserInOrder(c.getId())) { %>
                            <a data-toggle="modal" data-target="#confirm-modal" class="btn_2 edit btn btn-primary remove" id="delete<%=c.getId()%>" href="#" style="background-color: crimson; color: white">Xóa</a>
                            <%
                                        }
                                    }
                                }
                            %>


                        </td>
                      </tr>
                        </tr>
                            <%  } %>

                    </tbody>
                  </table>
                </div>
                <div class="row align-items-center justify-content-between py-2 pe-0 fs--1">
                  <div class="col-auto d-flex">
                    <!-- <p class="mb-0 d-none d-sm-block me-3 fw-semi-bold text-900" data-list-info="data-list-info">1 đến 10 <span class="text-600"> trong </span>15</p><a class="fw-semi-bold" href="#!" data-list-view="*">Xem tất cả<svg class="svg-inline--fa fa-angle-right ms-1" data-fa-transform="down-1" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="angle-right" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 256 512" data-fa-i2svg="" style="transform-origin: 0.25em 0.5625em;"><g transform="translate(128 256)"><g transform="translate(0, 32)  scale(1, 1)  rotate(0 0 0)"><path fill="currentColor" d="M64 448c-8.188 0-16.38-3.125-22.62-9.375c-12.5-12.5-12.5-32.75 0-45.25L178.8 256L41.38 118.6c-12.5-12.5-12.5-32.75 0-45.25s32.75-12.5 45.25 0l160 160c12.5 12.5 12.5 32.75 0 45.25l-160 160C80.38 444.9 72.19 448 64 448z" transform="translate(-128 -256)"></path></g></g></svg></a><a class="fw-semi-bold d-none" href="#!" data-list-view="less">View Less<svg class="svg-inline--fa fa-angle-right ms-1" data-fa-transform="down-1" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="angle-right" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 256 512" data-fa-i2svg="" style="transform-origin: 0.25em 0.5625em;"><g transform="translate(128 256)"><g transform="translate(0, 32)  scale(1, 1)  rotate(0 0 0)"><path fill="currentColor" d="M64 448c-8.188 0-16.38-3.125-22.62-9.375c-12.5-12.5-12.5-32.75 0-45.25L178.8 256L41.38 118.6c-12.5-12.5-12.5-32.75 0-45.25s32.75-12.5 45.25 0l160 160c12.5 12.5 12.5 32.75 0 45.25l-160 160C80.38 444.9 72.19 448 64 448z" transform="translate(-128 -256)"></path></g></g></svg></a> -->
                  </div>
                  <div class="col-auto d-flex"><button class="page-link disabled" data-list-pagination="prev" disabled=""><svg class="svg-inline--fa fa-chevron-left" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="chevron-left" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512" data-fa-i2svg=""><path fill="currentColor" d="M224 480c-8.188 0-16.38-3.125-22.62-9.375l-192-192c-12.5-12.5-12.5-32.75 0-45.25l192-192c12.5-12.5 32.75-12.5 45.25 0s12.5 32.75 0 45.25L77.25 256l169.4 169.4c12.5 12.5 12.5 32.75 0 45.25C240.4 476.9 232.2 480 224 480z"></path></svg><!-- <span class="fas fa-chevron-left"></span> Font Awesome fontawesome.com --></button>
                    <ul class="mb-0 pagination"><li class="active"><button class="page" type="button" data-i="1" data-page="10">1</button></li><li><button class="page" type="button" data-i="2" data-page="10">2</button></li></ul><button class="page-link pe-0" data-list-pagination="next"><svg class="svg-inline--fa fa-chevron-right" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="chevron-right" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512" data-fa-i2svg=""><path fill="currentColor" d="M96 480c-8.188 0-16.38-3.125-22.62-9.375c-12.5-12.5-12.5-32.75 0-45.25L242.8 256L73.38 86.63c-12.5-12.5-12.5-32.75 0-45.25s32.75-12.5 45.25 0l192 192c12.5 12.5 12.5 32.75 0 45.25l-192 192C112.4 476.9 104.2 480 96 480z"></path></svg><!-- <span class="fas fa-chevron-right"></span> Font Awesome fontawesome.com --></button>
                  </div>
                </div>
              </div>
            </div>
          </div>
          </div>
        </div>
      </main>
</div>
    <!-- Modal -->
    <div class="modal fade" id="confirm-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
         aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalCenterTitle">Xác nhận xóa</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    Bạn có chắc muốn xóa quyền này?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary no" data-dismiss="modal">Hủy</button>
                    <button type="button" class="btn btn-primary yes" data-dismiss="modal">Xóa</button>
                </div>
            </div>
        </div>
    </div>
    <%
            }
        }
    %>
    <!-- Required Js -->
    <script src="assets/js/vendor-all.min.js"></script>
    <script src="assets/js/plugins/bootstrap.min.js"></script>
    <script src="assets/js/plugins/feather.min.js"></script>
    <script src="assets/js/pcoded.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/highlight.min.js"></script>
    <script src="assets/js/plugins/clipboard.min.js"></script>
    <script src="assets/js/uikit.min.js"></script>

    <script src="bonus/js/popper.min.js"></script>
    <script src="bonus/js/bootstrap.min.js"></script>
    <script src="bonus/js/anchor.min.js"></script>
    <script src="bonus/js/is.min.js"></script>
    <script src="bonus/js/all.min.js"></script>
    <script src="bonus/js/lodash.min.js"></script>
    <script src="bonus/js/polyfill.min.js"></script>
    <script src="bonus/js/list.min.js"></script>
    <script src="bonus/js/feather.min.js"></script>
    <script src="bonus/js/dayjs.min.js"></script>
    <script src="bonus/tinymce/tinymce.min.js"></script>
    <script src="bonus/js/dropzone.min.js"></script>
    <script src="bonus/js/choises.min.js"></script>
    <script src="bonus/js/phoenix.js"></script>
    <script src="bonus/js/phoenix1.js"></script>
    <script src="bonus/js/theme.min.js"></script>
    <script src="bonus/js/docs.js"></script>
    <script src="bonus/js/utils.js"></script>
    <script src="bonus/js/image.js"></script>
    <script>
        $(document).ready(function () {
            deletePermission()
        })

        function deletePermission() {
            $(".remove").each(function () {
                const id = $(this).attr("id").substring(6);
                $(this).on("click", function (e) {
                    e.preventDefault();
                    $("button[type='button'].yes").on("click", function () {
                        $.ajax({
                            url: "/admin/delete-user",
                            type: "post",
                            data: {
                                idUser: id
                            },
                            success: function (data) {
                                window.alert("Xóa thành công")
                                window.location.href= "list-user.jsp"
                            }
                        })
                    })
                })
            })
        }
    </script>

<!-- Apex Chart -->
<script src="assets/js/plugins/apexcharts.min.js"></script>
<!-- custom-chart js -->
<script src="assets/js/pages/dashboard-sale.js"></script>
</body>

</html>
