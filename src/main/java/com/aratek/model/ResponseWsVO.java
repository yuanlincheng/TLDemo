/*
 * 文件名：${XmlResponseVO}
 * 作者：${tree}
 * 版本：
 * 时间：${2014.7.29}
 * 修改：
 * 描述：文件夹中的文件对象
 *
 *
 * 版权：亚略特
 */
package com.aratek.model;



public class ResponseWsVO {

	//基本元素
	private int resultCode;
	private String resultMsg;
	private String sessionId;
	private String dataFlag;
	private String dataVersion;
	private String receiptId;
	private String Cipher;
	private String reqFingerId;
	private int personCount;
	private String fpPackage;
	private String signData;
	private String certData;

	private String fingerData;

	public String getCipher() {
		return Cipher;
	}

	public void setCipher(String cipher) {
		Cipher = cipher;
	}

	public String getReqFingerId() {
		return reqFingerId;
	}

	public void setReqFingerId(String reqFingerId) {
		this.reqFingerId = reqFingerId;
	}

	public String getFingerData() {
		return fingerData;
	}

	public void setFingerData(String fingerData) {
		this.fingerData = fingerData;
	}

	public int getResultCode() {
		return resultCode;
	}

	public void setResultCode(int resultCode) {
		this.resultCode = resultCode;
	}
	public String getResultMsg() {
		return resultMsg;
	}
	public void setResultMsg(String resultMsg) {
		this.resultMsg = resultMsg;
	}
	public String getSessionId() {
		return sessionId;
	}
	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}
	public String getReceiptId() {
		return receiptId;
	}
	public void setReceiptId(String receiptId) {
		this.receiptId = receiptId;
	}
	public int getPersonCount() {
		return personCount;
	}

	public void setPersonCount(int personCount) {
		this.personCount = personCount;
	}

	public String getFpPackage() {
		return fpPackage;
	}

	public void setFpPackage(String fpPackage) {
		this.fpPackage = fpPackage;
	}

	public String getSignData() {
		return signData;
	}

	public void setSignData(String signData) {
		this.signData = signData;
	}

	public String getCertData() {
		return certData;
	}

	public void setCertData(String certData) {
		this.certData = certData;
	}

	public String getDataFlag() {
		return dataFlag;
	}

	public void setDataFlag(String dataFlag) {
		this.dataFlag = dataFlag;
	}

	public String getDataVersion() {
		return dataVersion;
	}

	public void setDataVersion(String dataVersion) {
		this.dataVersion = dataVersion;
	}
}