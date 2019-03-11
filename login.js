//这个脚本用于登录，它不会自己结束，需要外部中断
var page = require('webpage').create();
phantom.outputEncoding="utf-8";

//获取用户名和密码
var system = require('system');
var env = system.env;
var username=env["USERNAME"];
var password=env["PASSWD"];

console.log(username)
console.log(password)
page.open("https://gw.ict.ac.cn/srun_portal_pc.php?ac_id=1&", function(status) {
  if ( status === "success" ) {
    console.log("获取页面，页面标题为："+page.title);
    page.evaluate("function(){document.querySelector('#username').value='"+username+"';document.querySelector('#password').value='"+password+"';document.querySelector('#button').click();}");
  } else {
    console.log("页面载入失败。");
  }
});
page.onLoadFinished = function () {
  //页面载入完毕时会调用这个函数
  console.log("页面加载结束，URL为"+page.url+"，标题为："+page.title+"。");
};
