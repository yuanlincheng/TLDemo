<%@ page language="java"  pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head></head>
  
  <body>
		<div id="faceDiv">
		<OBJECT ID="MyPhoto" WIDTH=640 HEIGHT=480
 		CLASSID="CLSID:589037E0-8919-4352-9EFD-10A2FB08A1AD">
	</OBJECT>
		</div>
<form id="FReg">
    <table id="TECtrl">  
	<tr>
	<td><INPUT TYPE="button" id="SaveBmpImage" NAME="SaveBmpImage" VALUE="保存BMP文件" ONCLICK=SaveBmp()></td>
	</tr>
	<tr>
	<td><INPUT TYPE="button" id="GetBmpImageData" NAME="GetBmpImageData" VALUE="获取BMP数据" ONCLICK=GetBmp()></td>
	</tr>
	        <tr>        
          <td>
			<fieldset>
				<legend>图像数据</legend>
				<textarea name="Result" id="Result" cols="54" rows="20" style="height:300px"></textarea>
			</fieldset>
       </tr>
	       </table>
  </form>
  		<script type="text/javascript">
  		function SaveBmp()
		{
            var Ret= MyPhoto.SaveBmpImage("c:\\test.bmp")
			if (Ret == '0')
			{
				//alert("保存图像成功");
			}
			else
			{
				alert("保存图像失败");
			}
		}
		function GetBmp()
		{
			 var Ret = MyPhoto.GetBmpImageData();
			 document.getElementById('Result').value = Ret;

		}
  		</script>
  </body>
</html>
