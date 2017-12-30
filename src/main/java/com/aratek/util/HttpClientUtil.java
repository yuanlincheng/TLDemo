/**
 * @author: tree
 * @version: 1.0
 * date: 2017/9/4 11:54
 * @description:
 * own: Aratek
 */
package com.aratek.util;

import com.aratek.model.TrustLinkVO;
import com.exception.InternalSystemException;
import com.overload.CustomizedPropertyPlaceholderConfigurer;
import com.util.CommonStringUtil;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.UnsupportedEncodingException;
import java.util.*;

public class HttpClientUtil {

    private static final Logger logger = LoggerFactory.getLogger(HttpClientUtil.class);

    public static TrustLinkVO tl = new TrustLinkVO();

    public HttpClientUtil(){
        tl.setAppId("A01");
        //tl.setIp("218.17.160.235");
        tl.setIp("192.168.3.5");
        tl.setName("USER");
        tl.setNameSpace("http://finger.aratek.com.cn");
        tl.setPort("26059");
        tl.setPwd("PASSWORD");
        tl.setUrl("TrustLinkWebService");
    }

    //获取服务端引擎信息
    public static String getAgentInfo() throws InternalSystemException{
        Map<String, String> patameterMap = new HashMap<>();
        patameterMap.put("pszExtInfo", "");
        String resultCode = getServiceResult(patameterMap, "wsGetAgentInfo");
        if ("0".equals(getReturncode(resultCode))){
            return getFlagcode(resultCode, "SvrInf");
        }
        return null;
    }

    //指纹报文注册
    public static String enrollFinger(String fingerData) throws InternalSystemException{
        Map<String, String> patameterMap = new HashMap<>();
        patameterMap.put("pszFingerData", fingerData);
        patameterMap.put("pszExtInfo", "");
        return getReturncode(getServiceResult(patameterMap, "wsFPEnroll"));
    }

    //指纹报文认证
    public static String VerifyFinger(String fingerData) throws InternalSystemException{
        logger.info("[SYS_LOG][{}][{}]","VerifyFinger",fingerData.length());
        Map<String, String> patameterMap = new HashMap<>();
        patameterMap.put("pszFingerData", fingerData);
        patameterMap.put("pszExtInfo", "");
        return getReturncode(getServiceResult(patameterMap, "wsFPVerify"));
    }

    //指纹报文认证(1:n)
    public static List<String[]> VerifyFingerIdentify(String fingerData) throws InternalSystemException{
        Map<String, String> patameterMap = new HashMap<>();
        patameterMap.put("pszFingerData", fingerData);
        patameterMap.put("pszExtInfo", "");
		String result = getServiceResult(patameterMap, "wsFPIdentify");
        List<String[]> list = new ArrayList<>();
		if ("0".equals(getReturncode(result))){
			String[] userName =  getFlagcode(result, "UsrNam").split(";");
			String[] fpIdx =  getFlagcode(result, "FpIdx").split(";");
			String[] score =  getFlagcode(result, "AlgSco").split(";");
			String[] arrayTemp = null;
			for(int i = 0; i < userName.length; i++){
				arrayTemp = new String[3];
				arrayTemp[0] = userName[i];
				arrayTemp[1] = fpIdx[i];
				arrayTemp[2] = score[i];
				list.add(arrayTemp);
			}
			return list;
		}
		return null;
    }

    //指纹特征比对(1:1)
    public static String VerifyFingerByFeature(String userId,String feature) throws InternalSystemException{
        Map<String, String> patameterMap = new HashMap<>();
        patameterMap.put("pszUserId", userId);
        patameterMap.put("pszFPTemplate", feature);
        patameterMap.put("pszExtInfo", "");
        return getReturncode(getServiceResult(patameterMap, "wsFPVerifyByTemplate"));
    }

    public static String IdentifyFingerByFeature(String feature) throws InternalSystemException {
        Map<String, String> patameterMap = new HashMap<>();
        patameterMap.put("pszFPTemplate", feature);
        patameterMap.put("pszExtInfo", "");
        return getReturncode(getServiceResult(patameterMap, "wsFPIdentifyByTemplate"));
    }

