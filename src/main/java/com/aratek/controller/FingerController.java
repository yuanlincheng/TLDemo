package com.aratek.controller;

import com.aratek.model.TrustLinkVO;
import com.aratek.util.HttpClientUtil;
import com.aratek.util.PropertyUtil;
import com.exception.InternalSystemException;
import com.model.mysql.Manager;
import com.services.mysql.ManagerService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.support.RequestContext;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
public class FingerController{

	//日志对象
	private static Log log = LogFactory.getLog(FingerController.class);

    @Autowired
    private ManagerService managerService;
    private String msg;

	/**
	 *跳转进入主界面
	 *return ：
	 */
    @RequestMapping("/")
    public String toMain(HttpServletRequest request){
    	PropertyUtil.configUrl = request.getSession().getServletContext().getRealPath("/WEB-INF/classes/config.properties");
//        return "/main";
        return "/login";
    }

    /**
	 *左部页面的加载
	 *return ：
	 */
    @RequestMapping("/load")
    public String toLoad(String name){
        return "/"+name;
    }

    /**
     *  处理用户登入请求
     * @param manager 用户对象
     * @return String 返回到前台页面
     */
    @RequestMapping(value = "/login")
    public String login(Model model, Manager manager){
        if (Optional.of(manager).isPresent()) {
            if (managerService.checkLogin(manager.getAccount(), manager.getPassword())) {
                return "/main";
            } else {
                msg = "用户名或密码错误";
            }
        }
        model.addAttribute("msg", msg);
        return "/login";
    }

    /**
	 *控件初始化
	 *return ：
	 */
    @RequestMapping("/init")
    @ResponseBody
    public Map<String, Object> init(){
        Map<String, Object> map = new HashMap<String, Object>(2);
        try{
        	map.put("msg", HttpClientUtil.getAgentInfo());
        	map.put("anyStatu", 1);
		}catch (Exception e) {
			e.printStackTrace();
		}
        return map;
    }

    /**
	 *处理用户注册指纹请求
	 *return ：
	 */
    @RequestMapping("/enroll")
    @ResponseBody
    public Map<String, Object> enroll(HttpServletRequest request,String fingerData){
    	//从后台代码获取国际化信息
        RequestContext rc = new RequestContext(request);

        Map<String, Object> map = new HashMap<String, Object>(2);
        String returnCode = rc.getMessage("no");
        int anyStatu = 0;
        String msg = "";
        try{
        	if(null != fingerData){
				returnCode = HttpClientUtil.enrollFinger(fingerData);

				if(returnCode.equals("3")){
					throw new IllegalAccessException(rc.getMessage("finger_exist"));
				}else if(!returnCode.equals("0")) {
					throw new IllegalAccessException(rc.getMessage("enroll_fail")+","+rc.getMessage("error_code")+":"+returnCode);
				}

				//构造前台数据模型，返回前台显示
				anyStatu = 1;
				msg = rc.getMessage("enroll_success");
			}else{
				throw new IllegalAccessException(rc.getMessage("network_error"));
			}
		}catch (IllegalAccessException e) {
			msg = e.getMessage();
			log.error(e.getMessage()+ ","+rc.getMessage("error_code")+":"+returnCode);
		}catch (Exception e) {
			e.printStackTrace();
			msg = rc.getMessage("service_error");
		}
        map.put("msg", msg);
   	 	map.put("anyStatu", anyStatu);
        return map;
    }

    /**
	 *处理用户认证请求
	 *return ：
	 */
    @RequestMapping("/verify")
    @ResponseBody
    public Map<String, Object> verify(HttpServletRequest request,String name,String fingerData){
    	RequestContext rc = new RequestContext(request);
    	Map<String, Object> map = new HashMap<String, Object>(2);
        String returnCode = rc.getMessage("no");
        int anyStatu = 0;
        String msg = "";
        try{
        	if(name != null && fingerData != null){
				returnCode = HttpClientUtil.VerifyFinger(fingerData);
				if(returnCode.equals("0")){
					msg = rc.getMessage("verify_success");
					anyStatu = 1;
				}else{
					throw new IllegalAccessException(rc.getMessage("verify_fail"));
				}
			}else{
				throw new IllegalAccessException(rc.getMessage("network_error"));
			}
		}catch (IllegalAccessException e) {
			msg = e.getMessage();
			log.error(e.getMessage()+ ","+rc.getMessage("error_code")+":"+returnCode);
		}catch (Exception e) {
			e.printStackTrace();
			msg = rc.getMessage("service_error");
		}
        map.put("msg", msg);
   	 	map.put("anyStatu", anyStatu);
        return map;
    }

    /**
	 *处理用户认证请求(1:n)
	 *return ：
	 */
    @RequestMapping("/identify")
    @ResponseBody
    public Map<String, Object> identify(HttpServletRequest request,String fingerData){
    	RequestContext rc = new RequestContext(request);
        Map<String, Object> map = new HashMap<String, Object>(2);
        String returnCode = rc.getMessage("no");
        int anyStatu = 0;
        String msg = "";
        try{
        	if(fingerData != null){
				List<String[]> userList = HttpClientUtil.VerifyFingerIdentify(fingerData);
				if(null != userList){
					StringBuffer sb = new StringBuffer();
					for(String[] arrayTemp : userList){
						sb.append("<tr><td>"+arrayTemp[0]+"</td><td>"+arrayTemp[1]+"</td><td>"+arrayTemp[2]+"</td></tr>");
					}
					msg = sb.toString();
					anyStatu = 1;
				}else{
					throw new IllegalAccessException("<tr><td colspan='3'>"+rc.getMessage("no_user")+"</td></tr>");
				}
			}else{
				throw new IllegalAccessException("<tr><td colspan='3'>"+rc.getMessage("network_error")+"</td></tr>");
			}
		}catch (IllegalAccessException e) {
			msg = e.getMessage();
			log.error(e.getMessage()+ ","+rc.getMessage("error_code")+":"+returnCode);
		}catch (Exception e) {
			e.printStackTrace();
			msg = rc.getMessage("service_error");
		}
        map.put("msg", msg);
   	 	map.put("anyStatu", anyStatu);
        return map;
    }

