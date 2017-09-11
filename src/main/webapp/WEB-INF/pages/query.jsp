<%@ page language="java"  pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <style>
			html,body{padding:0;margin:0;font-size:13px;}
			.clearfix:after{content:".";display:block;height:0;clear:both;visibility:hidden}
			* html>body .clearfix{display:inline-block;width:100%}
			* html .clearfix{height:1%;/* End hide from IE-mac */}
			*+html .clearfix{min-height:1%}
			.content{width:889px;padding:40px;margin:0 auto}
			.in{width:341px;height:39px;text-indent:6px;line-height:39px;background:url("images/form_bg.png");border:0;padding:0;margin:0;display:block;float:left}
			.bder{width:341px;height:230px;background:url("images/c_bg.png");text-align:center;padding:3px 0 0 0;display:block;float:left}
			.sub{width:341px;height:39px;text-align:center;line-height:39px;background:url("images/form_bg.png") no-repeat 0 -39px;border:0;padding:0;margin:0;color:white;display:block;float:left}
			.content span{width:235px;height:41px;line-height:41px;text-indent:2em;background:url("images/form_bg.png") no-repeat 0 -78px;display:block;float:left;margin:0 0 0 6px}
			.error{color: red }
		</style>
  </head>
  
  <body >
	<input name="operate" id="operate" type="hidden" value="alert"/> 
	<form id="dataForm" name="dataForm">
		<div class="content">
			<div class="clearfix">
				<input type="text" class="in" id="name" name="name"/>
				<span id="name_ck"><spring:message code="step_input_id" /></span>
			</div>
			<div class="clearfix" style="margin-top: 30px;">
				<input type="button" onclick="queryFinger();" class="sub" value="<spring:message code="query" />" /><span><spring:message code="setp_query_user" /></span>
			</div>
		</div>
	</form>
  		<script type="text/javascript">
			function queryFinger() {
				var name = $("#name").val();
				if(name.replace(/\ /g,'')==""){
					$("#name_ck").addClass("error").html("<spring:message code="require_query_id" />").addClass("");	
					return;
				}else{
					$("#name_ck").removeClass("error").html("<spring:message code="step_input_id" />");	
				}
		      	updateInfo("query","dataForm","result");
			}
  		</script>
  </body>
</html>