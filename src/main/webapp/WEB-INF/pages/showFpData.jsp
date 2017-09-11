<%@ page language="java"  pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head></head>
  
  <body>
  <div id="fingerDiv">
<object id='TLFPAPICtrl' name='TLFPAPICtrl' width="350" height="228" classid="CLSID:57FA9034-0DC3-4882-A932-DDDA228FEE05">
        <param name="Token" value="12345678912345678912345678912345" />
        <param name="CtrlType" value="Register" />
        <!—修改CtrlType此持久化参数值即可实现嵌入式与弹出式转换-->
<embed id="pluginobj" type="application/mozilla-TLFPAPICtrl-plugin" width="350" height="228"
 Token="12345678912345678912345678912345" CtrlType="register"><!—修改CtrlType此持久化参数值即可实现嵌入式与弹出式转换-->
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
          <td>带指位信息的OCX模板：</td>
          <td><input type="text" id="tpdata" style="WIDTH: 400px; HEIGHT: 24px" size="28"></td>
       </tr>
	     <tr>
          <td>拆分指纹数据：</td>
		   <td><input type="Button" id="btnParse" value="拆分OCX模板" onClick="Javascript:ParseOcxTemplate();"></td>
       </tr>
	    <table>     
        <tr>        
          <td>
			<fieldset>
				<legend>数据</legend>
				<textarea name="Result" id="Result" cols="54" rows="20" style="height:300px"></textarea>
			</fieldset>
       </tr>
	     <tr>        
          <td>
			<fieldset>
				<legend>报文</legend>
				<textarea name="Result1" id="Result1" cols="54" rows="20" style="height:300px"></textarea>
			</fieldset>
       </tr>
    </table>
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

function InitNetSsVerify() 
{
    	addEvent('GotFeatureEvent', hasGotFeatureEvent);
    	if (isIE()) 
    {
        TLFPAPICtrl.InitInstance("12345678912345678912345678912345");//初始化
        TLFPAPICtrl.SetHexFlg(1);//设置输出十六进制可见字符格式数据。
		TLFPAPICtrl.SetFingerHasEnroll("L2R2");
       
    }
    else
    {
        document.getElementById('pluginobj').focus();
        pluginobj.InitInstance("12345678912345678912345678912345");//初始化
        pluginobj.SetHexFlg("1");//设置输出十六进制可见字符格式数据。
        pluginobj.SetFPVersion("0");

    }
}

function InitFingerInfo()
{ //重新设置已注册手指
    if (isIE()) 
    {
        TLFPAPICtrl.InitInstance("12345678912345678912345678912345");//初始化
        TLFPAPICtrl.SetHexFlg(1);//设置输出十六进制可见字符格式数据。
		TLFPAPICtrl.SetFingerHasEnroll("L2R2");
        TLFPAPICtrl.ShowPopupWindow();//弹出窗口
   }
   else
   {
        document.getElementById('pluginobj').focus();
        pluginobj.InitInstance("12345678912345678912345678912345");//初始化
        pluginobj.SetHexFlg("1");//设置输出十六进制可见字符格式数据。
        pluginobj.ShowPopupWindow();//弹出窗口
   }
}


function ParseOcxTemplate()
{
   if (isIE()) 
   {
	 tp= FReg.tpdata.value;
	 packData =TLFPAPICtrl.ParseOcxTemplate(tp);//IE浏览器获取指纹信息数据
	 FReg.Result.value=packData;
   }
   else
   {
     tp = document.getElementById('tpdata').value;
	 packData = pluginobj.ParseOcxTemplate(tp);//其他浏览器获取指纹信息数据
	 document.getElementById('Result').value = packData;
   }

}


 function hasGotFeatureEvent()
{
  if (isIE()) 
  {
	  TLFPAPICtrl.SetFPVersion(2);
      tp = TLFPAPICtrl.GetFingerPrintData();//IE浏览器获取指纹信息数据
	  FReg.Result1.value = tp;
      TLFPAPICtrl.SetFPVersion(0);
      tp = TLFPAPICtrl.GetFingerPrintData();//IE浏览器获取指纹信息数据
      FReg.tpdata.value = tp;
	  ParseOcxTemplate();

  }
  else
  {
    tp = pluginobj.GetFingerPrintData();//其他浏览器获取指纹信息数据
    document.getElementById('tpdata').value = tp;
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
