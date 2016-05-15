package routers

import (
	"shopping/controllers"
	"github.com/astaxie/beego"
)

func init() {
    beego.Router("/", &controllers.MainController{})
		beego.Router("/showcart", &controllers.ShowController{},"get:Showcart")
		beego.Router("/additem", &controllers.ShowController{}, "post:Additem")
		beego.Router("/addmin", &controllers.ShowController{}, "post:Addmin")
		beego.Router("/deleteitem", &controllers.ShowController{}, "post:Deleteitem")
		beego.Router("/order", &controllers.ShowController{}, "post:Getorder")
}
