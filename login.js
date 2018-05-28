//这个脚本不会自己结束
//用于计算所科研楼web认证
var page = require('webpage').create();
phantom.outputEncoding="utf-8";

var fs=require("fs");
var oConfig=JSON.parse(fs.read("config.json"));
var username=oConfig.username;
var password=oConfig.password;

page.open("http://159.226.39.22/srun_portal_pc.php?ac_id=1&", function(status) {
  if ( status === "success" ) {
    console.log("获取页面，页面标题为："+page.title);
    //page.evaluate内是页面的js环境
    page.evaluate("function(){document.querySelector('#username').value='"+username+"';document.querySelector('#password').value='"+password+"';document.querySelector('#button').click();}");
  } else {
    console.log("页面载入失败（Page failed to load）。"); 
  }
});
page.onLoadFinished = function () {
	//页面载入完毕时会调用这个函数
	//一开始在登录页面（http://159.226.39.22/srun_portal_pc.php?ac_id=1&）会进入这个函数
	//登陆成功页面（http://159.226.39.22/srun_portal_pc_succeed.php?...）也会进入这个页面，这时进行判断结束脚本
  console.log("页面加载结束，URL为"+page.url+"，标题为："+page.title+"。");
	//page.render(page.title+'.png');
//	if(page.url.indexOf("http://159.226.39.22/srun_portal_pc_succeed.php")==0){
//		console.log("判断为登陆成功，脚本结束。");
//		phantom.exit(0);
//	}
//	if(page.title=="登录成功"){
//		console.log("判断为登陆成功，脚本结束。");
//		phantom.exit(0);
//	}
	//page.render('example.png');
};
