<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
<%--    web路径--%>
<%--    不以/开始的相对路径,找资源,以当前的资源路径为基准,经常容易出问题--%>
<%--    以/开始的相对路径,找资源,以服务器的路径为标准 （http://localhost：8080/）需要加上项目名--%>
<%--                                        （http://localhost：8080/crud--%>

    <title>员工  列表</title>
        <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.11.1-min.js"></script>

        <link href="${APP_PATH}/static/css/bootstrap.min.css" rel="stylesheet">
        <script src="${APP_PATH}/static/js/bootstrap.min.js"></script>
</head>
<body>
<%--    直接搭建页面--%>
    <div class="container">
<%--        标题--%>
        <div class="row">
            <div class="col-md-12"><h1 >SSM-CRUD  何少版本</h1></div>
        </div>
<%--    两个按钮--%>
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button class="btn btn-primary btn-sm">
                    <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
                    添加
                </button>
                <button class="btn btn-danger btn-sm">
                    <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                    删除</button>
            </div>
        </div>
<%--    数据表格--%>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-striped  table-hover">
                    <tr>
                        <th>ID</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th >操作</th>
                    </tr>
               <c:forEach items="${pageInfo.list}" var="emp">
                    <tr>
                        <th>${emp.empId}</th>
                        <th>${emp.empName}</th>
                        <th>${emp.gender =="M"?"男":"女"}</th>
                        <th>${emp.email}</th>
                        <th>${emp.dept.deptName}</th>
                        <th>
                            <button class="btn btn-primary btn-sm">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                编辑
                            </button>
                            <button class="btn btn-danger btn-sm">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                删除
                            </button>
                        </th>
                    </tr>
               </c:forEach>
                </table>
            </div>
        </div>

<%--    显示分页--%>
        <div class="row">
<%--            分页文字信息--%>
            <div class="col-md-6">
                <h4>当前第${pageInfo.pageNum}页,总共${pageInfo.pages}页,总共${pageInfo.total}条记录</h4>
            </div>

<%--            分页条信息--%>
            <div class="col-md-6">
                <nav aria-label="Page navigation">
                    <ul class="pagination">

                        <c:if test="${pageInfo.hasPreviousPage}">
                            <li><a  href="${APP_PATH}/emps?pn=1" >首页</a></li>
                            <li>
                                <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>

                        <c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
                            <c:if test="${page_Num == pageInfo.pageNum}">
                                <li class="active">
                                    <a href="#">${page_Num}</a>
                                </li>
                            </c:if>
                            <c:if test="${page_Num != pageInfo.pageNum}">
                                <li >
                                    <a href="${APP_PATH}/emps?pn=${page_Num}">${page_Num}</a>
                                </li>
                            </c:if>
                        </c:forEach>

                        <c:if test="${pageInfo.hasNextPage}">
                            <li>
                                <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                            <li><a  href="${APP_PATH}/emps?pn=${pageInfo.pages}" >末页</a></li>
                        </c:if>



                    </ul>
                </nav>
            </div>

<%--                分页搜索栏--%>
            <div class="col-md-6" >
        <form class="form-inline" method="get" action="${APP_PATH}/emps">
            <div class="form-group">
                <label for="exampleInputName2">页码:</label>
                <input type="text" class="form-control" id="exampleInputName2" placeholder="1" name="pn">
            </div>

            <button type="submit" class="btn btn-default">确定跳转</button>
        </form>
    </div>
        </div>
    </div>
</body>
</html>
