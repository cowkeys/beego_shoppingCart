package controllers

import (
	"github.com/astaxie/beego"
//"shopping/models"
)

type MainController struct {
	beego.Controller
}
func (c *MainController) Get() {
	/*c.Data["Website"] = "beego.me"
	c.Data["Email"] = "astaxie@gmail.com"

	uid := 2
	username := "测试内容"
	password := "2333"
	var usr models.User
	id, err := usr.Add(uid, username, password)
	if err == nil {
    c.Data["errr"] =id
} else{c.Data["errr"] =err}
*/
	c.TplName = "show.tpl"//默认到模板目录Controller/<方法名>.tpl：MainController/index.tpl
	//c.Ctx.WriteString("hello rick")
}
