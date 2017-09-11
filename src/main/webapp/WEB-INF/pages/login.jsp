<%@ page language="java"  pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE HTML>
<html>
  <head>
	 <title><spring:message code="system_name" /></title>
	 <link rel="stylesheet" type="text/css" href="css/easyui.css">
	 <link rel="stylesheet" type="text/css" href="css/icon.css">
	 <script type="text/javascript" src="js/jquery.js"></script>
	 <script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	 <script type="text/javascript">
         $(function () {
             $("#account").focus();
             if ("" != "${msg}") {
                 $("#showMsg").html("${msg}");
             }
         });
         function cleardata() {
             $('#loginForm').form('clear');
         }

         //頁面綁定Enter建
         function BindEnter(obj) {
             if (obj.keyCode == 13) {
                 $("#loginForm").submit();
                 obj.returnValue = false;
             }
         }
		</script>
  </head>
<body onkeydown="BindEnter(event)">
    <div id="loginWin" class="easyui-window" title="登录" style="width:350px;height:188px;padding:5px;"
         minimizable="false" maximizable="false" resizable="false" collapsible="false">
        <div class="easyui-layout" fit="true">
            <div region="center" border="false" style="padding:5px;background:#fff;border:1px solid #ccc;">
                <form id="loginForm" method="post" action="login">
                    <div style="padding:5px 0;">
                        <label for="account">帐号:</label>
                        <input type="text" id = "account" name="account" style="width:260px;" />
                    </div>
                    <div style="padding:5px 0;">
                        <label for="password">密码:</label>
                        <input type="password" id = "password" name="password" style="width:260px;" />
                    </div>
                    <div style="padding:5px 0;text-align: center;color: red;" id="showMsg"></div>
                </form>
            </div>
            <div region="south" border="false" style="text-align:right;padding:5px 0;">
                <a class="easyui-linkbutton" iconcls="icon-ok" href="javascript:void(0)" onclick="login()">登录</a>
            </div>
        </div>
    </div>
</body>
</html>
