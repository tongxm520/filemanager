function updateApp(){
  //检查新版本
  var updateApp = document.getElementById("updateApp");
  updateApp.onclick = function(){
  	var _this = this;
  	$.ajax({
		type:'get',
		url:'http://duni.sinaapp.com/demo/app.php?jsoncallback=?',
		dataType:'jsonp',
		beforeSend : function(){
			_this.innerHTML = "<i class='iconfont updateAppIcon updateAppIconRotate'>&#xe604;</i> 正在检查新版本...";
		},
		success:function(data){
			var newVer = data[0].version;
			if(newVer > appConfig.version){
				var log = data[0].log;
				var downloadUrl = data[0].downloadUrl;
				if(confirm("检查到新版本【"+newVer+"】，是否立即下载？\n 更新日志：\n " + log)){
					var a = document.getElementById("telPhone");
					a.href = downloadUrl;
					a.target = "_blank";
					a.click();
				}
			}else{
				alert("你很潮哦，当前已经是最新版本！");
			}
			_this.innerHTML = "<i class='iconfont updateAppIcon'>&#xe604;</i> 检查新版本";
		},
		error:function(msg){
			_this.innerHTML = "<i class='iconfont updateAppIcon'>&#xe604;</i> 检查新版本";
			alert("检查失败："+msg.message);
		}
	  });
  }
}

