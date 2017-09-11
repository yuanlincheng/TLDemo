<%@ page language="java"  pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <title></title>
    <style>
			html,body{padding:0;margin:0;font-size:13px;}
			.clearfix:after{content:".";display:block;height:0;clear:both;visibility:hidden}
			* html>body .clearfix{display:inline-block;width:100%}
			* html .clearfix{height:1%;/* End hide from IE-mac */}
			*+html .clearfix{min-height:1%}
			 ul,li{list-style:none;padding:0;margin:0;text}
			 em,i,b{font-style:normal}
			 h4{padding:0;margin:0;line-height:28px;}
			.content{width:889px;padding:40px;margin:0 auto}
			.bder{width:341px;height:233px;background:url("images/c_bg.png");text-align:center;padding:3px 0 0 0;display:block;}
			.b{float:left;margin:0 10px 0 0}
			.b div{width:341px;height:233px;background:url("images/c_bg.png");padding:3px 0 0 0;}
			.b ul li{line-height:26px;}
			.b ul li span{width:100px;text-align:right;display:block;float:left}
			.b ul li em{font-weight:bold;}
		</style>
  </head>
  
  <body>
	<input name="operate" id="operate" type="hidden" value="alert"/> 
	<form id="dataForm" name="dataForm">
		<input name="fingerData" id="fingerData" type="hidden" /> 
		<div class="content">
			<div>
				<div class="b">
					<h4><spring:message code="user_info" /></h4>
					<div>
						<ul style="margin:95px 15px;">
							<li><span><spring:message code="id" />: </span><input type="text" id="name" name="name" /></li>
							<!--  
							<li><span> <input type="button" value="比对" onclick="hasGotFeatureEvent();"> </span></li>
							-->
						</ul>
					</div>
				</div>
				<div class="b">
					<h4><spring:message code="finger" /></h4>
					<div class="bder" id="fingerDiv">
						<object id='TLFPAPICtrl' name='TLFPAPICtrl' width="97" height="104" classid="CLSID:57FA9034-0DC3-4882-A932-DDDA228FEE05" style="margin:55px 25px;">
						        <param name="Token" value="12345678912345678912345678912345" />
						        <param name="CtrlType" value="Verify" />
								<embed id="pluginobj" type="application/mozilla-TLFPAPICtrl-plugin" width="97" height="104"
						 			Token="12345678912345678912345678912345" CtrlType="Verify" style="margin:55px 25px;">
								</embed>
						</object>
					</div>
				</div>
			</div>
		</div>
	</form>
	<script type="text/javascript">
		var tLFPAPICtrl = document.getElementById("TLFPAPICtrl");
		var pluginobj = document.getElementById("pluginobj");

		$(function() {
			InitNetSsVerify();
		})

		function InitNetSsVerify() {
			//addEvent('GotFeatureEvent', hasGotFeatureEvent);
			var angentInfo = $("#agentInfo").val();
			if (isIE()) {
				tLFPAPICtrl.SetAgentInfo(angentInfo);
				tLFPAPICtrl.Open("1");
				tLFPAPICtrl.SetFPVersion("2");
			} else {
				document.getElementById('pluginobj').focus();
				pluginobj.SetAgentInfo(angentInfo);
				pluginobj.Open("1");
				pluginobj.SetFPVersion("2");
			}
		}

		function addEvent(name, func) {
			if (isIE()) {
				tLFPAPICtrl.focus();
			} else {
				var obj = document.getElementById('pluginobj');
				if (window.addEventListener) {
					obj.addEventListener(name, func, false);
				} else {
					obj.attachEvent(name, func);
				}
			}
		}

		//重置form表單中的元素
		function resetFinger() {
			if (isIE()) {
				tLFPAPICtrl.InitInstance("12345678912345678912345678912345");//初始化
			} else {
				pluginobj.InitInstance("12345678912345678912345678912345");//初始化
			}
		}
	
		function hasGotFeatureEvent() {
			var tp = "";
			if ($("#name").val().replace(/\ /g, '') == "") {
				alert("<spring:message code="require_verify_id" />");
				InitNetSsVerify();
				return;
			}
			var name = $("#name").val();
			if (isIE()) {
				tLFPAPICtrl.SetFPPackInfo(name, 1);
				tp = tLFPAPICtrl.GetFingerPrintData();
			} else {
				pluginobj.SetFPPackInfo(name, "1");
				tp = pluginobj.GetFingerPrintData();
			}
			//alert(tp);
			$("#fingerData").val(tp);
			updateInfo("verify", "dataForm", "result");
		}
	</script>
</body>
</html>
