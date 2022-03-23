<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

<!-- 单个删除的Modal -->
<div class="modal fade" id="ModelDelete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabe">员工  删除</h4>
            </div>
            <div class="modal-body" id="model_delete_div">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="model_delete_btn">删除</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal  修改模态框 -->
<div class="modal fade" id="empUpdateModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >员工  修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="model_form_update">
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">empName:</label>
                        <div class="col-sm-10">
                            <p class="form-control-static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">email:</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="email" id="email_update_input" placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">gender:</label>
                        <div class="col-sm-10" id="check_update">
                            <div class="checkbox">
                                <label class="checkbox-inline">
                                    <input type="radio" name="gender" id="gender1_update_input" value="M" > 男
                                </label>
                                <label class="checkbox-inline">
                                    <input type="radio" name="gender" id="gender2_update_input" value="F" checked="checked"> 女
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4" >
                            <select class="form-control" name="dId"  id="ModelUpdateSelect">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default"  data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">保存</button>
            </div>
        </div>
    </div>
</div>


<!-- Modal  新增模态框 -->
<div class="modal fade" id="empAddModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工  添加</h4>
            </div>
                <div class="modal-body">
                    <form class="form-horizontal" id="model_form">
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">empName:</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="empName" id="empName_add_input" placeholder="empName">
                                <span  class="help-block"></span>
                            </div>
                        </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">email:</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="email" id="email_add_input" placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">gender:</label>
                        <div class="col-sm-10">
                            <div class="checkbox">
                                <label class="checkbox-inline">
                                    <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                                </label>
                                <label class="checkbox-inline">
                                    <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4" >
                            <select class="form-control" name="dId"  id="ModelAndSelect">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<%--    直接搭建页面--%>
<div class="container">
    <%--        标题--%>
    <div class="row">
        <div class="col-md-12"><h1 >SSM-CRUD  何少</h1></div>
    </div>

    <%--    两个按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary btn-sm" id="emp_add_model_btn">
                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
                添加新员工
            </button>
            <button class="btn btn-danger btn-sm" id="emp_delet_model_btn">
                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                批量删除员工</button>
        </div>
    </div>

    <%--    数据表格--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-striped  table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="checkbox_all"/>
                        </th>
                        <th>ID</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th >操作</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>

    <%--    显示分页--%>
    <div class="row">
        <%--            分页文字信息--%>
        <div class="col-md-6" id="page_info">
        </div>
        <%--            分页条信息--%>
        <div class="col-md-6" id="page_nav">
        </div>
    </div>
</div>

