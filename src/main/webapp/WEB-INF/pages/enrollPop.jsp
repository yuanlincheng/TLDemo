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
			.content{width:889px;padding:40px;margin:0 auto}
			.in{width:341px;height:39px;text-indent:6px;line-height:39px;background:url("images/form_bg.png");border:0;padding:0;margin:0;display:block;float:left}
			.bder{width:341px;height:233px;background:url("images/c_bg.png");text-align:center;padding:3px 0 0 0;display:block;float:left}
			.sub{width:341px;height:39px;text-align:center;line-height:39px;background:url("images/form_bg.png") no-repeat 0 -39px;border:0;padding:0;margin:0;color:white;display:block;float:left}
			.content span{width:235px;height:41px;line-height:41px;text-indent:2em;background:url("images/form_bg.png") no-repeat 0 -78px;display:block;float:left;margin:0 0 0 6px}
			.error{color: red }
			.success{color: green }
		</style>
  </head>
  
  <body>
	<input name="operate" id="operate" type="hidden" value="alert"/> 
	<form id="dataForm" name="dataForm">
		<input name="fingerData" id="fingerData" type="hidden" /> 
		<div class="content">
			<div class="clearfix">
				<input type="text" class="in" id="name" name="name" onblur="getFinger();"  />
				<span id="name_ck"><spring:message code="step_input_id" /></span>
			</div>
			<div class="clearfix" style="margin:20px 0">
				<div class="bder" id="fingerDiv">
					<object id="TLFPAPICtrl" name="TLFPAPICtrl" width="0" height="0" classid="CLSID:57FA9034-0DC3-4882-A932-DDDA228FEE05">
					       <param name="CtrlType" value="Register_popup" />
						   <embed id="pluginobj" type="application/mozilla-TLFPAPICtrl-plugin" width="0" height="0" ctrltype="register_popup">
						   </embed>
					</object>
				</div>
				<span id="fingerDiv_ck"><spring:message code="step_input_finger" /></span>
			</div>
			<div class="clearfix">
				<input type="button" onclick="initFinger();" class="sub" value="<spring:message code="save" />" /><span><spring:message code="step_submit_user" /></span>
			</div>
		</div>
	</form>
	<script type="text/javascript">
		$(function() {
			$.messager.show({
				title : '<spring:message code='title' />',
				msg : '<spring:message code='pop_msg' />                                                                   ',
				timeout : 0,
				showType : 'slide'
			});
		})

		var tLFPAPICtrl = document.getElementById("TLFPAPICtrl");
		var pluginobj = document.getElementById("pluginobj");

		function InitNetSsVerify(fpIndex) {
			//addEvent('GotFeatureEvent', hasGotFeatureEvent);
			var angentInfo = $("#agentInfo").val();
			var name = $("#name").val();
			if (isIE()) {
				tLFPAPICtrl.SetAgentInfo(angentInfo);
				tLFPAPICtrl.SetFPPackInfo(name, 1);
				tLFPAPICtrl.SetFingerHasEnroll(fpIndex);
				//定制添加（华为项目，默认采集左手食指）
			    tLFPAPICtrl.SelectFingerToReg("L2");
				tLFPAPICtrl.ShowPopupWindow();
			} else {
				pluginobj.SetAgentInfo(angentInfo);
				pluginobj.SetFPPackInfo(name,"1");
				pluginobj.SetFingerHasEnroll(fpIndex);
				//定制添加（华为项目，默认采集左手食指）
			    pluginobj.SelectFingerToReg("L2");
				pluginobj.ShowPopupWindow();
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

		function hasGotFeatureEvent() {
			$("#fingerDiv_ck").addClass("success").html("<spring:message code="enroll_success" />");
		}

		function initFinger() {
			var tp = "";
			if ($("#name").val().replace(/\ /g, '') == "") {
				$("#name_ck").addClass("error").html("<spring:message code="require_enroll_id" />")
						.addClass("");
				return;
			} else {
				$("#name_ck").removeClass("error").html("<spring:message code="step_input_id" />");
			}
			var name = $("#name").val();
			if (isIE())
		    {
		       tLFPAPICtrl.SetFPPackInfo(name, 1);
	    	   tp = tLFPAPICtrl.GetFingerPrintData(); 
		    }else{
	    	   pluginobj.SetFPPackInfo(name, "1");
		       tp = pluginobj.GetFingerPrintData(); 	
		    }
			$("#fingerData").val(tp);
			var fingerData = $("#fingerData").val();
			if (fingerData == "" || fingerData == 2) {
				$("#fingerDiv_ck").addClass("error").html("<spring:message code="require_enroll_finger" />");
				return;
			} else {
				$("#fingerDiv_ck").removeClass("success").removeClass("error").html("<spring:message code="step_input_finger" />");
			}
			updateInfo("enroll", "dataForm", "result");
		}

		//重置form表單中的元素
		function resetFinger() {
			if (isIE()) {
				tLFPAPICtrl.InitInstance("12345678912345678912345678912345");//初始化
			} else {
				pluginobj.InitInstance("12345678912345678912345678912345");//初始化
			}
		}

		function getFinger() {
			var name = $("#name").val();
			if ("" != name) {
				$.ajax({
					type : "POST",
					url : convertURL("getFpIndex"),
					dataType : "json",
					data : $("#dataForm").serialize(),
					success : function(data) {
						var fpIndex = "";
						if (data.anyStatu == 1) {
							fpIndex = data.anyString;
						}
						InitNetSsVerify(fpIndex);
					}
				});
			}
		}
	</script>
</body>
</html>
