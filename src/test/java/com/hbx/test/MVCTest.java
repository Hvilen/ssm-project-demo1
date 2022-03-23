package com.hbx.test;


import com.github.pagehelper.PageInfo;
import com.hbx.mybatis.mapper.EmployeeMapper;
import com.hbx.mybatis.pojo.Employee;
import com.hbx.mybatis.service.EmployeeService;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:springmvc.xml"})
public class MVCTest{

//    传入springmvc ioc容器
    @Autowired
    WebApplicationContext context;
//    虚拟mvc请求，获取请求结果
    MockMvc mockMvc;

    @Before
    public void test1(){
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();

    }
    @Test
    public  void tstPage() throws Exception {
        //模拟请求拿到返回值
        MvcResult result =  mockMvc.perform(MockMvcRequestBuilders.get("/emps")
                .param("pn","1")).andReturn();
        //请求成功后,请求域中会有pageInfo,我们可以取出pageinfo校验
        MockHttpServletRequest request = result.getRequest();
        PageInfo page = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码:" +page.getPageNum());
        System.out.println("总页码:" +page.getPages());
        System.out.println("总记录数:" +page.getTotal());

        System.out.println("页面需要的连续显示页码");
        int[] navigatepageNums = page.getNavigatepageNums();
        for (int i :navigatepageNums) {
            System.out.println("  "+i);
        }
        System.out.println("==================================");
        List<Employee> list = page.getList();
        for (Employee  employee :list) {

            System.out.println("name    "+ employee.getEmpName() );
            System.out.println("email     "+ employee.getEmail());
            System.out.println("dept"      +employee.getDept().getDeptName());
        }


    }
}
