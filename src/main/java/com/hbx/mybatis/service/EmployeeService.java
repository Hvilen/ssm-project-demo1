package com.hbx.mybatis.service;

import com.hbx.mybatis.mapper.EmployeeMapper;
import com.hbx.mybatis.pojo.Employee;
import com.hbx.mybatis.pojo.EmployeeExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    public List<Employee> selectList(){
        EmployeeExample employeeExample = new EmployeeExample();
        employeeExample.setOrderByClause("emp_id");
        return employeeMapper.selectByExampleWithDept(employeeExample);

    }


    public void saveEmp(Employee employee) {
         employeeMapper.insertSelective(employee);

    }

    public Boolean selectByName(String name) {
        EmployeeExample employeeExample = new EmployeeExample();

        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpNameEqualTo(name);


        int i = employeeMapper.countByExample(employeeExample);

        return  i ==0;
    }


    public Boolean selectByEamil(String name) {
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmailEqualTo(name);

        int i = employeeMapper.countByExample(employeeExample);

        return  i ==0;
    }

    public Employee getEep(Integer id) {

        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }

    public void updateEmp(Employee employee) {

        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    public void deleteById(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    public void deleteByBatch(List<Integer>list){
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpIdIn(list);
        employeeMapper.deleteByExample(employeeExample);
    }
}
