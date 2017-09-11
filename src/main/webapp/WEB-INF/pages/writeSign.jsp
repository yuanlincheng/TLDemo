<%@ page language="java"  pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
   
  </head>
  
  <body >
	<table width=”650″     border="2" >
 <tr>
	<td colspan="5" align="center">
	<object align="center"  border="2" id="Screen_Sign" vspace="5" name="Screen_Sign" classid="CLSID:2BCEC88D-D51F-40E8-9F41-500F42D36C08" width="1200" height="600">
    <PARAM NAME="MinPenSize" VALUE="0.1">
    <PARAM NAME="PenSizeLevel" VALUE="1.0">
	<PARAM NAME="Btn1_X" VALUE="8000">
	<PARAM NAME="Btn1_Y" VALUE="8000">
	<PARAM NAME="Btn1_W" VALUE="2000">
	<PARAM NAME="Btn1_H" VALUE="2000">
	<PARAM NAME="Btn2_X" VALUE="4000">
	<PARAM NAME="Btn2_Y" VALUE="8000">
	<PARAM NAME="Btn2_W" VALUE="2000">
	<PARAM NAME="Btn2_H" VALUE="2000">
	<PARAM NAME="Btn3_X" VALUE="1000">
	<PARAM NAME="Btn3_Y" VALUE="8000">
	<PARAM NAME="Btn3_W" VALUE="2000">
	<PARAM NAME="Btn3_H" VALUE="2000">
	</object>
	</td>	
</tr>
</table>
	<script type="text/javascript">
		function Save() {
			document.getElementById("Screen_Sign").SaveImageToFile(
					"C:\\WriteSign.jpg");
		}
		function ClearSign() {
			document.getElementById("Screen_Sign").ClearSign();
		}
		function CloseMset() {
			document.getElementById("Screen_Sign").MouseModeSet(0);
		}
		function OpenMset() {
			document.getElementById("Screen_Sign").MouseModeSet(1);
		}
		function OpenMouse() {
			document.getElementById("Screen_Sign").MouseEnable(1);
		}
		function CloseMouse() {
			document.getElementById("Screen_Sign").MouseEnable(0);
		}
	</script>
	<script language="javascript" for="Screen_Sign"
		event="Btn1ClickEvent()" type="text/javascript">
		ClearSign();
	</script>
	<script language="javascript" for="Screen_Sign"
		event="Btn2ClickEvent()" type="text/javascript">
		Save();
	</script>
	<script language="javascript" for="Screen_Sign"
		event="Btn3ClickEvent()" type="text/javascript">
		ClearSign();
	</script>
</body>
</html>