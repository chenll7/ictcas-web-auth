//furrybear(bearcubhaha@gmail.com) 2017-11-27
//这个脚本不会自动结束
//用于断开网络连接
var page = require('webpage').create();
phantom.outputEncoding="utf-8";
page.open("http://159.226.39.22/srun_portal_pc.php?ac_id=1&", function(status) {
	if ( status === "success" ) {
		console.log("获取页面，页面标题为："+page.title);
		//进入页面js环境
		page.evaluate(function(){
			document.querySelector('#logout').click();
		});
	} else {
		console.log("页面载入失败（Page failed to load）。"); 
	}
});
page.onLoadFinished = function () {
	console.log("页面加载结束，URL为"+page.url+"，标题为："+page.title+"。");
};
