package com.hbx.mybatis.controller;

import com.hbx.mybatis.pojo.Dept;
import com.hbx.mybatis.pojo.Msg;
import com.hbx.mybatis.service.DeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DeptController {
    @Autowired
    DeptService deptService;
    @ResponseBody
    @GetMapping("/getDept")
    public Msg getDept(){
        List<Dept> list =  deptService.getDeptInfoList();

        return Msg.success().add("dept",list);
    }
}