<script type="text/javascript">
    var totol_nums;
    //1.页面加载完成后，直接去发送ajax请求，要到分页数据
    $(function () {
        to_pages(1);
        alert("欢迎来到小破站，嘤嘤嘤。。。。。")
    });
    //把ajax的步骤封装到方法中，可以传入pn来改变页码
    function to_pages(pn) {
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn="+pn,
            type:"GET",
            success:function (result) {
                //1.解析并显示 员工数据
                build_emp_table(result);
                //2.解析并显示 分页数据
                bulid_page_info(result);
                //3.解析并显示 分页导航条
                bulid_page_nav(result);
            }
        });
    }
    //1.解析并显示 员工数据
    function build_emp_table(result) {
        //清空数据，不然每次点击都会把页面重新加载
        $("#emps_table tbody").empty();
       var emps = result.extend.pageInfo.list;
       $.each(emps,function (index,item) {
           var checkBoxTd = $("<td></td>").append("<input type='checkbox' class='check_item'/>");
           var empIdTd = $("<td></td>").append(item.empId);
           var empNameTd = $("<td></td>").append(item.empName);
           var genderTd = $("<td></td>").append(item.gender == 'M' ? "男":"女");
           var emailTd = $("<td></td>").append(item.email);
           var deptNameTd = $("<td></td>").append(item.dept.deptName);

            var button_update = $("<button></button>")
                    .addClass("btn btn-primary btn-sm update_btn")
                    .append("<span></span>")
                    .addClass("glyphicon glyphicon-pencil")
                    .append("编辑");
           var button_delete = $("<button></button>")
               .addClass("btn btn-danger btn-sm delete_btn")
               .append("<span></span>")
               .addClass("glyphicon glyphicon-trash")
               .append("删除");
           var button_div = $("<div></div>").append(button_update).append(" ").append(button_delete);

            $(button_update).attr("update_id",item.empId);
            $(button_delete).attr("delete_name",item.empName);
            $(button_delete).attr("delete_id",item.empId);
           // button_update.click(function () {
           //     alert("update");
           // });
           $("<tr></tr>").append(checkBoxTd)
               .append(empIdTd)
               .append(empNameTd)
               .append(genderTd)
               .append(emailTd)
                .append(deptNameTd)
               .append(button_div)
                .appendTo("#emps_table tbody");
       });
    }
    //2.解析并显示 分页数据
    function bulid_page_info(result) {
        //清空数据
        $("#page_info").empty();
        var page_num = result.extend.pageInfo.pageNum;
        var page_pages = result.extend.pageInfo.pages;
        var page_total = result.extend.pageInfo.total;
        $("#page_info").append("<h4></h4>").append("当前第"+page_num+"页，")
                        .append("总共"+page_pages +"页，")
                        .append("总计有"+page_total+"条数据。");
        totol_nums = page_pages;
    }
    //3.解析并显示 分页导航条,   点击能去下一页
    //说明： ajax请求有区别于网页版请求
    //         ajax的a标签的herf 没什么用 用单击事件来绑定方法来进行页面跳转
    //         ,ajax也不是通过url来跳转,url写死,date也就是请求的参数可以改变
    //          如果给a标签添加了attr("href","#")，必须要写 “#” ！！！！，不然报错
    //     网页版的是请求栏的参数变换所以要用href
    var pages_now ;
    function bulid_page_nav(result) {
        //清空数据
        $("#page_nav").empty();
        pages_now = result.extend.pageInfo.pageNum;
        //获取数据
        var page_info_msg = result.extend.pageInfo;
        var ul = $("<ul></ul>").addClass("pagination");
        //判断页码如果为第一页或者最后一页，则隐藏或者加上 Class disabled
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var pretPageLi = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href", "#"));
        if (page_info_msg.hasPreviousPage == false) {
                firstPageLi.addClass("disabled");
                pretPageLi.addClass("disabled");
        }else{
            //为首页绑定单击事件，来进行页面跳转
            firstPageLi.click(function () {
                to_pages(1);
            });
            pretPageLi.click(function (){
                to_pages(page_info_msg.pageNum-1);
            });
        }

        var sufPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页"));
        if (page_info_msg.hasNextPage == false) {
            sufPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else{
            //给末页绑定单击事件
            sufPageLi.click(function () {
                to_pages(page_info_msg.pageNum+1);
            });
            lastPageLi.click(function (){
                to_pages(page_info_msg.pages);
            });
        }



        ul.append(firstPageLi).append(pretPageLi);
        $.each(result.extend.pageInfo.navigatepageNums,function (index,num) {
            var numLi =  $("<li></li>").append($("<a></a>").append(num));
            //判断是否当前页和遍历出来的num是否相等，相等则早li加class  active 高亮
            if (num == result.extend.pageInfo.pageNum){
                numLi.addClass("active");
            }
            //给点击页码绑定单击事件
            numLi.click(function () {
                to_pages(num);
            });
            ul.append(numLi);
        });
        ul.append(sufPageLi).append(lastPageLi);
        var navLi = $("<nav></nav>").append(ul);
        navLi.appendTo("#page_nav");

    }


    
    //点击模态框，清空样式和数据
    function clean_btn_class_text(ele){
        $(ele)[0].reset();
        $(ele).find("*").removeClass("has-success has-error");
        $(ele).find("span").text(" ");
    };

    //添加的第一步 点击新增按钮弹出模态框。
    $("#emp_add_model_btn").click(function () {
        //对模态框清空
        clean_btn_class_text("#empAddModel form");
        //第一部 发送ajax请求，查询部门信息，显示在下拉列表中
        getDepts("#ModelAndSelect");
        // 第二部 弹出模态框
        $("#empAddModel").modal({
            backdrop:"static"
        });
    });
    //查询出所有部门信息显示在下拉列表中
    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
            url:"${APP_PATH}/getDept",
            type: "get",
            // async:true,
            success:function (result) {
                $.each(result.extend.dept,function () {
                    var selectOption = $("<option></option>").append(this.deptName).attr("value",this.deptId)
                    $(ele).append(selectOption);
                });
            }
        });
    };

    //添加的第二步  1 点击保存将信息发送给服务器
                // 2.1要对传入的数据进行校验
                // 2.2 发送ajax请求保存  表单的数据传统的ajax 的data不行，用序列化serialize();
                // 3  data这个单词注意！！！！
                // 4 对输入框的内容前端校验
                // 5 对输入框的内容后端校验
    
    
    //4  校验的方法
    // 对校验的方法的封装
    function validate_add_info(){
        //先得到empName的val 然后和正则表达式比较
        var emp_name_info =  $("#empName_add_input").val();
        var emp_email_info =  $("#email_add_input").val();
        var emp_name_reg = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2-5}$)/;
        var emp_email_reg = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!emp_name_reg.test(emp_name_info)){
            panduan_validate_way("#empName_add_input","fail","前端:用户名格式错误，请输入大小写字母数字下划线_");
            return false;
        }else{
            panduan_validate_way("#empName_add_input","success","");
            return true;
        };
        if(!emp_email_reg.test(emp_email_info)){
            panduan_validate_way("#email_add_input","fail","邮箱格式错误！！！")
            return false;
        }else{
            panduan_validate_way("#email_add_input","success","")
            return true;
        };
    };
    function panduan_validate_way(ele,status,msg) {
        //使用前的清空
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
         if (status == "success") {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if (status == "fail") {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }
    
 
    //5 对输入框的内容后端校验
    //获取输入框empName的内容
    //设置全局变量 保存传输过来用户名是否合法的  在保存按钮点击前确定
    var user_boolean;
    var email_boolean;
    $("#empName_add_input").change(function () {
        //通过this来获取当前对象 + 上value  来获取
        var emo_Name_info = this.value;
        $.ajax({
            url:"${APP_PATH}/checkuser",
            data:"empName=" + emo_Name_info,
            type:"get",
            success:function (result) {
                if(result.code == 100){
                    panduan_validate_way("#empName_add_input","success","用户名可用   ^w^");
                    user_boolean =true;
                }else {
                    panduan_validate_way("#empName_add_input","fail",result.extend.err_fail);
                    user_boolean = false;
                }
            }
        });

    });
    $("#email_add_input").change(function () {
        //通过this来获取当前对象 + 上value  来获取
        var emo_email_info = this.value;
        $.ajax({
            url:"${APP_PATH}/checkemail",
            data:"email=" + emo_email_info,
            type:"get",
            success:function (result) {

                if(result.code == 100){
                    panduan_validate_way("#email_add_input","success","邮箱可用");
                    email_boolean = true;
                }else {
                    panduan_validate_way("#email_add_input","fail",result.extend.err_fail_email);
                    email_boolean = false;
                }
            }
        });

    });

    $("#emp_save_btn").click(function () {
            // 调用jquery前端校验
            if(!validate_add_info()){
                return false;
            }
        // if( user_legig_boolean == 100){
            $.ajax({
                url:"${APP_PATH}/emp",
                type:"POST",
                data:$("#model_form").serialize(),
                success:function (result) {

                    if(result.code == 100){
                        if(user_boolean && email_boolean){
                            // 4 点击保存后，需要跳转到最后一页和关闭模态框
                            alert("保存成功！！！ ohhhhh   ^ w ^~~~   ");
                            to_pages(totol_nums);
                            $('#empAddModel').modal('toggle');
                        }
                    }else {
                        if (undefined != result.extend.errorFields.email) {
                            panduan_validate_way("#empName_add_input", "fail", result.extend.errorFields.empName);
                        }
                        if (undefined != result.extend.errorFields.empName) {
                            panduan_validate_way("#email_add_input", "fail", result.extend.errorFields.email);
                        }
                    }
                }
            });
        // }else{
        //     alert("输入框内容不合法，请重新输入。。。。。。")
        // }
    });



    // ====================================更新=========================================
    //这些数据是页面加载之后发送ajax请求获取的数据，按钮也是，而绑定时间是在按钮不存在，所以绑不上
    // $(".update_btn").click(function () {
    //     alert("点击");
    // });
    //方法：1.可以在创建按钮的时候绑定，这个是在方法里不太方便嵌套，
    //      2.绑定点击 on()  doucument表示整个文档,"click”表示事件， update——btn 是表示文档子中为元素  还有函数fn
    $(document).on("click",".update_btn",function () {
        //获取部门的信息
        getDepts("#ModelUpdateSelect");
        //通过id获取员工信息
        getUser($(this).attr("update_id"));

        //方便下面操作得到 需要更改的id号传递给模态框的更新按钮
        $("#emp_update_btn").attr("update_id",$(this).attr("update_id"));

       //莫泰框弹出
        $("#empUpdateModel").modal({
            backdrop: "static"
        });
    });
    //通过id获取员工信息
    function getUser(id) {
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"get",
            success:function (result) {
                $("#model_form_update p").text(result.extend.emp.empName);
                $("#email_update_input").val(result.extend.emp.email);
                $("#model_form_update input[name=gender]").val([result.extend.emp.gender]);
                $("#ModelUpdateSelect").val(result.extend.emp.dId);
            }
        });
    }
    //点击更新按钮
    $("#emp_update_btn").click(function () {
        //前端校验
        if(!validate_add_info_update()){
            return false;
        }
        $.ajax({
            url:"${APP_PATH}/emp/"+ $(this).attr("update_id"),
            type:"POST",
            data:$("#model_form_update").serialize()+"&_method=put",
            success:function (result) {
                alert("修改成功！！！ ohhhhh   ^ w ^~~~   ");
                to_pages(pages_now);
                $('#empUpdateModel').modal('toggle');
            }
        });
    });

    function validate_add_info_update(){

        var emp_email_info =  $("#email_update_input").val();

        var emp_email_reg = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!emp_email_reg.test(emp_email_info)){
            panduan_validate_way("#email_update_input","fail","邮箱格式错误！！！")
            return false;
        }else{
            panduan_validate_way("#email_update_input","success","")
            return true;
        };
    };

