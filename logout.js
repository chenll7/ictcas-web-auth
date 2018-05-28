//这个脚本不会自动结束
//用于注销断开网络连接
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
    page.evaluate("function(){document.querySelector('#username').value='"+username+"';document.querySelector('#password').value='"+password+"';document.querySelector('#logout').click();}");
  } else {
    console.log("页面载入失败（Page failed to load）。"); 
  }
});
page.onLoadFinished = function () {
  console.log("页面加载结束，URL为"+page.url+"，标题为："+page.title+"。");
};
