<%@ page language="java"  pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
  <script language="javascript" type="text/javascript">

 var penwidth = 3;
 var obj;

 $(function(){
	 $(".layout-button-left").click();
     obj = document.getElementById("HWPenSign"); 
     obj.HWSetBkColor(0xE0F8E0);  
     obj.HWSetCtlFrame(2, 0x000000); 
     Button1_onclick();
 });
 

function Button1_onclick() {
   var res = obj.HWInitialize();
}

function Button2_onclick() {
   var stream;
   stream = obj.HWFinalize();
}


function Button3_onclick() {
   obj.HWClearPenSign();
}

function Button6_onclick() {
   obj.HWSetPenColor(0x000000);   
}

function Button7_onclick() {
   obj.HWSetPenColor(0xFF0000);   
}

function Button8_onclick() {
   obj.HWSetPenColor(0x00FF00);   
}

function Button9_onclick() {
   obj.HWSetPenColor(0x0000FF);   
}

function Button10_onclick() {
    penwidth++;
    if(penwidth >5)
       penwidth = 5;
    obj.HWSetPenWidth(penwidth);   
}

function Button11_onclick() {
    penwidth--;
    if(penwidth < 1)
       penwidth = 1;
    obj.HWSetPenWidth(penwidth);   
}

function Button12_onclick() {
   obj.HWSetPenMode(1);
}

function Button13_onclick() {
   obj.HWSetPenMode(0);
}

function Button14_onclick() {
   var stream;
   stream = obj.HWGetBase64Stream(3);
   alert(stream);
}
   
function Button15_onclick() { 
   var res = obj.HWIsNeedSave();
   if(res)
   {
       obj.HWSetFilePath("e:\\sign.png");   
       obj.HWSaveFile();
   }
   else
   {
       alert("No Sign Data");
   }
}

function Button16_onclick() {
   obj.HWSwitchMonitor(1,0);
}

function Button17_onclick() {
   obj.HWSwitchMonitor(0,0);
}


function PrePage_Event() {
    alert("PrePage_Event");
}

function NextPage_Event() {
    alert("NextPage_Event");
}

function Confirm_Event() {
    alert("Confirm_Event");
}

function Cancel_Event() {
    alert("Cancel_Event");
}

function signComplete() {
    Button14_onclick();
}

function signRestart() {
            
}

</script>
  </head>
  
  <body style="text-align: center;">
    <p style="margin-top: 120px;"></p>
    <table width="90%" border="0" align="center" cellpadding="3" cellspacing="0">           
       <tr>
	   <td vAlign="center" height="217" align="right"><P>签字区域：</P></td>  
       <td  align="left">
        	<object id="HWPenSign" name="HWPenSign" classid="clsid:E8F5278C-0C72-4561-8F7E-CCBC3E48C2E3" width="600" height="300"></object>
	   </td>
	   <td Style="text-align: left;">
        	<p>
          签名控制： 
          <input id = "button1" type ="button" value="初始化设备" onclick ="return Button1_onclick()" />
                &nbsp;&nbsp;
          <input id = "button2" type ="button" value="关闭设备" onclick ="return Button2_onclick()" />
                &nbsp;&nbsp; 
          <input id="Button3" type="button" value="重新签名" onclick="return Button3_onclick()" />
       	        <br><br>
          画笔控制：
	  <input id="Button6" type="button" value="黑色" onclick="return Button6_onclick()" />
		 &nbsp;&nbsp;&nbsp;
          <input id="Button7" type="button" value="红色" onclick="return Button7_onclick()" />
		 &nbsp;&nbsp;&nbsp;
          <input id="Button8" type="button" value="绿色" onclick="return Button8_onclick()" />
		 &nbsp;&nbsp;&nbsp;
          <input id="Button9" type="button" value="蓝色" onclick="return Button9_onclick()" />
		<br><br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;  
          &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;<input id="Button10" type="button" value="笔宽加粗" onclick="return Button10_onclick()" />
		 &nbsp;&nbsp;&nbsp;
          <input id="Button11" type="button" value="笔宽减细" onclick="return Button11_onclick()" /> 
                 <br><br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;  
          <input id="Button12" type="button" value="压力笔" onclick="return Button12_onclick()" />
		 &nbsp;&nbsp;&nbsp;
          <input id="Button13" type="button" value="钢笔" onclick="return Button13_onclick()" />
                <br><br>
            签名图像:
          &nbsp;&nbsp;<input id="Button14" type="button" value="Base64Stream" onclick="return Button14_onclick()" />
          &nbsp;&nbsp;&nbsp;
          <input id="Button15" type="button" value="保存图像" onclick="return Button15_onclick()" /> 
          &nbsp;&nbsp;
                <br><br>
           切屏控制： 
          <input id = "button16" type ="button" value="签名" onclick ="return Button16_onclick()" />
                &nbsp;&nbsp;
          <input id = "button17" type ="button" value="签名完成" onclick ="return Button17_onclick()" />
                <br><br>
    </p>
	   </td>
       </tr>                       
    </table>

  </body>
</html>