    //获取用户已注册指位
    public static String getFingers(String userId) throws InternalSystemException{
        Map<String, String> patameterMap = new HashMap<>();
        patameterMap.put("pszUserId", userId);
        patameterMap.put("pszExtInfo", "");
        String resultCode = getServiceResult(patameterMap, "wsFPGetFingers");
        if ("0".equals(getReturncode(resultCode))){
            return getFlagcode(resultCode, "FpIdx");
        }else{
            return "";
        }
    }

    //删除用户指纹信息
    public static boolean delUser(String userId,String extInfo) throws InternalSystemException{
        Map<String, String> patameterMap = new HashMap<>();
        patameterMap.put("pszUserId", userId);
        patameterMap.put("pszExtInfo", extInfo);
        String resultCode = getServiceResult(patameterMap, "wsDelUser");
        if("0".equals(getReturncode(resultCode))){
            return true;
        }else{
            return false;
        }
    }

    //访问webservice
    private static String getServiceResult(Map<String, String> patameterMap, String method) throws InternalSystemException {
        String tasResponse = null;
        CloseableHttpClient httpclient = HttpClients.createDefault();
        //读取Webservice的配置信息
        HttpPost httpPost = new HttpPost("http://" + CustomizedPropertyPlaceholderConfigurer.getContextProperty("DEFAULT_IP") + ":"
                + CustomizedPropertyPlaceholderConfigurer.getContextProperty("DEFAULT_PORT") + "/");
        httpPost.setHeader("Content-Type","application/soap+xml; charset=UTF-8");
        //拼接参数
        HttpEntity entity;
        try {
            entity = new StringEntity(buildRequestData(patameterMap,method));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            throw new InternalSystemException("Webservice访问失败,请检查安装机器的字符编码设置," + e.getMessage());
        }
        httpPost.setEntity(entity);
        try (CloseableHttpResponse response = httpclient.execute(httpPost)) {
            if (response.getStatusLine().getStatusCode() == 200) {
                tasResponse = CommonStringUtil.subStringByRule(EntityUtils.toString(response.getEntity(),"UTF-8"), "<ppszRsp>", "</ppszRsp>").replaceAll("&#xD;&#xA", "\r");
            }
            EntityUtils.consume(entity);
        }  catch (Exception e) {
            e.printStackTrace();
            throw new InternalSystemException("Webservice访问失败,请检查Webservice参数的配置," + e.getMessage());
        }
        logger.debug("[SYS_LOG][RES_XML][{}]",tasResponse);
        return tasResponse;
    }

    public static String buildRequestData(Map<String, String> patameterMap, String methodName) {
        patameterMap.put("pszAppId", (String)CustomizedPropertyPlaceholderConfigurer.getContextProperty("APPID"));
        patameterMap.put("pszAuthenId", (String)CustomizedPropertyPlaceholderConfigurer.getContextProperty("ADMINUSER"));
        patameterMap.put("pszAuthenPwd", (String)CustomizedPropertyPlaceholderConfigurer.getContextProperty("ADMINUSERPWD"));
        StringBuilder soapRequestData = new StringBuilder();
        soapRequestData.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
        soapRequestData.append("<soap:Envelope xmlns:soap=\"http://www.w3.org/2003/05/soap-envelope\" xmlns:impl=\"").append("http://finger.aratek.com.cn").append("\">");
        soapRequestData.append("<soap:Header/>");
        soapRequestData.append("<soap:Body>");
        soapRequestData.append("<impl:").append(methodName).append(">");
        Set<String> nameSet = patameterMap.keySet();
        for (String name : nameSet) {
            soapRequestData.append("<impl:").append(name).append(">").append(patameterMap.get(name)).append("</impl:").append(name).append(">");
        }
        soapRequestData.append("</impl:").append(methodName).append(">");
        soapRequestData.append("</soap:Body>");
        soapRequestData.append("</soap:Envelope>");
        return soapRequestData.toString();
    }

    public static String getFlagcode(String resultValue,String tagName) {
        String value = "";
        String[] code = resultValue.split("\r");
        for(int i = 0;i<code.length;i++) {
            if(code[i].indexOf(tagName) > -1) {
                value = code[i].substring(code[i].indexOf(":")+2);
                break;
            }
        }

        return value;
    }

    public static final String getReturnMsg(String resultValue) {
        String rInfo = resultValue.split("\r")[0];
        return rInfo.substring(rInfo.indexOf(" ") + 1);
    }

    public static final String getReturncode(String resultValue) {
        return resultValue.split(" ")[0];
    }
}