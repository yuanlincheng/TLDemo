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
  
  <body >
	<input name="operate" id="operate" type="hidden" value="alert"/> 
	<form id="dataForm" name="dataForm">
		<input name="fingerData" id="fingerData" type="hidden" /> 
		<div class="content">
			<div>
				<div class="b">
					<h4><spring:message code="user_info" /></h4>
					<div>
						<ul style="margin:95px 25px;">
							<li><span><spring:message code="id" />: </span><input type="text" id="name" name="name" onblur="getFinger();" /></li>
						</ul>
					</div>
				</div>
				<div class="b">
					<h4><spring:message code="finger" /></h4>
					<div class="bder" id="fingerDiv">
						<object id='TLFPAPICtrl' name='TLFPAPICtrl' width="0" height="0" classid="CLSID:57FA9034-0DC3-4882-A932-DDDA228FEE05">
						        <!―修改CtrlType此持久化参数值即可实现嵌入式与弹出式转换-->
						        <param name="CtrlType" value="Verify_popup" />
						        <!―修改CtrlType此持久化参数值即可实现嵌入式与弹出式转换-->
						        <embed id="pluginobj" type="application/mozilla-TLFPAPICtrl-plugin" width="0" height="0" CtrlType="Verify_popup">
						        </embed> 
						</object>
					</div>
				</div>
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
			addEvent('GotFeatureEvent', hasGotFeatureEvent);
			var name = $("#name").val();
			var angentInfo = $("#agentInfo").val();
			if (isIE()) {
				tLFPAPICtrl.SetAgentInfo(angentInfo);
				tLFPAPICtrl.SetFPPackInfo(name, 1);
				tLFPAPICtrl.SetFingerHasEnroll(fpIndex);
				tLFPAPICtrl.ShowPopupWindow();
			} else {
				pluginobj.SetAgentInfo(angentInfo);
				pluginobj.SetFPPackInfo(name, "1");
				pluginobj.SetFingerHasEnroll(fpIndex);
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
			var tp = "";
			if ($("#name").val().replace(/\ /g, '') == "") {
				alert("<spring:message code="require_verify_id" />");
				return;
			}
			if (isIE()) {
				tp = tLFPAPICtrl.GetFingerPrintData();
			} else {
				tp = pluginobj.GetFingerPrintData();
			}
			$("#fingerData").val(tp);
			updateInfo("verify", "dataForm", "result");
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
			         	if(data.anyStatu == 1){
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
