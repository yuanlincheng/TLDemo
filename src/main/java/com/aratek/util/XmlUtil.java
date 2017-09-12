
package com.aratek.util;

import com.aratek.model.ResponseWsVO;
import com.exception.InternalSystemException;
import org.apache.commons.codec.binary.Base64;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 文件名：
 * 作者：tree
 * 时间：2016/6/17
 * 描述：解析XML数据工具类
 *
 * 版权：亚略特
 */
public class XmlUtil {

    //日志对象
    private static final Logger logger = LoggerFactory.getLogger(XmlUtil.class);
    // 报文解析
    public static ResponseWsVO parseTasXml(String xmlResponse) throws InternalSystemException {
        ResponseWsVO crv = null;
        try {
            crv = new ResponseWsVO();
            // 通过输入的XML数据构造一个Document
            Document doc = DocumentHelper.parseText(xmlResponse);
            // 取的根元素
            Element root = doc.getRootElement();

            Element actionResult = root.element("ActionResult");
            Element resultParam = root.element("ResultParam");

            Element resultCode = actionResult.element("ResultCode");
            Element resultMsg = actionResult.element("ResultMsg");

            crv.setResultCode(Integer.parseInt(resultCode.getTextTrim()));
            crv.setResultMsg(resultMsg.getTextTrim());

            // 报文中的result元素
            if (null != resultParam) {
                Element sessionId = resultParam.element("SessionId");
                Element receiptId = resultParam.element("ReceiptId");

                // 报文中的App元素
                if (null != sessionId) {
                    crv.setSessionId(sessionId.getTextTrim());
                }

                // 报文中的App元素
                if (null != receiptId) {
                    crv.setReceiptId(receiptId.getTextTrim());
                }

                Element serviceResult = resultParam.element("ServiceResult");

                if (null != serviceResult) {

                    Element FingerDatasList =  serviceResult.element("FingerDatasList");

                    if(null != FingerDatasList){
                        Element cipher = serviceResult.element("Envelope").element("Cipher");
                        Element reqFingerId = serviceResult.element("FingerDatasList").element("FingerDatas").element("ReqFingerId");
                        Element fingerData = serviceResult.element("FingerDatasList").element("FingerDatas").element("FingerDataList").element("FingerData");

                        if (null != cipher) {
                            crv.setCipher(cipher.getTextTrim());
                        }
                        if (null != reqFingerId) {
                            crv.setReqFingerId(reqFingerId.getTextTrim());
                        }
                        if (null != fingerData) {
                            crv.setFingerData(fingerData.getTextTrim());
                        }
                    }
                }
            }
            return crv;
        }catch (Exception e) {
            e.printStackTrace();
            // 解析失败，报文格式不符合标准
            throw new InternalSystemException("数据报文格式错误：" + e.getMessage());
        }
    }

    public static ResponseWsVO parseFPXml(String xmlResponse) throws InternalSystemException {
        ResponseWsVO crv = null;
        try {
            crv = new ResponseWsVO();
            // 通过输入的XML数据构造一个Document
            Document doc = DocumentHelper.parseText(xmlResponse);
            // 取的根元素
            Element root = doc.getRootElement();

            Element fpPackageHead = root.element("FPPackageHead");
            Element dataFlag = fpPackageHead.element("dataFlag");
            Element dataVersion = fpPackageHead.element("dataVersion");
            Element fpPackageBody = root.element("FPPackageBody");
            Element id = fpPackageBody.element("id");
            Element cipher = fpPackageBody.element("Envelope").element("cipher");
            Element fpData = fpPackageBody.element("Envelope").element("fpData");
            Element signData = fpPackageBody.element("Signature").element("signData");
            Element certData = fpPackageBody.element("Signature").element("cert");

            // 报文中的App元素
            if (null != dataFlag) {
                crv.setDataFlag(dataFlag.getTextTrim());
            }
            if (null != dataVersion) {
                crv.setDataVersion(dataVersion.getTextTrim());
            }
            if (null != id) {
                crv.setReqFingerId(id.getTextTrim());
            }
            if (null != cipher) {
                crv.setCipher(cipher.getTextTrim());
            }
            if (null != fpData) {
                crv.setFingerData(fpData.getTextTrim());
            }
            if (null != signData) {
                crv.setSignData(signData.getTextTrim());
            }
            if (null != certData) {
                crv.setCertData(certData.getTextTrim());
            }

            return crv;
        } catch (Exception e) {
            e.printStackTrace();
            // 解析失败，报文格式不符合标准
            throw new InternalSystemException("数据报文格式错误");
        }
    }

    /**
     * 构建请求XML报文数据
     *
     * @param fpData 报文对象
     * @param reqFpId 指纹编号
     * @return 报文数据
     */
    public static String builtXml(String fpData, String reqFpId) throws InternalSystemException {
        //构建请求XML报文数据
        //报文头
        StringBuffer sbData = new StringBuffer(fpData.substring(0, fpData.indexOf("<id>")+4));
        sbData.append(reqFpId);
        sbData.append(fpData.substring(fpData.indexOf("</id>"), fpData.indexOf("</FPPackage>") + 12));
        //返回报文数据
        return Base64.encodeBase64String(sbData.toString().getBytes());
    }

}
