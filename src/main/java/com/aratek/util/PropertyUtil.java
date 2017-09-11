/*
 * 文件名：${PropertyUtil}
 * 作者：${Tree}
 * 版本：
 * 时间：${2013.6.16}
 * 修改：
 * 描述：此類用於讀取property文件,以及一些涉及数据源的相关逻辑处理
 * 
 * 
 * 版权：深圳市迈科龙电子有限公司
 */
package com.aratek.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Map;
import java.util.Properties;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.aratek.model.TrustLinkVO;


public class PropertyUtil {
	
	private static Log log = LogFactory.getLog(PropertyUtil.class);
	
	public static String configUrl = "";
	
	/**
	 * 获取属性文件（读）
	 * @param  file  目标文件
	 * 	 
	 **/
	public static Properties toGetProIn(String file){
		InputStream in = null;
		Properties p = new Properties();
		try {
			in = new FileInputStream(new File(file));
			p.load(in);
		} catch (FileNotFoundException e) {
			log.error("配置文件丢失！");
		} catch (IOException e) {
			log.error("配置文件读取失败！");
		}finally{
			try {
				in.close();
			} catch (IOException e) {
				log.error("配置文件关闭IO失败！");
			}
		}
		return p;
	}
	
	/**
	 * 获取属性文件（写）
	 * @param  file  目标文件
	 * 	 
	 **/
	public static void toGetProOut(Properties p){
		OutputStream out = null;
		try {
			out = new FileOutputStream(new File(configUrl));
			p.store(out, "change data");
		} catch (FileNotFoundException e) {
			log.error("配置文件丢失！");
		} catch (IOException e) {
			e.printStackTrace();
		} finally{
			try {
				out.flush();
				out.close();
			} catch (IOException e) {
				log.error("配置文件关闭IO失败！");
			}
		}
	}
	
	/**
	 * 获取属性文件（读）
	 * @param  file  目标文件
	 * 	 
	 **/
	public static TrustLinkVO  getTrustLink(){
		TrustLinkVO tl = new TrustLinkVO();
		tl.setIp(getTrustLinkManagementValue("DEFAULT_IP"));
		tl.setPort(getTrustLinkManagementValue("DEFAULT_PORT"));
		tl.setUrl(getTrustLinkManagementValue("DEFAULT_PID"));
		tl.setNameSpace(getTrustLinkManagementValue("DeFAULT_NAMESPACE"));
		tl.setAppId(getTrustLinkManagementValue("APPID"));
		tl.setName(getTrustLinkManagementValue("ADMINUSER"));
		tl.setPwd(getTrustLinkManagementValue("ADMINUSERPWD"));
		return tl;
	}
	
	public static void setTrustLink(Map<String, String> map){
		Properties p = PropertyUtil.toGetProIn(configUrl);
		p.setProperty("DEFAULT_IP", map.get("ip"));
		p.setProperty("DEFAULT_PORT", map.get("port"));
		p.setProperty("ADMINUSER", map.get("name"));
		p.setProperty("ADMINUSERPWD", map.get("pwd"));
		PropertyUtil.toGetProOut(p);
	}
	
	public static String getTrustLinkManagementValue(String key){
		Properties p = PropertyUtil.toGetProIn(configUrl);
		return  p.getProperty(key);
	}
}
