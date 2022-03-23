package com.hbx.test;

import com.hbx.mybatis.mapper.DeptMapper;

import com.hbx.mybatis.mapper.EmployeeMapper;

import com.hbx.mybatis.pojo.Employee;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;
//推荐使用spring项目的的单元测试，可以自动注入我们需要的组件
//1.导入springTest模块

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
    @Autowired
    DeptMapper deptMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;
    @Test
    public void testCRUD(){
//       1 获取deptMAppert内存地址
        System.out.println(deptMapper);

//       2 插入数据测试
//        deptMapper.insertSelective(new Dept(null,"车间"));
//    employeeMapper.insertSelective(new Employee(null,"jerry","M","121@qq.com",1));

//      3。1  批量插入
//        for(){
//            employeeMapper.insertSelective(new Employee(null,"jerry","M","121@qq.com",1));
//        }
//      3.2  批量插入

        long start = System.currentTimeMillis();

        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 1000; i++) {
            String s = UUID.randomUUID().toString().substring(0,5)+i;
            mapper.insertSelective(new Employee(null,s,"M",s+"@qq.com",1));
        }
        long end = System.currentTimeMillis();

        System.out.println("总耗时： "+(end-start)+"s");
        System.out.println("批量成功");
    }
}