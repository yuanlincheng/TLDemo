<%@ page language="java"  pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	 <title><spring:message code="system_name" /></title>
	 <link rel="stylesheet" type="text/css" href="css/easyui.css">
	 <link rel="stylesheet" type="text/css" href="css/icon.css">
	 <script type="text/javascript" src="js/jquery.js"></script>
	 <script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	 <script type="text/javascript" src="js/common/common.js"></script>
	 <script type="text/javascript">
			$(function() {
				InitLeftMenu();
				$('body').layout();
				//getAgentInfo();
			})

			function InitLeftMenu() {
				$('.easyui-accordion li a').click(function() {
					var tabTitle = $(this).text();
					addContent(tabTitle);
					$('.easyui-accordion li div').removeClass("selected");
					$(this).parent().addClass("selected");
					//指纹
					close();
					ActiveXKiller("TLFPAPICtrl","fingerDiv");

					//摄像头
					ActiveXKiller("MyPhoto","faceDiv");
				}).hover(function() {
					$(this).parent().addClass("hover");
				}, function() {
					$(this).parent().removeClass("hover");
				});
			}

			function addContent(subtitle) {
				$("div.tabs-header span.tabs-title").text(subtitle);
			}

			function getAgentInfo(){
				$.ajax({
			   			type: "POST",
			  	 		url: "init",
			  	 		dataType: "json",
			   			success: function(data){
			   				if("1" == data.anyStatu){
			   					$("#agentInfo").val(data.msg);
			   				}else{
			   					alert("<spring:message code="init_error" />");
			   				}
			   			}
				});
			}

			function close(){
				var tLFPAPICtrl = document.getElementById("TLFPAPICtrl");
				var pluginobj = document.getElementById("pluginobj");
				if(null != tLFPAPICtrl || null != pluginobj){
					if (isIE()){
					  tLFPAPICtrl.Close();
					}else{
					   document.getElementById("pluginobj").focus();
					   pluginobj.Close();
					}
				}
			}
		</script>
  </head>
<body class="easyui-layout" id="main">
    <div style="display: none;">
    	<input type="hidden" id="agentInfo" name="agentInfo">
    </div>
    <div data-options="region:'north'" style="height: 80px; background: #D2E0F2;" class="top-title-self"><spring:message code="system_name" /></div>
    <div data-options="region:'west',title:'<spring:message code="bar_title" />',split:true" style="width:300px;">
		<div id="menu" class="easyui-accordion" data-options="fit:true">
				<ul id="tt" class="easyui-tree" style="margin-top: 20px;margin-left: 15px;">
					<li><span><spring:message code="finger_operate" /></span>
						<ul>
							<li><span><spring:message code="in" /></span>
								<ul>
									<li><a href="javascript:void(0)" onclick="loadPage('right','load?name=enroll','');"><spring:message code="enroll" /></a></li>
									<li><a href="javascript:void(0)" onclick="loadPage('right','load?name=verify','');"><spring:message code="verify" /></a></li>
									<li><a href="javascript:void(0)" onclick="loadPage('right','load?name=identify','');"><spring:message code="identify" /></a></li>
								</ul>
							</li>
							<li data-options="state:'closed'"><span><spring:message code="pop" /></span>
								<ul>
									<li><a href="javascript:void(0)" onclick="loadPage('right','load?name=enrollPop','');"><spring:message code="enroll_pop" /></a></li>
									<li><a href="javascript:void(0)" onclick="loadPage('right','load?name=verifyPop','');"><spring:message code="verify_pop" /></a></li>
									<li><a href="javascript:void(0)" onclick="loadPage('right','load?name=identifyPop','');"><spring:message code="identify_pop" /></a></li>
								</ul>
							</li>
							<li><a href="javascript:void(0)" onclick="loadPage('right','load?name=query','');"><spring:message code="query_finger" /></a></li>
							<li><a href="javascript:void(0)" onclick="loadPage('right','load?name=delete','');"><spring:message code="delete_finger" /></a></li>
							<li><a href="javascript:void(0)" onclick="loadPage('right','getSetting','');"><spring:message code="change_parameter" /></a></li>
						</ul>
					</li>
					<li data-options="state:'closed'"><span><spring:message code="face_operate" /></span>
						<ul>
							<li><a href="javascript:void(0)" onclick="loadPage('right','load?name=enrollFace','');"><spring:message code="enroll_face" /></a></li>
						</ul>
					</li>
					<li data-options="state:'closed'"><span><spring:message code="idcard_operate" /></span>
						<ul>
							<li><a href="javascript:void(0)" onclick="loadPage('right','load?name=enrollCard','');"><spring:message code="enroll_card" /></a></li>
						</ul>
					</li>
					<li><span><spring:message code="sign_operate" /></span>
						<ul>
							<li><a href="javascript:void(0)" onclick="loadPage('right','load?name=enrollSign','');"><spring:message code="enroll_sign" /></a></li>
						</ul>
					</li>
					<li data-options="state:'closed'"><span>其它操作</span>
						<ul>
							<li><a href="javascript:void(0)" onclick="loadPage('right','load?name=showFpData','');">获取指纹数据</a></li>
							<li><a href="javascript:void(0)" onclick="loadPage('right','load?name=agentVerify','');">客户端比对</a></li>
						</ul>
					</li>
				</ul>
		</div>
	</div>
    <div data-options="region:'center'" id="mainPanle">
    	<div id="content" class="easyui-layout" data-options="fit:true">
		    <div id="tabs" class="easyui-tabs" data-options="fit:true">
					<div id="right"  title="<spring:message code="content" />" data-options="closable:false" style="text-align: center;">

					</div>
			</div>
		</div>
    </div>
    <div data-options="region:'south'" style="height:30px;background: #D2E0F2;"></div>
</body>
<script for="TLFPAPICtrl" event="GotFeatureEvent()" language="javascript">hasGotFeatureEvent();</script>
<script for="CertCtl" event="OnGetIDCardInfo()" language="javascript">OnGetIDCardInfo();</script>
</html>
