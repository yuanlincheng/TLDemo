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
			
			table.gridtable {
				font-family: verdana,arial,sans-serif;
				font-size:11px;
				color:#333333;
				border-width: 1px;
				border-color: #666666;
				border-collapse: collapse;
			}
			table.gridtable th {
				border-width: 1px;
				padding: 8px;
				border-style: solid;
				border-color: #666666;
				background-color: #dedede;
			}
			table.gridtable td {
				border-width: 1px;
				padding: 8px;
				border-style: solid;
				border-color: #666666;
				background-color: #ffffff;
			}
		</style>
  </head>
  
  <body>
	<input name="operate" id="operate" type="hidden" value="ajax"/> 
	<form id="dataForm" name="dataForm">
		<input name="fingerData" id="fingerData" type="hidden" /> 
		<div class="content">
			<div>
				<div id="fingerDiv">
					<object id='TLFPAPICtrl' name='TLFPAPICtrl' width="0" height="0" classid="CLSID:57FA9034-0DC3-4882-A932-DDDA228FEE05">
						        <!―修改CtrlType此持久化参数值即可实现嵌入式与弹出式转换-->
						        <param name="CtrlType" value="Verify_popup" />
						        <!―修改CtrlType此持久化参数值即可实现嵌入式与弹出式转换-->
						        <embed id="pluginobj" type="application/mozilla-TLFPAPICtrl-plugin" width="0" height="0" CtrlType="Verify_popup">
						        </embed> 
						</object>
				</div>
				<div class="b">
					<h4><spring:message code="user_list" /></h4>
						<table class="gridtable">
							<thead>
								<tr>
									<th width="150px"><spring:message code="id" /></th>
									<th width="150px"><spring:message code="index" /></th>
									<th width="150px"><spring:message code="score" /></th>
								</tr>
							</thead>
							<tbody id="result">
							</tbody>
						</table>
				</div>
			</div>
		</div>
	</form>
  		<script type="text/javascript">
					var tLFPAPICtrl = document.getElementById("TLFPAPICtrl");
					var pluginobj = document.getElementById("pluginobj");
					
					$(function(){
						InitNetSsVerify();
					})
					
					function InitNetSsVerify() {
						addEvent('GotFeatureEvent', hasGotFeatureEvent);
						var angentInfo = $("#agentInfo").val();
						if (isIE()) {
							tLFPAPICtrl.SetAgentInfo(angentInfo);
							tLFPAPICtrl.ShowPopupWindow();
						} else {
  							document.getElementById('pluginobj').focus();
							pluginobj.SetAgentInfo(angentInfo);
							pluginobj.ShowPopupWindow();
						}
					}

					function addEvent(name, func) {
						if (isIE()) {
							tLFPAPICtrl.focus();
						} else {
							var obj = document.getElementById('pluginobj');
							if (window.addEventListener){   
								obj.addEventListener(name, func, false); 
							}else{   
								obj.attachEvent(name, func);
							}
						}
					}
					
					//重置form表單中的元素
					function resetFinger() {
						
					}
					
					
					function hasGotFeatureEvent() {
						if (isIE()) {
							tp = tLFPAPICtrl.GetFingerPrintData();
						} else {
							tp = pluginobj.GetFingerPrintData();
						}
						$("#fingerData").val(tp);
						updateInfo("identify", "dataForm","result");
					}
				</script>
  </body>
</html>
