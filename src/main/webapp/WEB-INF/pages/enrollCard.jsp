<%@ page language="java"  pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head></head>
  
  <body>
<p>
<object id='CertCtl' name='CertCtl' width="0" height="0" classid="CLSID:BC044A60-23CC-4F5C-8C16-476648435AC1">
</object>
<form id="FReg">
    <table id="TECtrl">  
    <tr>
          <td align="right">连接设备：</td>
          <td><input type="Button" id="btnOpen" value="连接设备" onclick="Javascript:Connect();"></td>
       </tr>
        <tr>
          <td align="right">读身份证：</td>
          <td><input type="Button" id="btnRdInfo" value="读取身份证" onclick="Javascript:ReadCardInfo();"></td>
       </tr>
	    <tr>
          <td align="right">断开设备：</td>
          <td><input type="Button" id="btnClose" value="断开设备" onclick="Javascript:Disconnect();"></td>
       </tr>
	   <tr>
          <td align="right">读物理ID：</td>
          <td><input type="Button" id="btnGet" value="读物理ID" onclick="Javascript:ReadCardID();"></td>
       </tr>
		<tr>
		<td align="right">连接/断开结果：</td>
		<td><input type="text" name="conResult"  id="conResult" size="49"></td>
		</tr>

		<tr>
		<td align="right">物理ID：</td>
		<td><input type="text" name="PhyID" size="49"></td>
		</tr>

		<tr>
		<td align="right">姓名：</td>
		<td><input type="text" name="Name" size="49">(要求中间，两头都没有空格)</td>
		</tr>

		<tr>
		<td align="right">性别：</td>
		<td><input type="text" name="Sex" size="49">(取值为“1”（表示“男”）或“2”（表示“女”）)</td>
		</tr>

		<tr>
		<td align="right">民族：</td>
		<td><input type="text" name="Nation" size="49"></td>
		</tr>

		<tr>
		<td align="right">出生：</td>
		<td><input type="text" name="Born" size="49">(要求格式为:yyyyMMdd，长度为8)</td>
		</tr>

		<tr>
		<td align="right">地址：</td>
		<td><input type="text" name="Address" size="49"></td>
		</tr>


		<tr>
		<td align="right">身份证号：</td>
		<td><input type="text" name="CardNo" size="49" style="color: #FF0000">(居民身份号码，长度18位)</td>
		</tr>


		<tr>
		<td align="right">签发机关：</td>
		<td><input type="text" name="Police" size="49"></td>
		</tr>

		<tr>
		<td align="right">期限起始：</td>
		<td><input type="text" name="ActivityLFrom" size="49">(要求格式为:yyyyMMdd，长度为8)</td>
		</tr>
		<tr>
		<td align="right">期限失效：</td>
		<td><input type="text" name="ActivityLTo" size="49">(要求格式为:yyyyMMdd，长度为8)</td>
		</tr>
		<tr>
		<td align="right">指纹数据：</td>
		<td><input type="text" name="FPInfo" size="49"></td>
		</tr>
		<tr>
		<td align="right">头像：</td>
  		<td><img id="imgPre" src=""> </td>      
		</tr>
    </table>
  </form>
	<script type="text/javascript">
	function clearForm() {
		  document.all['Name'].value = ''; 
		  document.all['Sex'].value = ''; 
		  document.all['Nation'].value = ''; 
		  document.all['Born'].value = ''; 
		  document.all['Address'].value = ''; 
		  document.all['CardNo'].value = ''; 
		  document.all['Police'].value = '';  
		  document.all['ActivityLFrom'].value = ''; 
		  document.all['ActivityLTo'].value = ''; 
		  document.all['FPInfo'].value = ''; 
		  document.getElementById("imgPre").src= '';
		}

		function strlen(str){
		    var len = 0;
		    for (var i=0; i<str.length; i++) { 
		     var c = str.charCodeAt(i); 
		    //单字节加1 
		     if ((c >= 0x0001 && c <= 0x007e) || (0xff60<=c && c<=0xff9f)) { 
		       len++; 
		     } 
		     else { 
		      len+=2; 
		     } 
		    } 
		    return len;
		}


		function Connect()
		{//连接设备
		    clearForm();
		      var resultFlag = CertCtl.CID_IDCARD_OpenDevice();//连接设备
		      if(resultFlag == "0")
		      {
		        document.all['conResult'].value = "连接设备成功"; 
		      }
		      else
		      {
		    	  document.all['conResult'].value = "断开设备失败"; 
		         alert(resultFlag);
		      } 

		 
		}

		function Disconnect()
		{ //断开设备
		    clearForm();
		      var resultFlag=CertCtl.CID_IDCARD_CloseDevice();//断开设备
		      if(resultFlag == "0")
		      {
		        document.all['conResult'].value = "断开设备成功"; 
		      }
		      else
		      {
		         document.all['conResult'].value = "断开设备失败"; 
		         alert(resultFlag);
		      } 

		}


		 function OnGetIDCardInfo()
		{//获取身份信息
		    clearForm();
			   var infoStr = CertCtl.CID_IDCARD_ReadInfo();//读取身份证
			   if(strlen(infoStr) > 5 )
			   {
		         document.all['conResult'].value = "读取身份证成功"; 
				 document.all['Name'].value = CertCtl.CID_IDCARD_GetName(infoStr); 
				 document.all['Sex'].value = CertCtl.CID_IDCARD_GetSex(infoStr); 
				 document.all['Nation'].value = CertCtl.CID_IDCARD_GetFolk(infoStr); 
				 document.all['Born'].value = CertCtl.CID_IDCARD_GetBirth(infoStr); 
				 document.all['Address'].value = CertCtl.CID_IDCARD_GetAddr(infoStr); 
				 document.all['CardNo'].value = CertCtl.CID_IDCARD_GetIDNum(infoStr);  
				 document.all['Police'].value = CertCtl.CID_IDCARD_GetDep(infoStr);  
				 document.all['ActivityLFrom'].value = CertCtl.CID_IDCARD_GetBegin(infoStr); 
				 document.all['ActivityLTo'].value = CertCtl.CID_IDCARD_GetEnd(infoStr);  
				 document.all['FPInfo'].value = CertCtl.CID_IDCARD_GetFPInfo(infoStr);  
		     	 document.getElementById("imgPre").src= "data:image/gif;base64,"+CertCtl.CID_IDCARD_ImageDecode(infoStr)
				
			   }
			   else
			   {
		         document.all['conResult'].value = "读取身份证失败"; 
				  alert(infoStr);
			   }


		} 

		function ReadCardInfo()
		{
			clearForm(); 
			var Ret = CertCtl.CID_IDCARD_StartReadIDCard();//读取身份证
			 if(Ret == 0)
			 {
		          document.all['conResult'].value = "正在读卡..."; 
			 }
			 else
			 {
		          alert(Ret);
			 }
		}


		function ReadCardID()
		{ //读物理ID
		    clearForm();
		      var IDStr = CertCtl.CID_IDCARD_ReadCardID();//读物理ID
			  if(strlen(IDStr) > 5)
		      {
		          document.all['PhyID'].value = IDStr; 
		      }
		      else
		      {
		        alert(IDStr);
		      }

		}	
	</script>
  </body>
</html>
