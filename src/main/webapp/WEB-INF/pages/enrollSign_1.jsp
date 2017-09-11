<%@ page language="java"  pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
  </head>
  
  <body style="text-align: center;">
	<table width="1120px" height="600px"  cellpadding="2" border="2" rules=rows>
		<tr>
			<td colspan="3" align="center" >
			<!--  
				<object align="center" border="2" id="MonitorOCX" vspace="5" name="MonitorOCX" classid="CLSID:771A46E2-FE64-44DC-A390-470C8386615C" width="1100" height="600"> </object>
				-->
				<object id="HWPenSign" name="HWPenSign" classid="clsid:E8F5278C-0C72-4561-8F7E-CCBC3E48C2E3" width="600" height="300">
			</td>
		</tr>
		<tr>
			<td align="center">
				<p>签名控制： </p>
				<input type="button" value="初始化设备" onclick="Start()"> 
				<input type="button" value="关闭设备" onclick="Pause()">
				<input type="button" value="重新签名" onclick="invalidatePos()">
			</td>
		<tr>
		<tr>
			<td align="center">
				<p>画笔控制： </p>
				<input type="button" value="黑色" onclick="Start()"> 
				<input type="button" value="红色" onclick="Pause()">
				<input type="button" value="绿色" onclick="invalidatePos()">
				<input type="button" value="蓝色" onclick="setPenColor()">
				<input type="button" value="笔宽加粗" onclick="base64()">
				<input type="button" value="笔宽减细" onclick="saveImg()">
				<input type="button" value="压力笔" onclick="clearSign()">
				<input type="button" value="钢笔" onclick="Start()"> 
			</td>
		<tr>
		<tr>
			<td align="center">
				<p>签名图像： </p>
				<input type="button" value="获取Base64数据" onclick="Start()"> 
				<input type="button" value="保存图像" onclick="Pause()">
			</td>
		<tr>
		<tr>
			<td align="center">
				<p>切屏控制： </p>
				<input type="button" value="移至扩展屏" onclick="Start()"> 
				<input type="button" value="移回主显示器" onclick="Pause()">
			</td>
		<tr>
		<tr>
			<td colspan="3"  >
			<textarea name="base64" id="base64" cols="140" rows = "10"></textarea>
			</td>
		</tr>
	</table>
	<script type="text/javascript">
		var newWin = null;
		$(function(){
			//openwindow("load?name=writeSign", "手写签名", 1280, 800) ;
			document.getElementById("HWPenSign").focus(); 
			//document.getElementById("MonitorOCX").Start(50);
		})
		
			
		function openwindow(url,name,iWidth,iHeight){
	      var url; //转向网页的地址;
	      var name; //网页名称，可为空;
	      var iWidth; //弹出窗口的宽度;
	      var iHeight; //弹出窗口的高度;
	      var iTop = 0;
	       var iLeft = window.screen.width;
	       newWin = window.open(url,name,'height='+iHeight+',,innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=auto,resizeable=no,location=no,status=no');
	    }
		
		function Start()
		{		  
			document.getElementById("MonitorOCX").Start(100);
			document.getElementById("MonitorOCX").focus(); 
		}
		function Pause()
		{		  
			document.getElementById("MonitorOCX").Close();	
			document.getElementById("MonitorOCX").focus();
		}
		function setPenColor()
		{
			newWin.document.getElementById("Screen_Sign").SetPenColorInJS(255,0,0);	
			document.getElementById("MonitorOCX").focus();
		}
		function base64()
		{
			//document.getElementById("base64").innerHTML=newWin.document.getElementById("Screen_Sign").SaveImageAsBase64();	
			
			document.getElementById("base64").innerHTML=newWin.document.getElementById("Screen_Sign").SaveImageWidthHeightAsBase64(600,400);
			
			document.getElementById("MonitorOCX").focus();
		}
		function invalidatePos()
		{
			newWin.document.getElementById("Screen_Sign").InvalidatePosition();
			document.getElementById("MonitorOCX").focus();
		}
		function saveImg()
		{
			newWin.document.getElementById("Screen_Sign").SaveImageAsWidthHeight("C:\\WriteSignBySetting.jpg",400,200);		
			document.getElementById("MonitorOCX").focus();
		}
		function clearSign() {
			newWin.document.getElementById("Screen_Sign").ClearSign();
			document.getElementById("MonitorOCX").focus(); 
		}
  	</script>
  </body>
</html>
