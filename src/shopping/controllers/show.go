package controllers

import (
	"github.com/astaxie/beego"
  "shopping/models"
  "shopping/helper"
  "github.com/astaxie/beego/orm"
)

type ShowController struct {
	beego.Controller
}
func (this *ShowController) Additem() {
   pid := helper.Sti(this.GetString("p"))
   //beego.Debug(pid)
   num := helper.Sti(this.GetString("n"))
   beego.Debug("num",num)

   var item models.Item
   beego.Debug("pid",pid)
   var s= item.Additem(pid,int(3),num)
   resultjson := map[string]string{"status":s}
	 this.Data["json"] = &resultjson
	 this.ServeJSON()
}
func (this *ShowController) Showcart() {
   //uid := helper.Sti(this.GetString("u"))
   uid := int(3)
   var maps []orm.Params = models.Queryitems(uid)
   beego.Debug("aaa",maps)
   this.Data["list"] = maps
   this.TplName = "mycart.tpl"
}
func (this *ShowController) Addmin() {
   pid := helper.Sti(this.GetString("p"))
   num := helper.Sti(this.GetString("n"))
   beego.Debug("pid",pid)
   beego.Debug("num",num)
   var item models.Itemnum
   //beego.Debug("pid",pid)
   var s= item.Addmin(pid,num)
   resultjson := map[string]string{"status":s}
	 this.Data["json"] = &resultjson
	 this.ServeJSON()
}
func (this *ShowController) Deleteitem() {
   pid := helper.Sti(this.GetString("p"))
   var item models.Item
   //beego.Debug("pid",pid)
   var s= item.Deleteitem(pid)
   resultjson := map[string]string{"status":s}
	 this.Data["json"] = &resultjson
	 this.ServeJSON()
}

func (this *ShowController) Getorder() {
   ids := this.GetStrings("ids")
   totalp := this.GetString("totp")
   //beego.Debug("idsssss",ids)
   //beego.Debug("totalp",totalp)
   var order models.Order
   //beego.Debug("pid",pid)
   //var s= item.Deleteitem(pid)
   var uid = int(3)
   var remarks = "订单备注"
   var s= order.Addorder(ids,uid,remarks,helper.Stf64(totalp))
   resultjson := map[string]string{"status":s}
	 this.Data["json"] = &resultjson
	 this.ServeJSON()
}