    /**
	 *处理用户查询请求
	 *return ：
	 */
    @RequestMapping("/query")
    @ResponseBody
    public Map<String, Object> query(HttpServletRequest request,String name){
    	RequestContext rc = new RequestContext(request);
        Map<String, Object> map = new HashMap<String, Object>(2);
        String anyString = "";
        String msg = "";
        try{
        	if(name != null ){
				anyString = HttpClientUtil.getFingers(name);
				msg = rc.getMessage("finger_index")+":"+anyString;
			}else{
				throw new IllegalAccessException(rc.getMessage("network_error"));
			}
		}catch (IllegalAccessException e) {
			msg = e.getMessage();
		}catch (Exception e) {
			e.printStackTrace();
			msg = e.getMessage();
		}
        map.put("msg", msg);
   	 	map.put("anyString", anyString);
        return map;
    }

    /**
	 *处理用户删除请求
	 *return ：
	 */
    @RequestMapping("/delete")
    @ResponseBody
    public Map<String, Object> delete(HttpServletRequest request,String name){
    	RequestContext rc = new RequestContext(request);
        Map<String, Object> map = new HashMap<String, Object>(1);
        String msg = "";
        try{
        	if(name != null ){
				//可为某个指位
				String extInfo = "";

				boolean bl = HttpClientUtil.delUser(name,extInfo);
				if(bl){
					msg = rc.getMessage("finger_delete_success");
				}else{
					throw new IllegalAccessException(rc.getMessage("finger_delete_fail"));
				}
			}else{
				throw new IllegalAccessException(rc.getMessage("network_error"));
			}
		}catch (IllegalAccessException e) {
			msg = e.getMessage();
		}catch (Exception e) {
			if("2".equals(e.getMessage())){
				msg = rc.getMessage("no_finger");
			}else{
				msg = rc.getMessage("finger_delete_fail")+","+rc.getMessage("error_code")+":"+e.getMessage();
			}
		}
        map.put("msg", msg);
        return map;
    }

    /**
	 *处理用户获取注册指位请求
	 *return ：
	 */
    @RequestMapping("/getFpIndex")
    @ResponseBody
    public Map<String, Object> toGetFpIndex(String name){
        Map<String, Object> map = new HashMap<String, Object>(2);
        try{
        	map.put("anyString", HttpClientUtil.getFingers(name));
        	map.put("anyStatu", 1);
		}catch (Exception e) {
			e.printStackTrace();
		}
        return map;
    }


    /**
	 *左部页面的加载
	 *return ：
	 */
    @RequestMapping("/getSetting")
    public String toGetSetting(Model model){
    	model.addAttribute("ip", PropertyUtil.getTrustLinkManagementValue("DEFAULT_IP"));
    	model.addAttribute("port", PropertyUtil.getTrustLinkManagementValue("DEFAULT_PORT"));
    	model.addAttribute("name",  PropertyUtil.getTrustLinkManagementValue("ADMINUSER"));
    	model.addAttribute("pwd",  PropertyUtil.getTrustLinkManagementValue("ADMINUSERPWD"));
        return "/setting";
    }

    /**
	 *修改TL参数
	 *return ：
	 */
    @RequestMapping("/setting")
    @ResponseBody
    public Map<String, Object> setting(HttpServletRequest request,String ip,String port,String name,String pwd){
    	RequestContext rc = new RequestContext(request);
        Map<String, Object> map = new HashMap<String, Object>(2);
        String msg = "";
        int anyStatu = 0;
        TrustLinkVO tlTemp = new TrustLinkVO();
        try{
        	if(ip != null && port != null && name != null && pwd != null){
        		BeanUtils.copyProperties(HttpClientUtil.tl, tlTemp);
        		HttpClientUtil.tl.setIp(ip);
        		HttpClientUtil.tl.setPort(port);
        		HttpClientUtil.tl.setName(name);
        		HttpClientUtil.tl.setPwd(pwd);

        		HttpClientUtil.getAgentInfo();

        		Map<String,String> mapTemp = new HashMap<String,String>();
        		mapTemp.put("ip",ip);
        		mapTemp.put("port",port);
        		mapTemp.put("name",name);
        		mapTemp.put("pwd",pwd);
        		PropertyUtil.setTrustLink(mapTemp);
				msg = rc.getMessage("file_modify_success");
				anyStatu = 1;
			}else{
				throw new IllegalAccessException(rc.getMessage("network_error"));
			}
		}catch (InternalSystemException e) {
			BeanUtils.copyProperties(tlTemp,HttpClientUtil.tl);
			msg = rc.getMessage("file_modify_fail");
		}catch (IllegalAccessException e) {
			msg = e.getMessage();
		}catch (Exception e) {
			e.printStackTrace();
			msg = e.getMessage();
		}
        map.put("msg", msg);
        map.put("anyStatu", anyStatu);
        return map;
    }
}