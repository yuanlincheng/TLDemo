//重置form表單中的元素
function reset(form) {
	$("#"+form).get(0).reset();   //注意一定要加get(0)
}

function isIE(){ 
		if (!!window.ActiveXObject || "ActiveXObject" in window)
			return true;
		else
			return false;
}

//加載頁面
function loadPage(area,url,form) {
	if(form == ""){
		$("#"+area).load(convertURL(url));
	}else{
		$("#"+area).load(convertURL(url),$("#"+form).serialize());
	}
}

//加時間戳
function convertURL(url) {
	var timstamp = (new Date()).valueOf();
	if (url.indexOf("?") >= 0) {
		url = url + "&t=" + timstamp;
	} else {
		url = url + "?t=" + timstamp;
	}
	return url;
}

//@AcitveXObjectID: 要查找的节点范围，从此节点一下查找待删除的ActiveX。
//@ContianerID: 要删除的ActiveX控件ID。
function ActiveXKiller(AcitveXObjectID,ContianerID){   
	var div = document.getElementById(ContianerID);
    var ocx = document.getElementById(AcitveXObjectID);
    if(ocx != null){
    	div.removeChild(ocx);
    }
} 

//通用于异步更新信息
function updateInfo(url,form,div){
	$.ajax({
   			type: "POST",
  	 		url: convertURL(url),
  	 		dataType: "json",
   			data: $("#"+form).serialize(),
   			success: function(data){
   				var operate = $("#operate").val();
   				if("alert" == operate){
   					alert(data.msg);
   				}else{
   					$("#"+div).html(data.msg);
   				}
   				if("setting" == url){
   					if(data.anyStatu != 1){
   						reset(form);
   					}
   				}else if("verify" != url && "verifyPop" != url){
   					reset(form);
   				}
   				
   				if("enroll" == url || "identify" == url || "verify" == url){
   					resetFinger();
   				}
   			}
	});
}