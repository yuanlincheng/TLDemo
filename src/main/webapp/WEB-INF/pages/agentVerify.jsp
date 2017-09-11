<%@ page language="java"  pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head></head>
  
 <body  >
 <div id="fingerDiv">
<object id='TLFPAPICtrl' name='TLFPAPICtrl' width="97" height="104" classid="CLSID:57FA9034-0DC3-4882-A932-DDDA228FEE05">
        <param name="Token" value="12345678912345678912345678912345" />
        <param name="CtrlType" value="Verify" />
        <!—修改CtrlType此持久化参数值即可实现嵌入式与弹出式转换-->
<embed id="pluginobj" type="application/mozilla-TLFPAPICtrl-plugin" width="97" height="104" Token="12345678912345678912345678912345" CtrlType="Verify"><!—修改CtrlType此持久化参数值即可实现嵌入式与弹出式转换-->
</embed>
</object>
</div>
<form id="FReg">
    <table id="TECtrl">  
    <tr>
          <td>重新初始化</td>
          <td><input type="Button" id="btnENROLLTMP" value="设置初始化数据" onclick="Javascript:InitFingerInfo();"></td>
       </tr>
        <tr>
          <td>获取组装后的指纹数据</td>
          <td><input type="Button" id="ButtonGet" value="获取指定指纹模板" onclick="Javascript:HasGotFeatureEvent();"></td>
       </tr>
       <tr>
          <td>指纹数据：</td>
          <td><input type="text" id="tpdata" style="WIDTH: 400px; HEIGHT: 24px" size="28"></td>
       </tr>       
       <tr>
          <td>指纹数据：</td>
          <td><input type="text" id="tpdatas" style="WIDTH: 400px; HEIGHT: 24px" size="28"></td>
       </tr>
	    <tr>
          <td>比对分值：</td>
          <td><input type="text" id="score" style="WIDTH: 400px; HEIGHT: 24px" size="28"></td>
       </tr>
       <tr>
          <td>指纹比对：</td>
          <td><input type="Button" id="Button2" value="指纹比对" onclick="Javascript:Verify();"></td>
       </tr>
    </table>
  </form>
  <script language="javascript">

function isIE() 
{ //ie?
  if (!!window.ActiveXObject || "ActiveXObject" in window)
     return true;
  else
     return false;
}


var tLFPAPICtrl = document.getElementById("TLFPAPICtrl");
var pluginobj = document.getElementById("pluginobj");

$(function(){
		InitNetSsVerify();
})

 
function sleep(numberMillis) { 
var now = new Date(); 
var exitTime = now.getTime() + numberMillis; 
while (true) { 
now = new Date(); 
if (now.getTime() > exitTime) 
return; 
} 
}
 



function InitNetSsVerify() 
{
	addEvent('GotFeatureEvent', hasGotFeatureEvent);
	if (isIE()) 
    {
    	TLFPAPICtrl.InitInstance("12345678912345678912345678912345");//初始化
        TLFPAPICtrl.SetFingerHasEnroll("L2R2")//设置显示已经注册哪些手指
        TLFPAPICtrl.SetHexFlg(1);//设置输出十六进制可见字符格式数据。
		TLFPAPICtrl.SetFPVersion(0);//设置SDK可见字符格式数据。
    }
    else
    {
        document.getElementById('pluginobj').focus();
        pluginobj.InitInstance("12345678912345678912345678912345");//初始化
        pluginobj.SetFingerHasEnroll("L2R2")//设置显示已经注册哪些手指
        pluginobj.SetHexFlg("1");//设置输出十六进制可见字符格式数据。
		pluginobj.SetFPVersion("0");//设置SDK可见字符格式数据。
    }
}
function InitFingerInfo()
{ //重新设置已注册手指
    if (isIE()) 
    {
        TLFPAPICtrl.InitInstance("12345678912345678912345678912345");//初始化
        TLFPAPICtrl.SetFingerHasEnroll("L2R2")//设置显示已经注册哪些手指
        TLFPAPICtrl.SetHexFlg(1);//设置输出十六进制可见字符格式数据。
        TLFPAPICtrl.ShowPopupWindow();//弹出窗口
   }
   else
   {
        document.getElementById('pluginobj').focus();
        pluginobj.InitInstance("12345678912345678912345678912345");//初始化
        pluginobj.SetFingerHasEnroll("L2R2")//设置显示已经注册哪些手指
        pluginobj.SetHexFlg("1");//设置输出十六进制可见字符格式数据。
        pluginobj.ShowPopupWindow();//弹出窗口
   }
}
 function hasGotFeatureEvent()
{
  if (isIE()) 
  {
	//  alert("IN");
      tp = TLFPAPICtrl.GetFingerPrintData();//IE浏览器获取指纹信息数据
      if (FReg.tpdata.value != "")
      {
          FReg.tpdatas.value = tp;
          Verify();
      }
      else 
      {
          FReg.tpdata.value = tp;
		  sleep(500);
		  TLFPAPICtrl.InitInstance("12345678912345678912345678912345");//初始化
      }
      
  }
  else
  {
    tp = pluginobj.GetFingerPrintData();//其他浏览器获取指纹信息数据
	if ( document.getElementById('tpdata').value != "")
     {
         document.getElementById('tpdatas').value = tp;
         Verify();
     }
     else 
     {
         document.getElementById('tpdata').value = tp;
     }
  }
}
function Verify() {

  if (isIE()) 
  {
    b1 = FReg.tpdata.value;
    b2 = FReg.tpdatas.value;
    FReg.score.value=TLFPAPICtrl.Verify(b1, b2, 2);
      
  }
  else
  {

	b1 = document.getElementById('tpdata').value;
    b2 = document.getElementById('tpdatas').value;
   document.getElementById('score').value=pluginobj.Verify(b1, b2, "2");
  }
}

function addEvent(name, func)//其他浏览器添加事件
{
 if (isIE())
{
   TLFPAPICtrl.focus();
}
else 
{ 
    var obj = document.getElementById('pluginobj');
    if (window.addEventListener)
    {   
        obj.addEventListener(name, func, false); 
    }
    else 
    {   
        obj.attachEvent(name, func);
    }
}
}
</script>
</body>
</html>
