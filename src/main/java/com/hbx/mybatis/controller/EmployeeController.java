package com.hbx.mybatis.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hbx.mybatis.pojo.Employee;
import com.hbx.mybatis.pojo.Msg;
import com.hbx.mybatis.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Controller
public class EmployeeController {
    @Autowired
    EmployeeService employeeService;





    //删除emp
    //批量单个二合一
    @DeleteMapping("/emp/{ids}")
    @ResponseBody
    public Msg deleteById(@PathVariable("ids")String ids){

        if(ids.contains("-")){
            System.out.println("批量删除"+ids);
            ArrayList<Integer> list = new ArrayList<Integer>();
            String[] split = ids.split("-");
            for (String s :split) {
                int i = Integer.parseInt(s);
                list.add(i);
            }
            employeeService.deleteByBatch(list);
        }else{
            System.out.println("单个删除"+ids);
            int i = Integer.parseInt(ids);
            employeeService.deleteById(i);
        }
        return Msg.success();
    }






    //修改保存员工信息
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    public Msg UpdateEmp(@PathVariable("empId")Integer id,Employee employee){
        System.out.println("修改保存员工信息"+employee);
        employeeService.updateEmp(employee);

        return Msg.success();
    }

    //通过id查询员工信息
    @ResponseBody
    @GetMapping("/emp/{id}")
    public Msg getUser(@PathVariable("id")Integer id){

        Employee employee = employeeService.getEep(id);

        return Msg.success().add("emp",employee);
    }










    //通过empName 查找用户是否存在 /checkuser？empName={empName}  get
    @ResponseBody
    @RequestMapping(value = "/checkuser",method = RequestMethod.GET)
    public Msg selectByName(@RequestParam("empName")String empName){
        String namereg ="(^[a-zA-Z0-9_-]{6,16}$)";
        if (!empName.matches(namereg)){
            return Msg.fail().add("err_fail","后端:用户名格式错误，请输入大小写字母数字下划线_(6-16)");
        }
          Boolean bool =  employeeService.selectByName(empName);
        if (bool){
            return Msg.success();
        }else{
            return Msg.fail().add("err_fail","用户名已存在，请重新输入。。。。");
        }

    }

    @ResponseBody
    @RequestMapping(value = "/checkemail",method = RequestMethod.GET)
    public Msg selectByEmail(
                            @RequestParam("email")String email){
        String emailreg ="^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$";
        if (!email.matches(emailreg)){
            return Msg.fail().add("err_fail_email","邮箱格式有误");
        }
        Boolean bool =  employeeService.selectByEamil(email);
        if (bool){
            return Msg.success();
        }else{
            return Msg.fail().add("err_fail_email","邮箱出了点问题，你的好像有一点点重复了");
        }

    }


    //校验使用JSP303校验

    //保存用户信息的 /emp    post
    @ResponseBody
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    public Msg saveEmp(@Valid  Employee employee, BindingResult result){
        HashMap<String, Object> map = new HashMap<String, Object>();
        if (result.hasErrors()){
            //校验失败，在模态框显示错误信息
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError fieldError :fieldErrors) {
                 map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }

            return Msg.fail().add("errorFields",map);
        }else{
            employeeService.saveEmp(employee);
            return Msg.success();
        }



    }


    //ajax查询conroller
    @ResponseBody
    @GetMapping("/emps")
    public Msg listAjax(@RequestParam(value = "pn",defaultValue = "1")Integer pn){
//        引入分页插件PageHelper
//        在查询前只需要调用,传入 页码,以及 每页数据大小
        PageHelper.startPage(pn,5);
        List<Employee> list = employeeService.selectList();
//        startPage后紧跟这个查询就是一个分页查询  传入的数字是连续显示的页码是5个
        PageInfo pageInfo = new PageInfo(list,5);
        return Msg.success().add("pageInfo",pageInfo);
    }

    /** 网页版查询
     * 查询员工数据（分页）
     */
    public String list(@RequestParam(value = "pn",defaultValue = "1")Integer pn,
                       Model model){

//        引入分页插件PageHelper
//        在查询前只需要调用,传入 页码,以及 每页数据大小
        PageHelper.startPage(pn,5);
        List<Employee> list = employeeService.selectList();
//        startPage后紧跟这个查询就是一个分页查询  传入的数字是连续显示的页码是5个
        PageInfo pageInfo = new PageInfo(list,5);
        model.addAttribute("pageInfo",pageInfo);
        return "list";
    }
}