//============================== 单个删除===============================================
    $(document).on("click",".delete_btn",function () {
        //获取name的办法  方法一: $(this).parents("tr").find("td:eq(1)").text()
        //              方法二:   1先在删除按钮的设置属性   $(button_delete).attr("delete_name",item.empName);
        //                     2 在$(this).attr("delete_name");

        //确认框 if(confirm("确定要删除嘛")){
        // 确认则发送ajax
        // }


       $("#model_delete_div").text(" ");
        //获取删除按钮的属性id和name
        var delete_name_info = $(this).attr("delete_name");
        var delete_id_info = $(this).attr("delete_id");
        //弹出模态框
        $("#ModelDelete").modal({
            backdrop: "static"
        });
        //模态框的信息的显示
        $("#model_delete_div").append("<h4></h4>").append("Id: "+delete_id_info);
        $("#model_delete_div").append("<h4></h4>").append("Name: "+delete_name_info);
        $("#model_delete_div").append("<h4></h4>").append("请确定是否删除:  ");
        //给模态框内的确定删除按钮添加属性id
        $("#model_delete_btn").attr("delete_id",delete_id_info);
    });

    //点击删除按钮确定删除
    $("#model_delete_btn").click(function () {
        $.ajax({
            url:"${APP_PATH}/emp/"+$(this).attr("delete_id"),
            data:"_method=delete",
            type:"POST",
            success:function (result) {
                alert("操作成功。 ^ w ^")
                //删除成功后跳转到当前页面
                $("#ModelDelete").modal('toggle');
                to_pages(pages_now);
            }
        });

    });

    //=====================================批量删除===========================================
    //完成全选/全不选
    $("#checkbox_all").click(function () {
        //attr获取checked是undefined
        // 原生dom的元素值用prop   attr获取自定义属性的值
        //   prop修改和读取dom原生属性的值
        //$(this).prop("checked") 是获取全选的checked的值
        $(".check_item").prop("checked",$(this).prop("checked"));
    });
    //check_item
    $(document).on("click",".check_item",function () {
        //判断当前对象是否满选
        var bool = $(".check_item:checked").length == $(".check_item").length;
        $("#checkbox_all").prop("checked",bool);
    })
    //给批量删除绑定单机事件
    $("#emp_delet_model_btn").click(function () {

        //取出需要删除的员工姓名
        var delete_batch_name = "";
        var delete_batch_id = "";
        var count = 0;
        $.each($(".check_item:checked"),function (index,item) {
            // alert($(item).parents("tr").find("td:eq(2)").text())
            delete_batch_name += $(item).parents("tr").find("td:eq(2)").text() +",";
            delete_batch_id += $(item).parents("tr").find("td:eq(1)").text() +"-";
            count++;
        });
        //去除员工名字符串的最后逗号
        delete_batch_name = delete_batch_name.substring(0,delete_batch_name.length-1);
        if(delete_batch_id != "" ){//当没有一个复选框被选中，则不跳出表单
            if(confirm("选中有"+count+"条数据，"+"确认删除【"+ delete_batch_name +"】员工吗？")){
                //确定删除，发送ajax请求
                $.ajax({
                    url:"${APP_PATH}/emp/"+delete_batch_id,
                    data:"_method=delete",
                    type:"POST",
                    success:function (result) {
                        alert("批量删除【"+delete_batch_name+"】成功！！！！")
                        to_pages(pages_now);
                    }
                });
            }
        }else{
            alert("请先选择每条数据的复选框，在点击批量删除按钮！！")
        }

    });


</script>

</body>
</html>
