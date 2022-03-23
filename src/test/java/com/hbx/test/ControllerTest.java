package com.hbx.test;

import com.hbx.mybatis.pojo.Employee;
import com.hbx.mybatis.service.EmployeeService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class ControllerTest {

    @Autowired
    EmployeeService employeeService;

    @Test
    public void test(){
        employeeService.saveEmp(new Employee(null, "1111", "M", "1231@qq.com", 5));
        System.out.println("受影响的行数：");
    }
}
