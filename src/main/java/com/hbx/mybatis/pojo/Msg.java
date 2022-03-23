package com.hbx.mybatis.pojo;

import java.util.HashMap;
import java.util.Map;

/**
 * 通用返回json数据
 */
public class Msg {
    //状态码 100-成功  200- 失败
     private Integer code;
     private String  msg;
     //用户返回浏览器的数据
    private Map<String,Object> extend = new HashMap<String, Object>();

    public static Msg success(){
        Msg msg = new Msg();
        msg.setCode(100);
        msg.setMsg("成功啦");
        return  msg;
    }
    public static Msg fail(){
        Msg msg = new Msg();
        msg.setCode(200);
        msg.setMsg("失败啦");
        return  msg;
    }
    public Msg add(String key,Object value){
        //this就是msg对象
        this.getExtend().put(key, value);
        return this;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
}
