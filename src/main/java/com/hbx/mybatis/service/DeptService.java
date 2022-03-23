package com.hbx.mybatis.service;

import com.hbx.mybatis.mapper.DeptMapper;
import com.hbx.mybatis.pojo.Dept;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DeptService {

    @Autowired
    DeptMapper deptMapper;

    public List<Dept> getDeptInfoList() {
        return deptMapper.selectByExample(null);
    }
}
